version     = "0.0.2"
author      = "enthus1ast"
description = "Identify 'stopWords' "
license     = "MIT"

srcDir = "src"

requires "nim >= 1.2.2"


after install:
  # Download stopwords json file
  # and prepare lists of words for later
  exec "nim c -d:release -r prepare.nim"