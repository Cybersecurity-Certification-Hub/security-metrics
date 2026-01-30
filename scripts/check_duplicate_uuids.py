#!/usr/bin/env python3
""" Script to validate that all metric UUIDs in the metrics folder are unique. """

import yaml
import glob
import sys
import os

ids = {}
duplicates = []

# Only scan .yaml files within the metrics folder and its subdirectories
search_path = "metrics/**/*.yaml"
files = glob.glob(search_path, recursive=True)

print(f"Scanning {len(files)} files in metrics/...")

for filename in files:
    try:
        with open(filename, "r") as f:
            # Using safe_load_all to handle potential multi-document YAML files
            data_list = yaml.safe_load_all(f)
            
            for data in data_list:
                # Check if the document is a dictionary and contains an "id" field
                if isinstance(data, dict) and "id" in data:
                    val = str(data["id"]).strip().lower()
                    if val in ids:
                        duplicates.append(f"Conflict for ID \"{val}\" found in metrics: \n{filename} and \n{ids[val]}")
                    else:
                        ids[val] = filename
    except Exception as e:
        print(f"Error reading {filename}: {e}")

if duplicates:
    print("❌ Duplicate UUIDs detected in metrics folder:")
    for d in duplicates:
        print(d)
    sys.exit(1)
else:
    print("✅ All UUIDs are unique within the metrics folder.")
