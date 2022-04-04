PROGRAM StringToNumber(INPUT, OUTPUT);
VAR
  N: INTEGER;

PROCEDURE ReadDigit(VAR F: TEXT; VAR D: INTEGER);
{Считывает текущий символ из файл. Если он - цифра, возвращает его
 преобразуя в значение типа INTEGER. Если считанный символ не цифра
 возвращает -1}
VAR
  Ch: CHAR;
BEGIN {ReadDigit}
  READ(F, Ch);
  IF Ch = '0' THEN D := 0 ELSE
  IF Ch = '1' THEN D := 1 ELSE
  IF Ch = '2' THEN D := 2 ELSE
  IF Ch = '3' THEN D := 3 ELSE
  IF Ch = '4' THEN D := 4 ELSE
  IF Ch = '5' THEN D := 5 ELSE
  IF Ch = '6' THEN D := 6 ELSE
  IF Ch = '7' THEN D := 7 ELSE
  IF Ch = '8' THEN D := 8 ELSE
  IF Ch = '9' THEN D := 9 ELSE D := -1
END; {ReadDigit}

PROCEDURE ReadNumber(VAR F: TEXT; VAR N: INTEGER);
{Преобразует строку цифр из файла до первого нецифрового символа,  в соответствующее целое число N}
VAR
  Digit: INTEGER;
BEGIN {ReadNumber}
  Digit := 0;
  WHILE (NOT EOLN(F)) AND (Digit <> -1) AND (N <= ((MaxINT - Digit) DIV 10)) //не конец строки файле и символ число и нет переполнения
  DO 
    BEGIN
      N := N * 10 + Digit;
      ReadDigit(F, Digit)
    END;
  IF Digit <> -1 // последним было число
  THEN
    IF N <= ((MaxINT - Digit) DIV 10) //нет переполнения
    THEN
      N := N * 10 + Digit
    ELSE                              //будет переполнение
      N := -2;
  IF N = 0  //в числовую строку ничего не добавили, т.е. нет чисел
  THEN
    N := -1;
END; {ReadNumber}

BEGIN {StringToNumber}
  N := 0;
  ReadNumber(INPUT, N);
  WRITELN(N)
END. {StringToNumber}
