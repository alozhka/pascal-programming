UNIT WordsHandler;
INTERFACE
  FUNCTION WordDefiner(VAR Text: TEXT): STRING;
IMPLEMENTATION

CONST
  TextLength = 500;
  UniqueWords = 500;
TYPE
  UpperChars = 'A' .. '�';
  LowerChars = 'a' .. '�';
  UpperSet = SET OF UpperChars;
  LowerSet = SET OF LowerChars;
  WordsRange = 1 .. TextLength;
  UniqueWordsRange = 1 .. UniqueWords;
  WordHandle = RECORD
    Value: STRING;
    Amount: INTEGER;
    NextId: WordsRange
  END;
  ArrayHandler = ARRAY[UniqueWordsRange] OF WordHandle;
  ArrayWords = ARRAY[WordsRange] OF STRING;
  UpLowArray = ARRAY[UpperChars] OF LowerChars;  
VAR
  UpperCase: UpperSet;
  LowerCase: LowerSet;
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
          CASE Ch OF
            '�': Ch := '�';
            '�': Ch := '�'
          END;
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
          CASE Ch OF
            '�': Ch := '�';
            '�': Ch := '�'
          END;
          IF (Ch IN UpperCase) OR (Ch IN LowerCase)
          THEN
            BEGIN
              //������ -
              WHILE CountHyphen > 0
              DO
                BEGIN
                  Word := Word + '-';
                  CountHyphen := CountHyphen - 1
                END;
              //������ ������������ ������� ������� � ������� � W
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
  //���������� �������
  Value := 'a';
  FOR Key := 'A' TO 'Z'
  DO
    BEGIN
      Exchange[Key] := Value;
      INC(Value)
    END;
  Value := '�';
  FOR Key := '�' TO '�' //������� ���� �����, ����� �������
  DO
    BEGIN
      Exchange[Key] := Value;
      INC(Value)
    END;
  //���������� ��������;
  UpperCase := ['A' .. 'Z'] + ['�' .. '�'];
  LowerCase := ['a' .. 'z'] + ['�' .. '�']
END. {UNIT WordsHndler}
