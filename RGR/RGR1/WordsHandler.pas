UNIT WordsHandler;
INTERFACE
  FUNCTION WordDefiner(VAR Text: TEXT):STRING;
IMPLEMENTATION

FUNCTION WordDefiner(VAR Text: TEXT):STRING;
VAR
  Word: STRING;
  Ch, State: CHAR;
  I: INTEGER;
BEGIN {WordDefiner}
  State := 'B';
  Word := '';
  WHILE State <> 'F'
  DO
    BEGIN
      IF NOT EOLN(Text)
      THEN
        READ(Ch);
        
      //BEGIN
      IF (State = 'B') AND (Ch <> ' ')
      THEN
        State := 'W';
      //WORD
      IF State = 'W'
      THEN
        BEGIN
          CASE Ch OF
            ' ': State := 'F';
            '-': State := '-'
          ELSE
            Word := Word + Ch
        END
    END
END; {WordDefiner}

BEGIN {UNIT WordsHndler}

END. {UNIT WordsHndler}
