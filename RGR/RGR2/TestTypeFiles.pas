PROGRAM TestTypeFiles(INPUT, OUTPUT);
USES
  WordsHandler;
TYPE
  WordHandle = RECORD
    Value: STRING;
    Amount: LONGINT
  END;
  WordsFile = FILE OF WordHandle;
VAR
  FWords: WordsFile;
  Word: WordHandle;
  Str: STRING;

BEGIN
  {ASSIGN(FWords, 'Test.dat');
  REWRITE(FWords);
  
  Word.Amount := 1;}
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN   
      Str := WordDefiner(INPUT);
      WRITE(OUTPUT, Str);
      //WRITE(FWords, Word)
    END;
  
  {Seek(FWords, 0);
  Word.Value := '01';
  Word.Amount := 999;
  READ(FWords, Word);
  WRITELN(Word.Value, ' ', Word.Amount);
  
  WRITELN(FileSize(FWords))}
END.
