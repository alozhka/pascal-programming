PROGRAM StringToNumbderProcessing(INPUT, OUTPUT);
VAR
  Num, Min, Max, Sum, AvgInt, AvgReal, Counter: INTEGER;

PROCEDURE ReadDigit(VAR F: TEXT; VAR D: INTEGER);
{��������� ������� ������ �� ����. ���� �� - �����, ���������� ���
 ���������� � �������� ���� INTEGER. ���� ��������� ������ �� �����
 ���������� -1}
VAR
  Ch: CHAR;
BEGIN {ReadDigit}
  READ(F, Ch);
  IF Ch = '0' THEN D := 0 ELSE
  IF Ch = '1' THEN D := 1 ELSE
  IF Ch = '2' THEN D := 2 ELSE
  IF Ch = '3' THEN D := 3 ELSE
  IF Ch = '4' THEN D := 4 ELSE
  IF Ch = '5' THEN D := 5 ELSE
  IF Ch = '6' THEN D := 6 ELSE
  IF Ch = '7' THEN D := 7 ELSE
  IF Ch = '8' THEN D := 8 ELSE
  IF Ch = '9' THEN D := 9 ELSE D := -1
END; {ReadDigit}

PROCEDURE ReadNumber(VAR F: TEXT; VAR N: INTEGER);
{����������� ������ ���� �� ����� �� ������� ����������� �������,  � ��������������� ����� ����� N}
VAR
  Digit: INTEGER;
BEGIN {ReadNumber}
  N := 0;
  Digit := 0;
  WHILE (NOT EOLN(F)) AND (Digit <> -1) AND (N <= ((MaxINT - Digit) DIV 10)) //�� ����� ������ ����� � ������ ����� � ��� ������������
  DO 
    BEGIN
      N := N * 10 + Digit;
      ReadDigit(F, Digit)
    END;
  IF Digit <> -1 // ��������� ���� �����
  THEN
    IF N <= ((MaxINT - Digit) DIV 10) //��� ������������
    THEN
      N := N * 10 + Digit
    ELSE                              //����� ������������
      N := -2;
  IF N = 0  //� �������� ������ ������ �� ��������, �.�. ��� �����
  THEN
    N := -1;
END; {ReadNumber}
  
BEGIN {StringToNumbderProcessing}
  Max := -1 - MaxINT;
  Min := MaxINT;
  Sum := 0;
  Counter := 0;
  IF NOT EOLN
  THEN
    BEGIN
      ReadNumber(INPUT, Num);
      IF NOT (Num IN [-1, -2])
      THEN
        BEGIN
          Counter := Counter + 1;  //����������
          Sum := Sum + Num;        //����� ��� avg
          IF Num > Max             //����
          THEN
            Max := Num;
          IF Num < Min             //���
          THEN
            Min := Num
        END
      ELSE
        WRITELN('[!] ������: ������������ ��� ������, ���� ������������')
    END
  ELSE
    WRITELN('[!] ������: ������������ ��� ������, ���� ������������');
  WHILE (NOT EOLN) AND (NOT (Num IN [-1, -2]))
  DO
    BEGIN
      ReadNumber(INPUT, Num);
      IF NOT (Num IN [-1, -2])
      THEN
        BEGIN
          Counter := Counter + 1;  //����������
          Sum := Sum + Num;        //����� ��� avg
          IF Num > Max             //����
          THEN
            Max := Num;
          IF Num < Min             //���
          THEN
            Min := Num
        END
      ELSE
        WRITELN('[!] ������: ������������ ��� ������, ���� ������������')
    END;
  Sum := Sum*10;
  AvgInt := Sum DIV Counter;
  AvgReal := Sum MOD Counter;
  IF NOT (Num IN [-1, -2])
  THEN
    BEGIN
      WRITELN('����������: ', Counter, ', ������������: ', Min, ', ������������: ', Max);
      WRITELN('�������� ��������������: ', AvgInt DIV 10, '.', AvgReal MOD 10);
      WRITELN(5 MOD 2)
    END
END. {StringToNumbderProcessing}
