PROGRAM FormattingCorrectCode(INPUT, OUTPUT);
VAR
  State, Ch: CHAR;
BEGIN {FormattingCorrectCode}
  State := 'B';
  WHILE State <> 'F'
  DO
    BEGIN
      {Считывание Ch с проверкой на конец строки, иначе State := 'F'}
      IF NOT EOLN(INPUT)
      THEN
        READ(Ch)
      ELSE
        State := 'F';
      {Если L (Line)}
      IF State = 'L'
      THEN
        BEGIN
          //Пишем только ;
          IF Ch = ';'
          THEN
            WRITE(Ch);
          //Если встретили Е, то пишем END., к F(конец)
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
      {Если b (after BEGIN)}
      IF State = 'b'
      THEN
        BEGIN
          //Пишем только ;
          IF Ch = ';'
          THEN
            BEGIN
              WRITE('  ', Ch);
              State := 'L'
            END;
          //Если встретили Е, то пишем END., к F(конец)
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
          //Если , то пишем , ПРОБЕЛ
          IF Ch = ','
          THEN
            WRITE(', ');
          //Пишем всё сотальное кроме , ; и )
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
      {Если B (BEGIN)}
      IF State = 'B'
      THEN
        BEGIN
          //Пробел не пишем, пишем BEGI
          IF (Ch <> 'N') AND (Ch <> ' ')
          THEN
            WRITE(Ch);
          //Пишем N, тогда к 'b'
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

{Если O (Operator)
      IF State = 'O'
      THEN
        BEGIN
          //Пишем READ
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
          //Пишем WRITE
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

//Если , то пишем , ПРОБЕЛ
          IF Ch = ','
          THEN
            WRITE(', ');
          //Пишем всё сотальное кроме , ; и )
          IF (Ch <> ',') AND (Ch <> ';') AND (Ch <> ')') AND (Ch <> ' ')
          THEN
            WRITE(Ch);
          IF (Ch = ';') OR (Ch = ')')
          THEN
            BEGIN
              WRITE(Ch);
              State := 'L'
            END }
