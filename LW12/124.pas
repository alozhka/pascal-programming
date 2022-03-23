PROGRAM NoExtraSpaces(INPUT, OUTPUT);
VAR
  Ch, State: CHAR;
BEGIN {NoExtraSpaces}
  State := 'B';
  WHILE NOT EOLN
  DO
    BEGIN
      IF NOT EOLN
      THEN
        READ(Ch);
      IF (State = 'W') AND (Ch = ' ')
      THEN
        State := 'S';
      IF (State = 'S') AND (Ch <> ' ')
      THEN
        BEGIN
          State := 'W';  
          WRITE(' ')
        END;
      IF (State = 'B') AND (Ch <> ' ')
      THEN
        State := 'W';
      IF (State = 'W') AND (Ch <> ' ')
      THEN
        WRITE(Ch)
    END;
  WRITELN('$')
END. {NoExtraSpaces}
