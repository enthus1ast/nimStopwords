import ../src/stopwords

assert true == isStopWord("the", lang = "en")
assert true == isStopWord("der", lang = "de")
assert false == isStopWord("hallo", lang = "de")
assert false == isStopWord("foo", lang = "en")