PROGRAM Reverse(INPUT, OUTPUT);
VAR
  Ch: CHAR;
  F1, F2: TEXT;
BEGIN
  REWRITE(F1);
  WHILE NOT EOLN(INPUT)
  DO 
    BEGIN
      READ(INPUT, Ch);
      WRITE(F1, Ch)
    END;
  WRITELN(F1);
  RESET(F1);
  WHILE NOT EOLN(F1)
  DO
    BEGIN
      REWRITE(F2);  
      WHILE NOT EOLN(F1)
      DO 
        BEGIN
          READ(F1, Ch);
          IF NOT EOLN(F1)
          THEN 
            WRITE(F2, Ch)
          ELSE
            WRITE(OUTPUT, Ch)    
        END;
      WRITELN(F2);  
      REWRITE(F1);
      RESET(F2);
      WHILE NOT EOLN(F2)  
      DO 
        BEGIN
          READ(F2, Ch);
          IF NOT EOLN(F2)
          THEN
            WRITE(F1, Ch)
          ELSE
            WRITE(OUTPUT, Ch)
        END;
      WRITELN(F1);
      RESET(F1)
    END
END.  
