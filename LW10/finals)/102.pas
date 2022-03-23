PROGRAM FormattingCorrectCode(INPUT, OUTPUT);
VAR
  State, Ch: CHAR;
BEGIN {FormattingCorrectCode}
  State := 'B';
  WHILE State <> 'F'
  DO
    BEGIN
      IF NOT EOLN(INPUT)
      THEN
        READ(Ch)
      ELSE
        State := 'F';
      IF State = '('
      THEN
        BEGIN
          IF Ch <> ' '
          THEN
            WRITE(Ch);
          IF Ch = ','
          THEN
            WRITE(' ');
          IF Ch = ')'
          THEN
            State := 'L'
        END;
      IF State = 'L'
      THEN
        BEGIN
          IF (Ch = ';') OR (Ch = '(')
          THEN
            WRITE(Ch);
          IF Ch = '('
          THEN
            State := '(';
          IF Ch = 'E'
          THEN
            BEGIN
              WRITELN;
              WRITE('END.');
              State := 'F'
            END
          ELSE
            IF (Ch <> ';') AND (Ch <> ' ') AND (Ch <> ')') AND (Ch <> '(')
            THEN
              BEGIN
                WRITELN;
                WRITE('  ');
                State := 'O'
              END
        END;
      IF State = 'b'
      THEN
        BEGIN
          IF Ch = ';'
          THEN
            BEGIN
              WRITE('  ', Ch);
              State := 'L'
            END;
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
          IF (Ch <> ' ') AND (Ch <> ';') AND (Ch <> '(')
          THEN
            WRITE(Ch)
          ELSE
            State := 'L';
          IF (Ch = ';') OR (Ch = '(')
          THEN
            WRITE(Ch);
          IF Ch = '('
          THEN
            State := '('
        END;
      IF State = 'B'
      THEN
        BEGIN
          IF (Ch <> 'N') AND (Ch <> ' ')
          THEN
            WRITE(Ch);
          IF Ch = 'N'
          THEN
            BEGIN
              WRITELN(Ch);
              State := 'b'
            END
        END
    END
END. {FormattingCorrectCode}
