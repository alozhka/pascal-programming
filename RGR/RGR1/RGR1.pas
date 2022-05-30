PROGRAM CountWords(INPUT, OUTPUT);
USES
  WordsHandler;
CONST
  UniqueWords = 150;
VAR
  FIn, FOut: TEXT;
  Word: STRING;
  WordId, CountWords: INTEGER;
  
BEGIN {CountWords}
  REWRITE(FIn);
  WRITE(FIn, '   ÀÁÂdcK--$DafS-- S  ÃÄÅ');
  RESET(FIn);
  WHILE NOT EOF(INPUT)
  DO
    IF EOLN(INPUT)
    THEN
      READLN(INPUT)
    ELSE
      BEGIN
        Word := WordDefiner(INPUT);
        WRITELN(Word)
      END
END. {CountWords}
