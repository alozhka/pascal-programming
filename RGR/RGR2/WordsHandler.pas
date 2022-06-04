UNIT WordsHandler;
INTERFACE
  FUNCTION WordDefiner(VAR Text: TEXT): STRING;
IMPLEMENTATION

TYPE
  UpperChars = 'A' .. '�';//� ���� � �� ������� �
  LowerChars = '`' .. '�';//���������
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
        OR (Ch = '�') OR (Ch = '�') )
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
            '�': Ch := '�';
            '�': Ch := '�';
            '"': Ch := '`'
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
  LowerCase := ['`' .. 'z'] + ['�' .. '�'];
  NumCase := ['0' .. '9'];
END. {UNIT WordsHndler}
