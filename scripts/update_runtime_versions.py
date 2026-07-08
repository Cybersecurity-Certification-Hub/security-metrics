#!/usr/bin/env python3
"""Update runtime version metrics from endoflife.date v1 APIs.

Fetches release data for configured runtimes and updates metric target values to the
minimum supported version, aligning with the >= comparison used by the metrics. The
script also logs supported and security-only versions for visibility in CI runs.
"""

from __future__ import annotations

import datetime as dt
import json
import re
import sys
import time
import urllib.request
from http.client import RemoteDisconnected
from urllib.error import URLError
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
PLATFORM_ROOT = REPO_ROOT / "metrics" / "PlatformSecurity"

USER_AGENT = "security-metrics-runtime-updater/1.0"

RUNTIMES = {
    "PHP": {
        "product": "php",
        "metric": PLATFORM_ROOT / "PHPRuntime" / "PHPRuntime.yaml",
        "cutoff_key": "eoasFrom",
    },
    "Python": {
        "product": "python",
        "metric": PLATFORM_ROOT / "PythonRuntime" / "PythonRuntime.yaml",
        "cutoff_key": "eoasFrom",
    },
    "Java": {
        "product": "oracle-jdk",
        "metric": PLATFORM_ROOT / "JavaRuntime" / "JavaRuntime.yaml",
        "cutoff_key": "eolFrom",
    },
}


def fetch_text(url: str, retries: int = 3, backoff_seconds: float = 1.0) -> str:
    """Fetch text from a URL with basic retry and backoff behavior."""
    req = urllib.request.Request(
        url,
        headers={
            "User-Agent": USER_AGENT,
            "Accept": "application/json,text/html;q=0.9,*/*;q=0.8",
        },
    )

    for attempt in range(1, retries + 1):
        try:
            with urllib.request.urlopen(req, timeout=30) as resp:
                return resp.read().decode("utf-8", errors="replace")
        except (RemoteDisconnected, URLError, TimeoutError) as exc:
            if attempt >= retries:
                raise RuntimeError(f"Failed to fetch {url}: {exc}") from exc
            time.sleep(backoff_seconds * attempt)


def fetch_json(url: str):
    """Fetch JSON data from a URL and decode it into Python objects."""
    return json.loads(fetch_text(url))


def parse_supported_version(
    releases: list[dict], *, cutoff_key: str = "eolFrom"
) -> tuple[str, list[str], list[str]]:
    """Choose the minimum supported version and list supported/security-only versions."""
    today = dt.date.today()

    def parse_date(value: str | None) -> dt.date | None:
        """Parse a YYYY-MM-DD date string into a date object."""
        if not value:
            return None
        try:
            return dt.date.fromisoformat(value)
        except ValueError:
            return None

    def is_supported(item: dict) -> bool:
        """Return True when a release is still supported by the cutoff date."""
        cutoff = parse_date(item.get(cutoff_key))
        if cutoff is None:
            return not item.get("isEol", False)
        return cutoff > today

    def is_security_supported(item: dict) -> bool:
        """Return True when a release is in security-only support (EOAS <= today < EOL)."""
        eoas = parse_date(item.get("eoasFrom"))
        eol = parse_date(item.get("eolFrom"))
        if eoas is None or eol is None:
            return False
        return eoas <= today < eol

    candidates = [item for item in releases if is_supported(item)]
    if not candidates:
        raise RuntimeError("No supported versions found in endoflife.date v1 data.")

    def version_key(item: dict):
        """Extract a sortable version key from a release name."""
        parts = re.findall(r"\d+", str(item["name"]))
        return tuple(int(p) for p in parts)

    chosen = min(candidates, key=version_key)
    supported_versions = [str(item["name"]) for item in sorted(candidates, key=version_key)]
    security_versions = [
        str(item["name"]) for item in sorted(releases, key=version_key) if is_security_supported(item)
    ]
    return str(chosen["name"]), supported_versions, security_versions


def update_target_value(path: Path, value: str) -> bool:
    """Update the targetValue in a metric YAML file when it differs."""
    content = path.read_text(encoding="utf-8")
    pattern = re.compile(r"(^\s*targetValue:\s*)(.+)$", flags=re.MULTILINE)
    match = pattern.search(content)
    if not match:
        raise RuntimeError(f"Unable to find targetValue in {path}.")

    current = match.group(2).strip()
    if current == value:
        return False

    updated = pattern.sub(r"\g<1>" + value, content, count=1)
    path.write_text(updated, encoding="utf-8")
    return True


def parse_operator_from_yaml(path: Path) -> str:
    """Parse the operator for p1 from a metric YAML file."""
    content = path.read_text(encoding="utf-8")
    m = re.search(r"p1:\s*\n\s*operator:\s*([\"']?)([^\"'\n]+)\1", content, flags=re.MULTILINE)
    if m:
        return m.group(2).strip()
    m2 = re.search(r"operator:\s*([\"']?)([^\"'\n]+)\1", content)
    if m2:
        return m2.group(2).strip()
    raise RuntimeError(f"Unable to find operator in {path}.")


def coerce_value(value: str):
    """Coerce a version string to int/float when sensible, otherwise leave as string."""
    if re.fullmatch(r"\d+", value):
        return int(value)
    if re.fullmatch(r"\d+\.\d+$", value):
        return float(value)
    return value


def update_data_json(path: Path, operator: str, target_value) -> bool:
    """Create or update a metric's data.json with the given operator and target_value."""
    desired = {"operator": operator, "target_value": target_value}
    if path.exists():
        try:
            current = json.loads(path.read_text(encoding="utf-8"))
        except Exception:
            current = {}
        if current.get("operator") == desired["operator"] and current.get("target_value") == desired["target_value"]:
            return False
    path.write_text(json.dumps(desired, indent=4) + "\n", encoding="utf-8")
    return True


def main() -> int:
    """Run the updater and print a summary of changes."""
    changes = []
    for language, config in RUNTIMES.items():
        data = fetch_json(f"https://endoflife.date/api/v1/products/{config['product']}/")
        releases = data.get("result", {}).get("releases", [])
        version, supported_versions, security_only = parse_supported_version(
            releases,
            cutoff_key=config.get("cutoff_key", "eolFrom"),
        )

        print(
            f"{language}: total releases={len(releases)}, security_only={security_only}, "
            f"supported={supported_versions}, selected={version} "
            f"(cutoff={config.get('cutoff_key', 'eolFrom')})"
        )

        metric_path = config["metric"]
        updated_yaml = update_target_value(metric_path, version)

        # Also update the metric's data.json with operator and target_value when present
        data_path = metric_path.parent / "data.json"
        try:
            operator = parse_operator_from_yaml(metric_path)
        except RuntimeError:
            operator = ">="
        updated_json = update_data_json(data_path, operator, coerce_value(version))

        if updated_yaml or updated_json:
            changes.append(f"{language} -> {version}")

    if changes:
        print("Updated runtime versions: " + ", ".join(changes))
    else:
        print("No updates needed.")

    return 0


if __name__ == "__main__":
    sys.exit(main())
