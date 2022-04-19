PROGRAM GraphicalPrinting(INPUT, OUTPUT);
USES
  GraphicalPrint;
CONST
  MaxCh = 80;
TYPE
  RangeCh = 'A' .. '[';
  RangeIndex = 1 .. Max;
  ArrRange = ARRAY[RangeIndex] OF RangeCh;
VAR
  Str: ArrRange;
  Plenty: TSymbols;
  I, J: INTEGER;

PROCEDURE TakeSymbols(VAR F: TEXT; VAR Str: ArrRange);
VAR
  I: INTEGER;
  Ch: CHAR;
BEGIN
  I := 1;
  WHILE NOT EOLN(F)
  DO
    BEGIN
      READ(F, Ch);
      Str[I] := Ch;
      I := I + 1
    END
END;

BEGIN {GraphicalPrinting}
  FOR I := 1 TO 80                  //Обнуляем
  DO
    Str[I] := '[';
  TakeSymbols(INPUT, Str);         //записываем всё, что введено
  FOR I := 1 TO 5                  //Кол-во Столбцов
  DO
    BEGIN
      J := 1;
      WHILE Str[J] <> '['
      DO
        BEGIN
          Plenty := InitSymbol(Str[J]);
          PrintStr(OUTPUT, Plenty, I);
          WRITE(OUTPUT, ' ');
          J := J + 1
        END;
      WRITELN
    END;
  WRITELN
END. {GraphicalPrinting}
