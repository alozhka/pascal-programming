PROGRAM Lexical(INPUT, OUTPUT);
VAR
  Result: CHAR;
  F1, F2: TEXT;


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

PROCEDURE Lexico(VAR F1, F2: TEXT; VAR Result: CHAR);
{Result 0, 1, 2 если лексикографический порядок F1 =, <, > чем F2       
соответственно. Фактические параметры, соответствующие F1 и F2,
должны быть различными}
VAR
  Ch1, Ch2: CHAR;
BEGIN {Lexico}
  RESET(F1);
  RESET(F2);
  Result := '0';
  WHILE (NOT EOLN(F1) AND NOT EOLN(F2)) AND (Result = '0')
  DO
    BEGIN
      READ(F1, Ch1);
      READ(F2, Ch2);
      IF (Ch1 < Ch2)
      THEN {Ch1 < Ch2 или F1 короче F2}
        Result := '1'
      ELSE
        IF (Ch1 > Ch2)
        THEN {Ch1 > Ch2 или F2 короче F1}
          Result := '2'
    END; {WHILE}
  IF Result = '0'
  THEN
    BEGIN
      IF (EOLN(F1)) AND (NOT(EOLN(F2)))//last in Evens
      THEN
        Result := '1';
      IF (EOLN(F2)) AND (NOT(EOLN(F1)))//last in Odds
      THEN
        Result := '2'
    END
END; {Lexico}

BEGIN {Lexical}
  REWRITE(F1);
  CopyFile(INPUT, F1);
  RESET(INPUT);
  REWRITE(F2);
  CopyFile(INPUT, F2);
  Lexico(F1, F2, Result);
  WRITELN(Result)
END. {Lexical}

