PROGRAM RunReverse(INPUT, OUTPUT);

PROCEDURE Reverse(VAR FIn, FOut: TEXT);
VAR
  Ch: CHAR;
BEGIN {Reverse}
  IF NOT EOLN(FIn)
  THEN
    BEGIN
      READ(FIn, Ch);
      Reverse(FIn, FOut);
      WRITE(FOut, Ch)
    END
  ELSE
    WRITE('$')
END; {Reverse}

BEGIN {RunReverse}
  Reverse(INPUT, OUTPUT);
  WRITELN
END. {RunReverse}
