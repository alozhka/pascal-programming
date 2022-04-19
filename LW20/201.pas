PROGRAM GraphicalPrint(INPUT, OUTPUT);
USES
  GraphicalPrint;
VAR
  Plenty: TSymbols;
  Symbol: CHAR;


BEGIN {GraphicalPrint}
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Symbol);
      Plenty := InitSymbol(Symbol);
      PrintSymbol(OUTPUT, Plenty);
      WRITELN
    END;
  WRITELN
END. {GraphicalPrint}
