PROGRAM CountWords(INPUT, OUTPUT);
USES
  WordsHandler;
CONST
  UniqueWords = 150;
VAR
  Word: STRING;
  WordId, CountWords, I: INTEGER;
  UniqueWord: BOOLEAN;
  Words: ArrayHandler;
  
BEGIN {CountWords}
  {REWRITE(FIn);
  WRITE(FIn, '   ÀÁÂdcK--$DafS-- S  ÃÄÅ');
  RESET(FIn);}
  I := 1;
  CountWords := 0;
  UniqueWord := FALSE;
  WHILE (NOT EOF(INPUT)) AND (I <= UniqueWords)
  DO
    IF EOLN(INPUT)
    THEN
      READLN(INPUT)
    ELSE
      BEGIN
        Word := WordDefiner(INPUT);
        I := I + 1
      END
END. {CountWords}
