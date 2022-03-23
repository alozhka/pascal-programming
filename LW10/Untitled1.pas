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
        //Чтение
        READ(Ch);
        //Проверка на В(Begin)
        IF State = 'B'
        THEN
          IF Ch = 'B'
          THEN
            State := 'b';
        //Проверка b(от begin)
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
        //Проверка L(End Line)
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
        //Провекра O(Operator)
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
        //Проверка E(End)
        //IF
      END
END. {FormattingCorrectCode}

