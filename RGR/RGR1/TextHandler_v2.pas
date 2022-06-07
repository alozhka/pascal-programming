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
FUNCTION TextHandle(VAR FIn: TEXT): ArrayHandler;
PROCEDURE SortWords(VAR Root: Tree; VAR Words: ArrayHandler);
PROCEDURE PrintTree(VAR FOut: TEXT; Ptr: Tree);
IMPLEMENTATION

USES
  WordsHandler;
VAR
  Root: Tree;
  Words: ArrayHandler;
  Key, FirstId:  WordsRange;

{На каждом проходе считываем слово с количеством повторений,
сравниваем каждое со вставляемым(новым) слово, 
если НЕТ, то вставляем в конец файла + кол-во = 1;
если ДА, то считывае} 
FUNCTION TextHandle(VAR FIn: TEXT): ArrayHandler;
VAR
  I, Index, J: WordsRange;
  UniqueWord: BOOLEAN;
  Word: STRING;
BEGIN {TextHandle}
  I := 1;
  CWords := 0;
  CUniqueWords := 0;
  WHILE (NOT EOF(FIn)) AND (I <= TextLength)
  DO
    IF EOLN(FIn)
    THEN
      READLN(FIn)
    ELSE
      BEGIN
        J := 1;
        Word := WordDefiner(FIn);
        UniqueWord := TRUE;
        WHILE J <= TextLength
        DO
          BEGIN
            IF Word = Words[J].Value
            THEN
              BEGIN
                UniqueWord := FALSE;
                Words[J].Amount := Words[J].Amount + 1;
                CWords := CWords + 1
              END;
            J := J + 1
          END;
        IF UniqueWord
        THEN
          BEGIN
            CWords := CWords + 1;
            CUniqueWords := CUniqueWords + 1;
            Words[CUniqueWords].Value := Word;
            Words[CUniqueWords].Amount := Words[CUniqueWords].Amount + 1
          END;
        I := I + 1;
      END;
  TextHandle := Words
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
