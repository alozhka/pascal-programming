PROGRAM CountWords(INPUT, OUTPUT);
USES
  TextHandler;
VAR
  WordsTree: Tree;

BEGIN {CountWords}
  WordsTree := NIL;
  WordsTree := TextHandle(INPUT);
  PrintTree(OUTPUT, WordsTree);
  WRITELN('¬сего ', CWords, ' слов, из них уникальных: ', CUniqueWords)
END. {CountWords}
//рекомендую почитать формулировку 
//задани€ rgr и полезный комментарий
