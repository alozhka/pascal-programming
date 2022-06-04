UNIT TextHandler;
INTERFACE
CONST
  TextLength = 500;
  UniqueWords = 500;
TYPE
  WordsRange = 0 .. TextLength;
  UniqueWordsRange = 0 .. UniqueWords;
  WordHandle = RECORD
    Value: STRING;
    Amount: INTEGER
  END;
  Tree = ^NodeType;
  NodeType = RECORD
    Word: WordHandle;
    LLink, RLink: Tree
  END;
  ArrayHandler = ARRAY[UniqueWordsRange] OF WordHandle;
VAR
  CUniqueWords: UniqueWordsRange;
  CWords: WordsRange;
PROCEDURE TextHandle(VAR FIn, FOut: TEXT);  //лучше функцией c возвратом FOut, 
                                            //так логичней выглядит
PROCEDURE SortWords(VAR Root: Tree; VAR Words: ArrayHandler);
PROCEDURE PrintTree(VAR FOut: TEXT; Ptr: Tree);
PROCEDURE PrintWords(VAR FOut: TEXT; Arr: ArrayHandler);
IMPLEMENTATION

USES
  WordsHandler;
VAR
  Root: Tree;
  Words: ArrayHandler;
  Key, FirstId:  WordsRange;


FUNCTION CopyCountStrFile(VAR FIn, FOut: TEXT): INTEGER;
VAR
  Ch: CHAR;
  StrNum: INTEGER;
BEGIN {CopyCountStrFile}
  StrNum := 0;
  WHILE NOT EOF(FIn)
  DO
    IF NOT EOLN(FIn)
    THEN
      BEGIN
        READ(FIn, Ch);
        WRITE(FOut, Ch)
      END
    ELSE
      BEGIN
        READLN(FIn);
        StrNum := StrNum + 1;
        WRITELN(FOut)
      END;
  CopyCountStrFile := StrNum
END; {CopyCountStrFile}


PROCEDURE CopyFileInRange(VAR FIn, FOut: TEXT; InitialStr, FinalStr: INTEGER);
VAR
  Ch: CHAR;
  I: INTEGER;
BEGIN {CopyFileInRange}
  IF (InitialStr > 0) AND (FinalStr > InitialStr)
  THEN
    FOR I := InitialStr TO FinalStr
    DO
      BEGIN
        READ(FIn, Ch);
        WRITE(FOut, Ch)
      END
END; {CopyFileInRange}
 
 
PROCEDURE TextHandle(VAR FIn, FOut: TEXT);
VAR
  StrNum: LONGINT;
  UniqueWord: BOOLEAN;
  Word: STRING;
  CopyOut: TEXT;
  Words: ArrayHandler;
BEGIN {TextHandle}
  REWRITE(CopyOut);
  CWords := 0;
  CUniqueWords := 0;
  WHILE NOT EOF(FIn)
  DO
    IF EOLN(FIn)
    THEN
      READLN(FIn)
    ELSE
      IF CUniqueWords > 0
      THEN
        BEGIN
          CopyFileInRange(FIn, FOut, CUniqueWords, StrNum)
        END
      ELSE
        WRITELN(FOut, Word, ' 1');
END; {TextHandle}


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


PROCEDURE SortWords(VAR Root: Tree; VAR Words: ArrayHandler);
VAR
  I: INTEGER;
BEGIN {SortWords}
  FOR I := 1 TO CUniqueWords
  DO
    Insert(Root, Words[I])
END; {SortWords}


PROCEDURE PrintWords(VAR FOut: TEXT; Arr: ArrayHandler);
VAR
  I: WordsRange;
BEGIN
  FOR I := 1 TO CUniqueWords
  DO
    WRITELN(FOut, Arr[I].Value, ' ', Arr[I].Amount);
  WRITELN('Всего слов: ', CWords, ', из них уникальных: ', CUniqueWords)
END;


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
  FirstId := 1;
  FOR Key := 1 TO TextLength
  DO
    Words[Key].Amount := 0
END. {UNIT TextHandler}
