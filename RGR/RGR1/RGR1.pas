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
  WRITE(FIn, '   ���dcK--$DafS-- S  ���');
  RESET(FIn);
  WHILE (NOT EOLN(FIn)) AND
  DO
    BEGIN
      Word := WordDefiner(FIn);
      WRITELN(Word)
    END
END. {CountWords}
