PROGRAM Split(INPUT,OUTPUT);
  {Копирует INPUT в OUTPUT,сначала нечетные,а затем четные
   элементы}
VAR
  Ch, Next: CHAR;
  Odds, Evens: TEXT;

PROCEDURE CopyOut(VAR F1: TEXT; VAR Ch: CHAR);
BEGIN {CopyOut}
  {Копируем F1 в OUTPUT}
  WHILE NOT EOLN(F1)
  DO
    BEGIN
      READ(F1, Ch);
      WRITE(Ch)
    END;
  READLN(F1);
  WRITELN
END; {CopyOut}


BEGIN {Split}
  {Разделяет INPUT в Odds и Evens}
  REWRITE(Odds);
  REWRITE(Evens);
  Next := 'O';
  WHILE NOT EOF(INPUT)
  DO
    BEGIN
      WHILE NOT EOLN(INPUT)
      DO
          BEGIN
            {Прочитать Ch, записать в файл, выбранный через
            Next,переключить Next}
            READ(INPUT, Ch);
            IF Next = 'O'
            THEN
              BEGIN
                WRITE(Odds, Ch);
                Next := 'E'
              END
            ELSE
              BEGIN
                WRITE(Evens, Ch);
                Next := 'O'
              END
          END;
      READLN(INPUT);
      WRITELN(Odds);
      WRITELN(Evens)
    END;
  WRITELN(Odds);
  WRITELN(Evens);
  RESET(Odds);
  CopyOut(Odds, Ch);
  RESET(Evens);
  CopyOut(Evens, Ch);
  WRITELN
END. {Split}
