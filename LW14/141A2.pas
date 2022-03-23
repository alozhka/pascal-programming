PROGRAM RunReverse(INPUT, OUTPUT);

PROCEDURE Reverse(VAR F, OUTPUT: TEXT);
VAR
  Ch: CHAR;
BEGIN {Reverse}
  IF NOT EOLN(F)
  THEN
    BEGIN
      READ(F, Ch);
      Reverse(F, OUTPUT);
      WRITE(OUTPUT, Ch)
    END
END; {Reverse}

BEGIN {RunReverse}
  Reverse(INPUT, OUTPUT);
  WRITELN
END. {RunReverse}
