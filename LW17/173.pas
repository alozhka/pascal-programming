PROGRAM StringToNumbderProcessing(INPUT, OUTPUT);
VAR
  Num, Min, Max, Sum, AvgInt, AvgReal, Counter: INTEGER;

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
  N := 0;
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
  
BEGIN {StringToNumbderProcessing}
  Max := -1 - MaxINT;
  Min := MaxINT;
  Sum := 0;
  Counter := 0;
  IF NOT EOLN
  THEN
    BEGIN
      ReadNumber(INPUT, Num);
      IF NOT (Num IN [-1, -2])
      THEN
        BEGIN
          Counter := Counter + 1;  //количество
          Sum := Sum + Num;        //сумма для avg
          IF Num > Max             //макс
          THEN
            Max := Num;
          IF Num < Min             //мин
          THEN
            Min := Num
        END
      ELSE
        WRITELN('[!] Ошибка: неправильный тип данных, либо переполнение')
    END
  ELSE
    WRITELN('[!] Ошибка: неправильный тип данных, либо переполнение');
  WHILE (NOT EOLN) AND (NOT (Num IN [-1, -2]))
  DO
    BEGIN
      ReadNumber(INPUT, Num);
      IF NOT (Num IN [-1, -2])
      THEN
        BEGIN
          Counter := Counter + 1;  //количество
          Sum := Sum + Num;        //сумма для avg
          IF Num > Max             //макс
          THEN
            Max := Num;
          IF Num < Min             //мин
          THEN
            Min := Num
        END
      ELSE
        WRITELN('[!] Ошибка: неправильный тип данных, либо переполнение')
    END;
  Sum := Sum*10;
  AvgInt := Sum DIV Counter;
  AvgReal := Sum MOD Counter;
  IF NOT (Num IN [-1, -2])
  THEN
    BEGIN
      WRITELN('Количество: ', Counter, ', минималльный: ', Min, ', максимальный: ', Max);
      WRITELN('Среднеее арифметическое: ', AvgInt DIV 10, '.', AvgReal MOD 10);
      WRITELN(5 MOD 2)
    END
END. {StringToNumbderProcessing}
