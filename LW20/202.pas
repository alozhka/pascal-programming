PROGRAM GraphicalPrinting(INPUT, OUTPUT);
USES
  GraphicalPrint;
CONST
  MaxCh = 80;
TYPE
  RangeCh = 'A' .. 'Z';
  RangeIndex = 1 .. Max;
  ArrRange = ARRAY[RangeIndex] OF RangeCh;
VAR
  Str: ArrRange;
  Plenty: TSymbols;
  I, J, StrLen: INTEGER;

PROCEDURE TakeSymbols(VAR F: TEXT; VAR Str: ArrRange; VAR StrLen: INTEGER);
VAR
  Ch: CHAR;
BEGIN
  StrLen := 0;
  WHILE NOT EOLN(F)
  DO
    BEGIN
      READ(F, Ch);
      Str[I] := Ch;
      StrLen := StrLen + 1;
    END
END;

BEGIN {GraphicalPrinting}
  TakeSymbols(INPUT, Str, StrLen);
  WRITE(StrLen);
  WRITE(Str[1]);
  FOR I := 1 TO StrLen
  DO
    WRITE(Str[I]);        //записываем всё, что введено
  FOR I := 1 TO 5                     //Кол-во Столбцов
  DO
    BEGIN
      FOR J := 1 TO StrLen
      DO
        BEGIN
          Plenty := InitSymbol(Str[J]);
          PrintStr(OUTPUT, Plenty, I-1);
          WRITE(OUTPUT, ' ')
        END;
      WRITELN
    END;
  WRITELN
END. {GraphicalPrinting}
