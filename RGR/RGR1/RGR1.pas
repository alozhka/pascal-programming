PROGRAM CountWords(INPUT, OUTPUT);
USES
  TextHandler;
VAR
  WordsDB: ArrayHandler;
  I: INTEGER;

BEGIN {CountWords}
  WordsDB := TextHandle(INPUT);
  {FOR I := 1 TO CUniqueWords
  DO
    WRITELN(I:2, ' ', WordsDB[I].Value, ' ', WordsDB[I].Amount);}
  PrintWords(OUTPUT, WordsDB);
END. {CountWords}
