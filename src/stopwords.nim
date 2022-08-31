## Put your tests here.

import benchy
import json
import os, strutils
import prepare
import sets

# var js = parseFile(getAppDir() / tempDir / stopwordsAllFileName)
# # echo js["en"]

# for lang in js.keys:
#   echo "build:", lang
#   var fh = open(getAppDir() / lang & ".txt", fmWrite)
#   for elem in js[lang]:
#     fh.writeLine(elem.getStr())





import macros
import strutils


macro buildLookupTable*(text: static string): untyped =
  ## builds a case statement for all the words.
  ## case word
  ## of "foo":
  result = newStmtList()
  var cst = nnkCaseStmt.newTree(newIdentNode("word"))

  for line in text.splitLines():
    if line.isEmptyOrWhitespace(): continue
    cst.add nnkOfBranch.newTree(
      newLit(line.strip()),
      nnkStmtList.newTree(
        nnkReturnStmt.newTree(
          newIdentNode("true")
        )
      )
    )
  cst.add nnkElse.newTree(
    nnkStmtList.newTree(
      nnkReturnStmt.newTree(
        newIdentNode("false")
      )
    )
  )
  result.add cst
  echo repr result


proc isStopWord*(word: string, lang: static string = "en"): bool =
  const words = staticRead(tempDir / lang)
  buildLookupTable(words)

# nnkStmtList.newTree(
#   nnkCaseStmt.newTree(
#     newIdentNode("word"),
#     nnkOfBranch.newTree(
#       newLit("foo"),
#       nnkStmtList.newTree(
#         nnkReturnStmt.newTree(
#           newIdentNode("true")
#         )
#       )
#     ),
#     nnkOfBranch.newTree(
#       newLit("baa"),
#       nnkStmtList.newTree(
#         nnkReturnStmt.newTree(
#           newIdentNode("true")
#         )
#       )
#     ),
#     nnkElse.newTree(
#       nnkStmtList.newTree(
#         nnkReturnStmt.newTree(
#           newIdentNode("false")
#         )
#       )
#     )
#   )
# )

# var ens = initHashSet[string]()
# for elem in js["en"]:
#   ens.incl elem.getStr()

# import en2

# timeIt "hs":
#   for idx in 0..1000:
#     keep ens.contains("normally")

# timeIt "nim":
#   for idx in 0..1000:
#     keep isStopWord("normally")

# timeIt "nim de":
#   for idx in 0..1000:
#     keep isStopWord("der", lang = "de")

echo isStopWord("the", lang = "en")
echo isStopWord("der", lang = "de")
echo isStopWord("hallo", lang = "de")