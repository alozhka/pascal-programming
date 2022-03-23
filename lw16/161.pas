PROGRAM MonthIdentifier(INPUT, OUTPUT);
USES
  DateIO;
VAR
  Ch, SeqMonth1, SeqMonth2: CHAR;
  Month1, Month2: Month;
  F1: TEXT;
  
PROCEDURE MonthId(VAR Mon: Month; VAR MonId: CHAR);
BEGIN {MonthId}
  IF Mon = JAN
  THEN
    MonId := '1';
  IF Mon = FEB
  THEN
    MonId := '2';
  IF Mon = MAR
  THEN
    MonId := '3';
  IF Mon = APR
  THEN
    MonId := '4';
  IF Mon = MAY
  THEN
    MonId := '5';
  IF Mon = JUN
  THEN
    MonId := '6';
  IF Mon = JUL
  THEN
    MonId := '7';
  IF Mon = AUG
  THEN
    MonId := '8';
  IF Mon = SEP
  THEN
    MonId := '9';
  IF Mon = OCT
  THEN
    MonId := '10';
  IF Mon = NOV
  THEN
    MonId := '11';
  IF Mon = DEC
  THEN
    MonId := '12';
END; {MonthId}

BEGIN {MonthIdentifier}
  IF NOT EOLN
  THEN
    BEGIN 
      IF NOT EOLN
      THEN
        BEGIN 
          IF NOT EOLN
          THEN
            BEGIN 
              IF NOT EOLN
              THEN
                BEGIN 
                  IF NOT EOLN
                  THEN
                    BEGIN 
                      IF NOT EOLN
                      THEN
                        BEGIN       
                          ReadMonth(INPUT, Month1);
                          ReadMonth(INPUT, Month2)
                        END 
                    END 
                END 
            END 
        END 
    END;
  // noMonth
  // equials  
  IF Month1 = Month2
  THEN
    IF (Month1 = NoMonth) OR (Month2 = NoMonth)
    THEN
      WRITE('¬ходные данные записаны неверно')
    ELSE
      BEGIN
        WRITE('ќба мес€ца ');
        WriteMonth(OUTPUT, Month1);
      END;
  //check
  MonthId(Month1, SeqMonth1);
  MonthId(Month2, SeqMonth2);
  IF SeqMonth1 < SeqMonth2
  THEN
    BEGIN
      WriteMonth(OUTPUT, Month1);
      WRITE(' предшествует ');
      WriteMonth(OUTPUT, Month2);
    END;
  IF SeqMonth1 > SeqMonth2
  THEN
    BEGIN
      WriteMonth(OUTPUT, Month1);
      WRITE(' следует за ');
      WriteMonth(OUTPUT, Month2);
    END;
  WRITELN
END. {MonthIdentifier}
