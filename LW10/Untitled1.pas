PROGRAM FormattingCorrectCode(INPUT, OUTPUT);
VAR
  State, Ch: CHAR;
BEGIN {FormattingCorrectCode}
  State := 'B';
  WHILE EOLN(INPUT)
  DO
    WHILE State <> 'F'
    DO
      BEGIN
        //������
        READ(Ch);
        //�������� �� �(Begin)
        IF State = 'B'
        THEN
          IF Ch = 'B'
          THEN
            State := 'b';
        //�������� b(�� begin)
        IF  State = 'b'
        THEN
          BEGIN
            IF Ch = ';'
            THEN
              State := 'L';
            IF (Ch <> ';') AND (Ch <> ' ')
            THEN
              State := 'O'
          END;
        //�������� L(End Line)
        IF State = 'L'
        THEN
          IF (Ch <> ';') AND (Ch <> ' ')
          THEN
            BEGIN
              WRITELN;
              State := 'O'
            END
          ELSE
            WRITE(Ch);
        //�������� O(Operator)
        IF State = 'O'
        THEN
          BEGIN
            IF (Ch <> ';') AND (Ch <> ')')
            THEN
              WRITE(Ch)
            ELSE
              BEGIN
                State := 'L';
                IF Ch = ')'
                THEN
                  WRITE(Ch)
              END;
            IF Ch = ','
            THEN
              WRITE(' ')
          END
        //�������� E(End)
        //IF
      END
END. {FormattingCorrectCode}

