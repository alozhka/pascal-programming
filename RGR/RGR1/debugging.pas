PROGRAM CountWords(INPUT, OUTPUT);
CONST
  UniqueWords = 150;
TYPE
  UpperChars = 'A' .. '�'; //�� ���������� � �� �������
  LowerChars = 'a' .. '�'; {--//--}
  UpperSet = SET OF UpperChars;
  LowerSet = SET OF LowerChars;
  ArrayHandler = ARRAY [1 .. UniqueWords] OF STRING;
  UpLowArray = ARRAY[UpperChars] OF LowerChars;
  
VAR
  UpperCase: UpperSet;
  LowerCase: LowerSet;
  WordId, WordValue: ArrayHandler;
  Exchange: UpLowArray;
  TextIn: TEXT;
  
  Word: STRING;
  Ch, Ch1, State: CHAR;
  CountHyphen: INTEGER;

BEGIN
  REWRITE(TextIn);
  WRITE(TextIn, '   ���dcK--$-DafS-- S  ���');
  RESET(TextIn);
  //���������� �������
  Ch1 := 'a';
  FOR Ch := 'A' TO 'Z'
  DO
    BEGIN
      Exchange[Ch] := Ch1;
      INC(Ch1)
    END;
  Ch1 := '�';
  FOR Ch := '�' TO '�' //������� ���� �����, ����� �������
  DO
    BEGIN
      Exchange[Ch] := Ch1;
      INC(Ch1);
    END;
  //���������� ��������;
  UpperCase := ['A' .. 'Z'] + ['�' .. '�'];
  LowerCase := ['a' .. 'z'] + ['�' .. '�'];
  //�����
  State := 'B';
  CountHyphen := 0;
  Word := '';
  WHILE State <> 'F'
  DO
    BEGIN
      IF NOT EOLN(TextIn)
      THEN
        READ(TextIn, Ch)
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
              WRITE(Ch)
            ELSE
              WRITE(Exchange[Ch])
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
              WHILE CountHyphen > 0
              DO
                BEGIN
                  WRITE('-');
                  CountHyphen := CountHyphen - 1
                END;
              IF Ch IN LowerCase
              THEN
                WRITE(Ch)
              ELSE
                WRITE(Exchange[Ch]);
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
  Word := Word + 'A';
  WRITELN(Word)
END.
