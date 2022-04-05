PROGRAM Prime(INPUT, OUTPUT);
CONST
  Max = 100;
TYPE
  SimpleNumbersSet = SET OF 2 .. Max;
VAR
  SNums: SimpleNumbersSet;
  Number, I: INTEGER;

BEGIN {Prime}
  SNums := [2 .. Max];
  Number := 2;
  WHILE Number <= SQRT(Max)
  DO
    BEGIN
      I := Number + 1;
      WHILE I <= Max
      DO
        BEGIN
          IF I MOD Number = 0
          THEN
            SNums := SNums - [I];
          I := I + 1
        END;
      Number := Number + 1
    END;
  I := 1;
  WHILE I <= Max
  DO
    BEGIN
      I := I + 1;
      IF I IN SNums
      THEN
        WRITE(I, ' ')
    END;
  WRITELN
END. {Prime}
