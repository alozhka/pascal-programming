PROGRAM CountWords(INPUT, OUTPUT);
USES
  TextHandler;
VAR
  WordsDB: ArrayHandler;
  WordsTree: Tree;

BEGIN {CountWords}
  WordsTree := NIL;
  WordsDB := TextHandle(INPUT);
  SortWords(WordsTree, WordsDB);
  PrintTree(OUTPUT, WordsTree)
END. {CountWords}
