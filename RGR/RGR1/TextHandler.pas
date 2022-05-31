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
  ArrayHandler = ARRAY[UniqueWordsRange] OF WordHandle;
VAR
  CUniqueWords: UniqueWordsRange;
  CWords: WordsRange;
FUNCTION TextHandle(VAR FIn: TEXT): ArrayHandler;
PROCEDURE SortWords(VAR Words: ArrayHandler);
PROCEDURE PrintWords(VAR FOut: TEXT; Arr: ArrayHandler);
IMPLEMENTATION

USES
  WordsHandler;
TYPE
  ArrayWords = ARRAY[WordsRange] OF STRING;
VAR
  Words: ArrayHandler;
  Key, FirstId:  WordsRange;

 
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


PROCEDURE SortWords(VAR Words: ArrayHandler);
VAR
  I, J: INTEGER;
  Temp: WordHandle;
BEGIN {SortWords}
  FOR I := 1 TO CUniqueWords
  DO
    FOR J := I + 1 TO CUniqueWords
    DO
      IF Words[I].Value > Words[J].Value
      THEN
        BEGIN
          Temp := Words[I];
          Words[I] := Words[J];
          Words[J] := Temp
        END
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

  
BEGIN {UNIT TextHandler}
  FirstId := 1;
  FOR Key := 1 TO TextLength
  DO
    Words[Key].Amount := 0
END. {UNIT TextHandler}
