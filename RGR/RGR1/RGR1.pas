PROGRAM CountWords(INPUT, OUTPUT);
CONST
  UniqueWords = 150;
TYPE
  UpperChars = 'А' .. 'Я';
  LowerChars = 'а' .. 'я';
  UpperSet = SET OF UpperChars;
  LowerSet = SET OF LowerChars;
  ArrayHandler = ARRAY [1 .. UniqueWords] OF STRING;
  UpLowArray = ARRAY[UpperChars] OF LowerChars;
  
VAR
  UpperCase: UpperSet;
  LowerCase: LowerSet;
  WordId, WordValue: ArrayHandler;
  Exchange: UpLowArray;
  TextIn: TEXT;
  Word: STRING;
  Ch, State: CHAR;

BEGIN
  REWRITE(TextIn);
  WRITE(TextIn, '   ABC   DEF');
  RESET(TextIn);
  State := 'B';
  Word := '';
  WHILE State <> 'F'
  DO
    BEGIN
      IF NOT EOLN(TextIn)
      THEN
        READ(TextIn, Ch)
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
          CASE Ch OF       //1.попробовать вставить диапазон для проверки а потом вывод в case 2.сделать с - ответвление 3.отсальное должно работать
            ' ': State := 'F';
            '-': State := 'F'
          ELSE
            WRITE(Ch)
          END
        END
    END;
END.
