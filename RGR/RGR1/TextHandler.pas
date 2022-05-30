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
    Amount: INTEGER;
    NextId: WordsRange
  END;
  ArrayHandler = ARRAY[UniqueWordsRange] OF WordHandle;
VAR
  CUniqueWords: UniqueWordsRange;
FUNCTION TextHandle(VAR FIn: TEXT): ArrayHandler;
PROCEDURE PrintWords(VAR FOut: TEXT; Arr: ArrayHandler);
IMPLEMENTATION

USES
  WordsHandler;
TYPE
  ArrayWords = ARRAY[WordsRange] OF STRING;
VAR
  Words: ArrayHandler;
  Key, FirstId:  WordsRange;

 
PROCEDURE SortWords(VAR Arr: ArrayHandler; VAR Index: WordsRange);
VAR
  PrevId, CurrId: WordsRange;
  Found: BOOLEAN;
BEGIN {SortWords}
  PrevId := 0;
  CurrId := FirstId;
  Found := FALSE;
  WHILE (CurrId <> 0) AND (NOT Found)
  DO
    IF Arr[Index].Value > Arr[CurrId].Value
    THEN
      BEGIN
        PrevId := CurrId;
        CurrId := Arr[CurrId].NextId
      END
    ELSE
      Found := TRUE;
  Arr[Index].NextId := CurrId;
  IF PrevId = 0  {Первый элемент в списке}
  THEN
    FirstId := Index
  ELSE
    Arr[PrevId].NextId := Index
END; {SortWords}

FUNCTION IsStringHigher(Str1, Str2: STRING): BOOLEAN;
VAR
  I: INTEGER;
  Sorted: BOOLEAN;
BEGIN {IsStringBelow}
  I := 0;
  {WHILE I <= TextLength
  DO
    Sorted := }
  IsStringHigher := TRUE
END; {IsStringBelow}
 
FUNCTION TextHandle(VAR FIn: TEXT): ArrayHandler;
VAR
  CWords, I, Index, J: WordsRange;
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
        //It's sorting TIME
        Index := CUniqueWords;
        SortWords(Words, Index)
      END;
  TextHandle := Words
END; {TextHandle}


PROCEDURE PrintWords(VAR FOut: TEXT; Arr: ArrayHandler);
VAR
  Index, I: WordsRange;
BEGIN
  Index := FirstId;
  I := 0;
  WHILE Index <> 0
  DO
    BEGIN
      WRITELN(FOut, I, Arr[Index].Value, ' ', Arr[Index].Amount);
      INC(I);  
      Index := Arr[Index].NextId
    END;
END;

  
BEGIN {UNIT TextHandler}
  Firstid := 1;
  FOR Key := 1 TO TextLength
  DO
    Words[Key].Amount := 0
END. {UNIT TextHandler}
