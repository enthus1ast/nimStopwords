## This downloads the stop words list from github.
## And converts the json to individual line separated text files,
## that are later used to generate the lookupTable on compile time.
import std/httpclient, json, os

const stopwordsAllUri* = "https://github.com/6/stopwords-json/raw/master/stopwords-all.json"
const stopwordsAllFileName* = "stopwords-all.json"
const tempDir* = "langs"

proc downloadStopwordsAll*() =
  echo "Downloading 'stopwords-all.json' from github"
  var client = newHttpClient()
  if not dirExists(getAppDir() / tempDir):
    createDir(getAppDir() / tempDir)
  client.downloadFile(stopwordsAllUri, getAppDir() / tempDir / stopwordsAllFileName)
  client.close()

proc buildLangFiles*() =
  echo "Building"
  var js = parseFile(getAppDir() / tempDir / stopwordsAllFileName)
  for lang in js.keys:
    echo "build:", lang
    var fh = open(getAppDir() / tempDir / lang , fmWrite)
    for elem in js[lang]:
      fh.writeLine(elem.getStr())

when isMainModule:
  downloadStopwordsAll()
  buildLangFiles()