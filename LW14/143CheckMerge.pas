PROGRAM CheckMerge(INPUT, OUTPUT);
VAR 
  F1, F2, F3: TEXT;

PROCEDURE CopyFileLn(VAR FIn, FOut: TEXT);
VAR
  Ch: CHAR;
BEGIN {CopyFileLn}
  WHILE NOT EOLN(FIn)
  DO
    BEGIN
      READ(FIn, Ch);
      WRITE(FOut, Ch)
    END;
  WRITELN(FOut)
END; {CopyFileLn}

PROCEDURE Merge(VAR F1, F2, F3: TEXT);
{Сливает F2, F3 в F1  в сортированном порядке}
VAR              
  Ch2, Ch3: CHAR;
BEGIN {Merge}
  RESET(F2);
  RESET(F3);
  REWRITE(F1);
  READ(F2, Ch2);
  WRITE(Ch2);
  READ(F3, Ch3);
  WRITE(Ch3, ' ');
  WHILE (NOT(EOLN(F2))) AND (NOT(EOLN(F3)))
  DO
    BEGIN
      IF Ch2 < Ch3
      THEN 
        BEGIN
          WRITE(F1, Ch2);
          READ(F2, Ch2);
        END
      ELSE
        BEGIN
          WRITE(F1, Ch3);
          READ(F3, Ch3);
        END
    END;
  IF Ch2 < Ch3
  THEN
    WRITE(F1, Ch2, Ch3)
  ELSE
    WRITE(F1, Ch3, Ch2);
  {Копировать остаток F2 в F1}
  WHILE NOT (EOLN(F2))
  DO
    BEGIN
      READ(F2, Ch2);
      WRITE(F1, Ch2);
    END;
  {Копировать остаток F3 в F1}
  WHILE NOT (EOLN(F3))
  DO
    BEGIN
      READ(F2, Ch3);
      WRITE(F1, Ch3);
    END;
  WRITELN(F1)
END; {Merge}

BEGIN {CheckMerge}
  REWRITE(F1);
  REWRITE(F2);
  REWRITE(F3);
  CopyFileLn(INPUT, F2);
  READLN(INPUT);
  CopyFileLn(INPUT, F3);
  RESET(F2);
  RESET(F3);
  CopyFileLn(F2, OUTPUT);
  CopyFileLn(F3, OUTPUT);
  RESET(F2);
  RESET(F3);
  Merge(F1, F2, F3);
  RESET(F1);
  CopyFileLn(F1, OUTPUT)
END. {CheckMerge}
