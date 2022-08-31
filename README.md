# nimStopwords

> Stop word
>
> Fom Wikipedia, the free encyclopedia
>
> Stop words are the words in a stop list (or stoplist or negative dictionary) which are filtered out (i.e. stopped) before or after processing of natural language data (text) because they are insignificant


A small library that utilized the stop words from:
https://github.com/6/stopwords-json/raw/master/stopwords-all.json

And provides:

```isStopWord("the", lang = "en")```


It build a lookup table on compile time, so this is very fast.

