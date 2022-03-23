PROGRAM RunRCopy(INPUT, OUTPUT);

PROCEDURE RCopy(VAR FIn, FOut: TEXT);
VAR
  Ch: CHAR;
BEGIN {RCopy}
  IF NOT EOLN(FIn)
  THEN
    BEGIN
      READ(FIn, Ch);
      WRITE(FOut, Ch);
      RCopy(FIn, FOut)
    END
  ELSE
    WRITE('$')
END; {RCopy}

BEGIN {RunRCopy}
  RCopy(INPUT, OUTPUT);
  WRITELN
END. {RunRCopy}
