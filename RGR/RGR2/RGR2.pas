PROGRAM CountWords(INPUT, OUTPUT);
USES
  TextHandler;
VAR
  FWords: WordsFile;
  WordsTree: Tree;

BEGIN {CountWords}
  ASSIGN(FWords, 'WordsDB.dat');
  REWRITE(FWords);
  TextHandle(INPUT, FWords);
  RESET(FWords);
  PrintWords(OUTPUT, FWords);
  WordsTree := NIL;
  CLOSE(FWords)
END. {CountWords}
