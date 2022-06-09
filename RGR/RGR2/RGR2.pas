PROGRAM CountWords(INPUT, OUTPUT);
USES
  TextHandler,
  FilesHandler;
VAR
  WordsTree: Tree;


BEGIN {CountWords}
  WordsTree := NIL;
  WordsTree := TextHandle(INPUT);
  PrintTree(OUTPUT, WordsTree);
  WRITELN('Всего ', CWords, ' слов, из них уникальных: ', CUniqueWords);
END. {CountWords}
