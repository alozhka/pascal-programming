PROGRAM FormattingCorrectCode(INPUT, OUTPUT);
VAR
  State, Ch: CHAR;
BEGIN {FormattingCorrectCode}
  State := 'B';
  WHILE State <> 'F'
  DO
    BEGIN
      {���������� Ch � ��������� �� ����� ������, ����� State := 'F'}
      IF NOT EOLN(INPUT)
      THEN
        READ(Ch)
      ELSE
        State := 'F';
      {���� L (Line)}
      IF State = 'L'
      THEN
        BEGIN
          //����� ������ ;
          IF Ch = ';'
          THEN
            WRITE(Ch);
          //���� ��������� �, �� ����� END., � F(�����)
          IF Ch = 'E'
          THEN
            BEGIN
              WRITELN;
              WRITE('END.');
              State := 'F'
            END
          ELSE
            IF (Ch <> ';') AND (Ch <> ' ')
            THEN
              BEGIN
                WRITELN;
                WRITE('  ');
                State := 'O'
              END
        END;
      {���� b (after BEGIN)}
      IF State = 'b'
      THEN
        BEGIN
          //����� ������ ;
          IF Ch = ';'
          THEN
            BEGIN
              WRITE('  ', Ch);
              State := 'L'
            END;
          //���� ��������� �, �� ����� END., � F(�����)
          IF Ch = 'E'
          THEN
            BEGIN
              WRITE('END.');
              State := 'F'
            END
          ELSE
            IF (Ch <> ';') AND (Ch <> ' ')
            THEN
              BEGIN
                WRITE('  ');
                State := 'O'
              END
        END;
      IF State = 'O'
      THEN
        BEGIN
          //���� , �� ����� , ������
          IF Ch = ','
          THEN
            WRITE(', ');
          //����� �� ��������� ����� , ; � )
          IF (Ch <> ',') AND (Ch <> ';') AND (Ch <> ')') AND (Ch <> ' ')
          THEN
            WRITE(Ch);
          IF (Ch = ';') OR (Ch = ')')
          THEN
            BEGIN
              WRITE(Ch);
              State := 'L'
            END
        END;
      {���� B (BEGIN)}
      IF State = 'B'
      THEN
        BEGIN
          //������ �� �����, ����� BEGI
          IF (Ch <> 'N') AND (Ch <> ' ')
          THEN
            WRITE(Ch);
          //����� N, ����� � 'b'
          IF Ch = 'N'
          THEN
            BEGIN
              WRITELN(Ch);
              State := 'b'
            END
        END
    END
END. {FormattingCorrectCode}


{o (after OPERATOR)
      IF State = 'o'
      THEN
        BEGIN
        END; }

{���� O (Operator)
      IF State = 'O'
      THEN
        BEGIN
          //����� READ
          IF Ch = 'R'
          THEN
            BEGIN
              WRITE(Ch);
              WHILE (Ch <> ' ') AND (NOT EOLN(INPUT))
              DO
                BEGIN
                  READ(Ch);
                  WRITE(Ch)
                END
            END;
          //����� WRITE
          IF Ch = 'W'
          THEN
            BEGIN
              WRITE(Ch);
              WHILE (Ch <> 'E') AND (NOT EOLN(INPUT))
              DO
                BEGIN
                  READ(Ch);
                  WRITE(Ch)
                END
            END;
          State := 'o';
          IF EOLN(INPUT)
          THEN
            State := 'F'
        END;

//���� , �� ����� , ������
          IF Ch = ','
          THEN
            WRITE(', ');
          //����� �� ��������� ����� , ; � )
          IF (Ch <> ',') AND (Ch <> ';') AND (Ch <> ')') AND (Ch <> ' ')
          THEN
            WRITE(Ch);
          IF (Ch = ';') OR (Ch = ')')
          THEN
            BEGIN
              WRITE(Ch);
              State := 'L'
            END }
