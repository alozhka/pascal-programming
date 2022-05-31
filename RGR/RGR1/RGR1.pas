PROGRAM CountWords(INPUT, OUTPUT);
USES
  TextHandler;
VAR
  WordsDB: ArrayHandler;

BEGIN {CountWords}
  WordsDB := TextHandle(INPUT);
  SortWords(WordsDB);
  PrintWords(OUTPUT, WordsDB)
END. {CountWords}
