PROGRAM RunRecursiveSort(INPUT, OUTPUT);
VAR
  F2, F3: TEXT;


PROCEDURE CopyFile(VAR InFile, OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN{CopyFile}
  WHILE NOT EOLN(InFile)
  DO
    BEGIN
      READ(InFile, Ch);
      WRITE(OutFile, Ch)
    END;
  WRITELN(OutFile)
END; {CopyFile}

{PROCEDURE Split(VAR F1, F2, F3: TEXT) Разбивает F1 на F2 и F3}
PROCEDURE Split(VAR F1, F2, F3: TEXT);
{Разбивает F1 на F2, F3}
VAR 
  Ch, Switch: CHAR;
BEGIN {Split}
  RESET(F1);
  REWRITE(F2);
  REWRITE(F3);
  {Копировать F1 попеременно в F2 и F3}
  Switch := '2';
  WHILE NOT (EOLN(F1))
  DO
    BEGIN
      READ(F1, Ch);
      IF (Switch = '2')
      THEN
        BEGIN
          WRITE(F2, Ch);
          Switch := '3';
        END
      ELSE
        BEGIN
          WRITE(F3, Ch);
          Switch := '2';
        END
    END;
  WRITELN(F2);
  WRITELN(F3);
END; {Split}

PROCEDURE Merge(VAR F1, F2, F3: TEXT);
{Сливает F2, F3 в F1  в сортированном порядке}
VAR 
  Ch2, Ch3: CHAR;
BEGIN {Merge}
  RESET(F2);
  RESET(F3);
  REWRITE(F1);
  //Protected Read
  IF NOT EOLN(F2)
  THEN
    READ(F2, Ch2);
  IF NOT EOLN(F3)
  THEN
    READ(F3, Ch3);
  WHILE (NOT (EOLN(F2))) AND (NOT(EOLN(F3)))
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
  IF (EOLN(F2)) AND (NOT (EOLN(F3)))
  THEN
    WRITE(F2, Ch2);  
  {Копировать остаток F2 в F1}
  IF NOT EOLN(F2)
  THEN
    BEGIN
      WHILE NOT (EOLN(F2))
      DO
        BEGIN
          WRITE(F1, Ch2);
          READ(F2, Ch2)
        END;
      WRITE(F1, Ch2)
    END;
  {Копировать остаток F3 в F1}
  IF NOT EOLN(F3)
  THEN
    BEGIN
      WHILE NOT (EOLN(F3))
      DO
        BEGIN
          WRITE(F1, Ch3);
          READ(F3, Ch3)
        END;
      WRITE(F1, Ch3)
    END;
  WRITELN(F1)
END; {Merge}


BEGIN {RunRecursiveCort}
  Split(INPUT, F2, F3);
  RESET(F2);
  RESET(F3);
  CopyFile(F2, OUTPUT);
  CopyFile(F3, OUTPUT);
  Merge(OUTPUT, F2, F3);
  WRITELN
END. {RunRecursiveSort}
