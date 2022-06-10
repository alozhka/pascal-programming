UNIT TextHandler;
INTERFACE
CONST
  IterationQuantity = 500;
TYPE
  WordHandle = RECORD
    Value: STRING[32];
    Amount: INTEGER
  END;
  Tree = ^NodeType;
  NodeType = RECORD
    Word: WordHandle;
    LLink, RLink: Tree
  END;
VAR
  CWords, CUniqueWords: LONGINT;
  CIterWords: INTEGER;
FUNCTION TextHandle(VAR FIn: TEXT): Tree;
PROCEDURE PrintTree(VAR FOut: TEXT; Ptr: Tree);
IMPLEMENTATION


USES
  WordsHandler;


PROCEDURE Insert(VAR Ptr: Tree; Data: WordHandle);
BEGIN {Insert}
  IF Ptr = NIL
  THEN
    BEGIN {Создаем лист со значением Data}
      NEW(Ptr);
      Ptr^.Word := Data;
      Ptr^.LLink := NIL;
      Ptr^.RLink := NIL;
      CIterWords := CIterWords + 1
    END
  ELSE
    BEGIN
      IF Data.Value = Ptr^.Word.Value
      THEN
        Ptr^.Word.Amount := Ptr^.Word.Amount + 1;
      IF Data.Value < Ptr^.Word.Value
      THEN
        Insert(Ptr^.LLink, Data);
      IF Data.Value > Ptr^.Word.Value
      THEN
        Insert(Ptr^.RLink, Data)
    END
END; {Insert}


FUNCTION TextHandle(VAR FIn: TEXT): Tree;
VAR
  Word: WordHandle;
  TreeGragh: Tree;
BEGIN {TextHandle}
  Word.Amount := 1;
  TreeGragh := NIL;
  CIterWords := 0;
  WHILE (NOT EOF(FIn)) AND (CIterWords < IterationQuantity)
  DO
    IF EOLN(FIn)
    THEN
      READLN(FIn)
    ELSE
      BEGIN
        CWords := CWords + 1;
        Word.Value := WordDefiner(FIn);
        Insert(TreeGragh, Word)
      END;
  TextHandle := TreeGragh
END; {TextHandle}


PROCEDURE PrintTree(VAR FOut: TEXT; Ptr: Tree);
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN {Печатает поддерево слева, вершину, поддерево справа}
    BEGIN
      PrintTree(FOut, Ptr^.LLink);
      WRITELN(FOut, Ptr^.Word.Value, ' ', Ptr^.Word.Amount);
      PrintTree(FOut, Ptr^.RLink)
    END
END; {PrintTree}

  
BEGIN {UNIT TextHandler}
  CWords := 0;
  CUniqueWords := 0;
END. {UNIT TextHandler}
