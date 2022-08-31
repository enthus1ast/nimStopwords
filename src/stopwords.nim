import os, strutils
import prepare
import macros

macro buildLookupTable*(text: static string): untyped =
  ## builds a case statement for all the words.
  ## ```nim
  ##   case word
  ##   of "the": true
  ##   of "a": true
  ##   # ....
  ##   else: false
  ## ```
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
  # echo repr result

proc isStopWord*(word: string, lang: static string = "en"): bool =
  buildLookupTable(staticRead(tempDir / lang))


echo isStopWord("the")