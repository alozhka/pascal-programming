UNIT TextHandler;
INTERFACE
TYPE
  WordHandle = RECORD
    Value: STRING;
    Amount: LONGINT
  END;
  WordsFile = FILE OF WordHandle;
  Tree = ^NodeType;
  NodeType = RECORD
    Word: WordHandle;
    LLink, RLink: Tree
  END;
VAR
  CUniqueWords, CWords: LONGINT;
PROCEDURE TextHandle(VAR FIn: TEXT; VAR FW: WordsFile);
PROCEDURE SortWords(VAR Root: Tree; VAR Words: WordsFile);
PROCEDURE PrintWords(VAR FOut: TEXT; VAR FW: WordsFile);
PROCEDURE PrintTree(VAR FOut: TEXT; Ptr: Tree);
IMPLEMENTATION


USES
  WordsHandler;
VAR
  Root: Tree;
 
 
PROCEDURE TextHandle(VAR FIn: TEXT; VAR FW: WordsFile);
VAR
  Word, CurrWord: WordHandle;
  UniqueWord: BOOLEAN;
  I: LONGINT;
BEGIN {TextHandle}
  IF NOT EOLN(FIn)
  THEN
    BEGIN
      Word.Value := WordDefiner(FIn);
      Word.Amount := 1;
      WRITE(FW, Word)
    END;
  WHILE NOT EOLN(FIn)
  DO
    BEGIN
      Word.Value := WordDefiner(FIn);
      RESET(FW);
      UniqueWord := TRUE;
      FOR I := 0 TO FileSize(FW)
      DO
        BEGIN
          READ(FW, CurrWord);
          IF CurrWord.Value = Word.Value
          THEN
            BEGIN
              UniqueWord := FALSE;
              Seek(FW, I);
              CurrWord.Amount := CurrWord.Amount + 1;
              WRITE(FW, CurrWord)
            END
        END;
      IF UniqueWord
      THEN
        BEGIN
          Seek(FW, FileSize(FW));
          WRITE(FW, Word)
        END
    END
END; {TextHandle}

PROCEDURE PrintWords(VAR FOut: TEXT; VAR FW: WordsFile);
VAR
  Word: WordHandle;
BEGIN {PrintWords}
  WHILE NOT EOF(FW)
  DO
    BEGIN
      READ(FW, Word);
      WRITELN(FOut, Word.Value, ' ', Word.Amount);
    END 
END; {PrintWords}


PROCEDURE Insert(VAR Ptr: Tree; Data: WordHandle);
BEGIN {Insert}
  IF Ptr = NIL
  THEN
    BEGIN {Создаем лист со значением Data}
      NEW(Ptr);
      Ptr^.Word := Data;
      Ptr^.LLink := NIL;
      Ptr^.RLink := NIL
    END
  ELSE
    IF Ptr^.Word.Value > Data.Value
    THEN
      Insert(Ptr^.LLink, Data)
    ELSE
      Insert(Ptr^.RLink, Data)
END; {Insert}


PROCEDURE SortWords(VAR Root: Tree; VAR Words: WordsFile);
VAR
  I: INTEGER;
BEGIN {SortWords}
END; {SortWords}


PROCEDURE PrintTree(VAR FOut: TEXT; Ptr: Tree);
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN {Печатает поддерево слева, вершину, поддерево справа}
    BEGIN
      PrintTree(FOut, Ptr^.LLink);
      WRITELN(FOut, Ptr^.Word.Value, ' ', Ptr^.Word.Amount);
      PrintTree(FOut, Ptr^.RLink)
    END;
END; {PrintTree}

  
BEGIN {UNIT TextHandler}
END. {UNIT TextHandler}
