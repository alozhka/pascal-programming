UNIT GraphicalPrint;
INTERFACE
CONST
  Width = 5;
  Max = Width * Width;
TYPE
  RangeSymbols = 1 .. 25;
  TSymbols = SET OF RangeSymbols; 
  
FUNCTION InitSymbol(S: CHAR): TSymbols;
PROCEDURE PrintStr(VAR F: TEXT; Pl: TSymbols; StrNum: INTEGER);
PROCEDURE PrintSymbol(VAR F: TEXT; Pl: TSymbols);

IMPLEMENTATION
FUNCTION InitSymbol(S: CHAR): TSymbols;
VAR
  I: INTEGER;
{инициализирует символ и записывает в множество нужные данные}
BEGIN {InitSymbol}
  IF S IN ['A' .. 'Z']
  THEN
    CASE S OF
      'A': InitSymbol := [3, 7, 9, 12, 13, 14, 16, 20, 21, 25];
      'B': InitSymbol := [1, 2, 3, 4, 6, 10, 11, 12, 13, 14, 16, 20, 21, 22, 23, 24];
      'C': InitSymbol := [2, 3, 4, 6, 10, 11, 16, 20, 22, 23, 24];
      'D': InitSymbol := [1, 2, 3, 4, 6, 10, 11, 15, 16, 20, 21, 22, 23, 24];
      'E': InitSymbol := [1, 2, 3, 4, 5, 6, 10, 11, 12, 13, 14, 15, 16, 21, 22, 23, 24, 25];
      'F': InitSymbol := [1, 2, 3, 4, 5, 6, 10, 11, 12, 13, 14, 15, 16, 20];
      'G': InitSymbol := [2, 3, 4, 5, 6, 11, 13, 14, 16, 20, 22, 23, 24];
      'H': InitSymbol := [1, 5, 6, 10, 11, 12, 13, 14, 15, 16, 20, 21, 25];
      'I': InitSymbol := [1, 2, 3, 4, 5, 8, 13, 18, 21, 22, 23, 24, 25];
      'J': InitSymbol := [1, 2, 3, 4, 5, 10, 15, 16, 20, 22, 23, 24];
      'K': InitSymbol := [1, 5, 6, 8, 9, 11, 12, 16, 18, 19, 21, 25];
      'L': InitSymbol := [1, 6, 11, 16, 20, 21, 22, 23, 24, 25];
      'M': InitSymbol := [1, 5, 6, 7, 9, 10, 11, 13, 15, 16, 20, 21, 25];
      'N': InitSymbol := [1, 5, 6, 7, 10, 11, 13, 15, 16, 19, 20, 21, 24, 25];
      'O': InitSymbol := [2, 3, 4, 6, 10, 11, 15, 16, 20, 22, 23, 24];
      'P': InitSymbol := [1, 2, 3, 4, 6, 10, 11, 15, 16, 17, 18, 19, 21];
      'Q': InitSymbol := [2, 3, 4, 6, 10, 11, 15, 16, 19, 22, 23, 25];
      'R': InitSymbol := [1, 2, 3, 4, 6, 10, 11, 12, 13, 14, 16, 18 ,21, 24, 25];
      'S': InitSymbol := [2, 3, 4, 6, 12, 13, 14, 20, 22, 23 ,24];
      'T': InitSymbol := [1, 2, 3, 4, 5, 8, 13, 18, 23];
      'U': InitSymbol := [1, 5, 6, 10, 11, 15, 16, 20, 22, 23, 24];
      'V': InitSymbol := [1, 5, 6, 10, 12, 14, 17, 19, 23];
      'W': InitSymbol := [1, 5, 2, 10, 11, 13, 15, 17, 19, 22, 24];
      'X': InitSymbol := [1, 5, 7, 9, 13, 17, 19, 21, 25];
      'Y': InitSymbol := [1, 5, 7, 9, 13, 17, 21];
      'Z': InitSymbol := [1, 2, 3, 4, 5, 9, 13, 17, 21, 22, 23, 24, 25]
    END
  ELSE
    InitSymbol := [1 .. 25];
END; {InitSymbol}

PROCEDURE PrintStr(VAR F: TEXT; Pl: TSymbols; StrNum: INTEGER);
VAR
  I: INTEGER;
  S: CHAR;
BEGIN {PrintStr}
  S := '*';
  FOR I := StrNum*Width + 1 TO Width*StrNum + 5
  DO
    IF I IN Pl
    THEN
      WRITE(F, S)
    ELSE
      WRITE(F, ' ')
END; {PrintStr}

PROCEDURE PrintSymbol(VAR F: TEXT; Pl: TSymbols);
{выписывает в file символы только по номерам из множенства}
VAR
  Ch: INTEGER;
  S: CHAR;
BEGIN {PrintSymbol}
  S := '*';
  FOR Ch := 1 TO Max
  DO
    BEGIN
      IF Ch IN Pl
      THEN
        WRITE(F, S)
      ELSE
        WRITE(F, ' ');
      IF Ch MOD Width = 0
      THEN
        WRITELN(F)
    END
END; {PrintSymbol}

BEGIN {UNIT GraphicalPrint}
END. {UNIT GraphicalPrint}
