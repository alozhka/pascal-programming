PROGRAM MonthIdentifier(INPUT, OUTPUT);
USES
  DateIO;
VAR
  Month1, Month2: Month;
  
BEGIN {MonthIdentifier}
  ReadMonth(INPUT, Month1);
  ReadMonth(INPUT, Month2);
  WriteMonth(OUTPUT, Month1);
  //WriteMonth(OUTPUT, Month2)
END. {MonthIdentifier}
