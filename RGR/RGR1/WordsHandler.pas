UNIT WordsHandler;
INTERFACE
  FUNCTION WordDefiner(VAR Text: TEXT): STRING;
IMPLEMENTATION

CONST
  UniqueWords = 150;
TYPE
  UpperChars = 'A' .. 'Я';
  LowerChars = 'a' .. 'я';
  UpperSet = SET OF UpperChars;
  LowerSet = SET OF LowerChars;
  WordsSet = SET OF STRING; //doesn't work
  ArrayHandler = ARRAY [1 .. UniqueWords] OF STRING;
  UpLowArray = ARRAY[UpperChars] OF LowerChars;
  
VAR
  UpperCase: UpperSet;
  LowerCase: LowerSet;
  DefinedWords: WordsSet;
  WordId, WordValue: ArrayHandler;
  Exchange: UpLowArray;
  Key, Value: CHAR;
  
FUNCTION WordDefiner(VAR Text: TEXT): STRING;
VAR
  Word: STRING;
  Ch, State: CHAR;
  CountHyphen: INTEGER;
BEGIN {WordDefiner}
  State := 'B';
  CountHyphen := 0;
  Word := '';
  WHILE State <> 'F'
  DO
    BEGIN
      IF NOT EOLN(Text)
      THEN
        READ(Text, Ch)
      ELSE
        State := 'F';  
      //BEGIN
      IF (State = 'B') AND (Ch <> ' ')
      THEN
        State := 'W';
      //WORD
      IF State = 'W'
      THEN
        BEGIN
          IF (Ch IN LowerCase) OR (Ch IN UpperCase)
          THEN
            IF Ch IN LowerCase
            THEN
              Word := Word + Ch
            ELSE
              Word := Word + Exchange[Ch]
          ELSE
            IF Ch = '-'
            THEN
              State := '-'
            ELSE
              State := 'F'
        END;
      //Hyphen
      IF State = '-'
      THEN
        BEGIN
          IF (Ch IN UpperCase) OR (Ch IN LowerCase)
          THEN
            BEGIN
              //Печать -
              WHILE CountHyphen > 0
              DO
                BEGIN
                  Word := Word + '-';
                  CountHyphen := CountHyphen - 1
                END;
              //Печать последующего дефисам символа и переход в W
              IF Ch IN LowerCase
              THEN
                Word := Word + Ch
              ELSE
                Word := Word + Exchange[Ch];
              State := 'W'
            END
          ELSE
            IF Ch = '-'
            THEN
              CountHyphen := CountHyphen + 1
            ELSE
              State := 'F'
        END
    END;
  WordDefiner := Word
END; {WordDefiner}


BEGIN {UNIT WordsHndler}
  //Объявдение массива
  Value := 'a';
  FOR Key := 'A' TO 'Z'
  DO
    BEGIN
      Exchange[Key] := Value;
      INC(Value)
    END;
  Value := 'а';
  FOR Key := 'А' TO 'Я' //сначала англ буквы, затем русские
  DO
    BEGIN
      Exchange[Key] := Value;
      INC(Value)
    END;
  //Объявление множеств;
  UpperCase := ['A' .. 'Z'] + ['А' .. 'Я'];
  LowerCase := ['a' .. 'z'] + ['а' .. 'я']
END. {UNIT WordsHndler}
