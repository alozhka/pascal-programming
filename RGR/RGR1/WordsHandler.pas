UNIT WordsHandler;
INTERFACE
  FUNCTION WordDefiner(VAR Text: TEXT):STRING;
IMPLEMENTATION

CONST
  UniqueWords = 150;
TYPE
  UpperChars = '�' .. '�';
  LowerChars = '�' .. '�';
  UpperSet = SET OF UpperChars;
  LowerSet = SET OF LowerChars;
  ArrayHandler = ARRAY [1 .. UniqueWords] OF STRING;
  UpLowArray = ARRAY[UpperChars] OF LowerChars;
  
VAR
  UpperCase: UpperSet;
  LowerCase: LowerSet;
  WordId, WordValue: ArrayHandler;
  Exchange: UpLowArray;
  
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
        READ(Ch)
      ELSE
        State := 'F';  
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
            '-': State := 'F'
          ELSE
            IF Ch IN LowerChars
            THEN
              Word := Word + Ch
            ELSE
              IF Ch IN UpperChars
              THEN
                Word := Word + Exchange[Ch]; 
          END
        END
    END;
  WordDefiner := Word
END; {WordDefiner}


BEGIN {UNIT WordsHndler}

END. {UNIT WordsHndler}
