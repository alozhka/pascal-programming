PROGRAM TestTypeFiles(INPUT, OUTPUT);
USES
  TextHandler;
TYPE
  WordHandle = RECORD
    Value: STRING[32];
    Amount: LONGINT
  END;
  WordsFile = FILE OF WordHandle;
VAR
  FWords: WordsFile;
  Word: WordHandle;
  Str: STRING;


{PROCEDURE Init(VAR FIn: TEXT; VAR FW: WordsFile);
BEGIN
  WHILE NOT EOLN(FIn)
  DO
    BEGIN   
      Word.Value := WordDefiner(FIn);
      WRITE(OUTPUT, Word.Value);
      WRITE(FWords, Word)
    END
END;}

BEGIN
  ASSIGN(FWords, 'Test.dat');
  REWRITE(FWords);
  
  Word.Amount := 1;
  TextHandle(INPUT, FWords);
  Seek(FWords, 1);
  Word.Value := 'd';
  WRITE(FWords, Word);
  Seek(FWords, 0);
  WHILE NOT EOF(FWords)
  DO
    BEGIN
      READ(FWords, Word);
      WRITELN(Word.Value, ' ', Word.Amount);
    END;
  WRITELN(FileSize(FWords));
  CLOSE(FWords)
END.
