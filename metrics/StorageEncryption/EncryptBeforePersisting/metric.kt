/**
 * This query checks whether each path leading to a persistent data sink encrypts the data before
 * writing it to the sink. By default, it considers [WriteFile] nodes as persistent sinks and looks
 * for [EncryptionOperation] nodes in the data and execution flow. What is considered as a
 * persistent sink and how to extract the written data can be customized by providing the
 * [isPersistentSink] and [writtenData] functions, respectively.
 */
@AssessesMetrics("AtRestEncryptionEnabled")
@RepresentsEvidences("E70")
context(translationResult: TranslationResult, cryptoCatalog: CryptoCatalog)
fun dataEncryptedBeforePersisting(
    isSensitiveData: (Node) -> Boolean = { true },
    isPersistentSink: (Node) -> Boolean = { it is WriteFile || it is DatabaseOperation },
    writtenData: (Node) -> List<Node>? = {
        (it as? WriteFile)?.what?.let { listOf(it) } ?: (it as? DatabaseQuery)?.parameters
    },
): QueryTree<Boolean> {
    return translationResult
        .allExtended<Node>(isPersistentSink) {
            val writtenData =
                writtenData(it)
                    ?: return@allExtended QueryTree(
                            value = true,
                            stringRepresentation = "Missing data written to a persistent location",
                            node = it,
                            operator = GenericQueryOperators.EVALUATE,
                        )
                        .assume(
                            AssumptionType.CompletenessAssumption,
                            "We did not find the data written to the persistent sink which might lead to false positives. This behavior is strange as the sink should typically have a way to persist data.\n\nTo verify this assumption, please check if the sink has indeed no way to persist data. To fix this issue, either specify the way how to identify data (by providing an improved `writtenData` argument or consider removing the sink from the `isPersistentSink` argument.",
                        )
            writtenData
                .map { data -> data.alwaysCorrectlyEncrypted(isSensitiveData) }
                .mergeWithAll()
                .apply {
                    stringRepresentation =
                        if (value) "Data is always encrypted before being persisted to the sink."
                        else "Data is not always encrypted before being persisted to the sink."
                }
        }
        .apply {
            stringRepresentation =
                if (value)
                    "For each operation persisting data, the data is always encrypted with state of the art algorithms before being persisted."
                else
                    "For some operations persisting data, the data is not encrypted with state of the art algorithms before being persisted."
        }
}