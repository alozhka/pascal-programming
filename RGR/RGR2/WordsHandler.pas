UNIT WordsHandler;
INTERFACE
  FUNCTION WordDefiner(VAR Text: TEXT): STRING;
IMPLEMENTATION

TYPE
  UpperChars = 'A' .. 'Я';//с англ А по русскую Я
  LowerChars = '`' .. 'я';//идентично
  NumbersRange = '0' .. '9';
  UpperSet = SET OF UpperChars;
  LowerSet = SET OF LowerChars;
  NumSet = SET OF NumbersRange;
  UpLowArray = ARRAY[UpperChars] OF LowerChars;  
VAR
  UpperCase:  UpperSet;
  LowerCase:  LowerSet;
  NumCase:     NumSet;
  Exchange:   UpLowArray;
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
      IF (State = 'B') AND 
        ( (Ch IN UpperCase) OR (Ch IN LowerCase) OR (Ch IN NumCase) 
        OR (Ch = 'Ё') OR (Ch = 'ё') )
      THEN
        State := 'W';
      //WORD
      IF State = 'W'
      THEN
        BEGIN
          CASE Ch OF
            'Ё': Ch := 'Е';
            'ё': Ch := 'е'
          END;
          IF (Ch IN LowerCase) OR (Ch IN UpperCase) OR (Ch IN NumCase)
          THEN
            IF Ch IN UpperCase
            THEN
              Word := Word + Exchange[Ch]
            ELSE
              Word := Word + Ch
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
          CASE Ch OF
            'Ё': Ch := 'Е';
            'ё': Ch := 'е';
            '"': Ch := '`'
          END;
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
  LowerCase := ['`' .. 'z'] + ['а' .. 'я'];
  NumCase := ['0' .. '9'];
END. {UNIT WordsHndler}
