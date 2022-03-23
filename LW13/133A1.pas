PROGRAM Split(INPUT,OUTPUT);
  {Копирует INPUT в OUTPUT,сначала нечетные,а затем четные
   элементы}
VAR
  Ch, Next: CHAR;
  Odds, Evens: TEXT;
PROCEDURE CopyOut(VAR F1: TEXT);
VAR
  Ch: CHAR;
BEGIN {CopyOut}
  {Копирует F1 В OUTPUT}
  WHILE NOT EOLN(F1)
  DO
    BEGIN
      READ(F1, Ch);
      WRITE(OUTPUT, Ch)
    END
END; {CopyOut}

BEGIN
  REWRITE(Odds);
  REWRITE(Evens);
  {Разделяет INPUT в Odds и Evens}
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      READ(INPUT, Ch);
      WRITE(Odds, Ch)
    END;
  RESET(Odds);  
  CopyOut(Odds);
  //CopyOut(Evens,Ch);
  WRITELN
END.

