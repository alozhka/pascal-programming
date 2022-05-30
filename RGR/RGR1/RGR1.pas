PROGRAM CountWords(INPUT, OUTPUT);
USES
  WordsHandler;
CONST
  UniqueWords = 150;
VAR
  Words: ArrayHandler;
  Word: STRING;
  WordId, CountWords, I: INTEGER;
  UniqueWord: BOOLEAN;
  
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
        Words[I].Value := WordDefiner(INPUT);
        I := I + 1
      END;
  TextHandler := Words
END;
END. {CountWords}
