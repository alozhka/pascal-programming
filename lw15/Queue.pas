UNIT Queue;
INTERFACE
VAR
  PROCEDURE EmptyQ;
  PROCEDURE AddQ(VAR Elt: CHAR);
  PROCEDURE DelQ;
  PROCEDURE HeadQ(VAR Elt: CHAR);
  PROCEDURE WriteQ;

IMPLEMENTATION
VAR
  Q, TEMP: TEXT;
PROCEDURE CopyOpen(VAR F1, F2: TEXT);
 { опирует строку из F1 в F2 без RESET или REWRITE;
  таким образом F1 должен быть готов дл€ чтени€,а F2 дл€ записи,
  но прошлые строки у этих файлов могут быть не пусты }
VAR
  Ch: CHAR;
BEGIN {CopyOpen}
  WHILE NOT EOLN(F1)
  DO
    BEGIN
      READ(F1, Ch);
      WRITE(F2, Ch)
    END
END;{CopyOpen}

PROCEDURE EmptyQ;
{Q := <,/,R>}
BEGIN {EmptyQ}
  REWRITE(Q);
  WRITELN(Q);
  RESET(Q)
END{EmptyQ};

PROCEDURE AddQ(VAR Elt: CHAR);
  {Q = <,x/,R>,где x строка » Elt = a -->
   Q = <,xa/,R> }
BEGIN {AddQ}
  .....
END {AddQ};

PROCEDURE DelQ;
  {(Q = <,/,R> -->)|
   (Q = <,ax/,R>,где a символ и x строка  -->
     Q:= <,x/,R> }
VAR
  Ch: CHAR;
BEGIN {DelQ}
  {удал€ем первый элемент из Q};
  READ(Q, Ch);
  IF NOT EOF(Q)
  THEN {не пустой}
    BEGIN
      REWRITE(Temp);
      CopyOpen(Q, Temp);
      WRITELN(Temp);
      {копируем Temp в Q}
      RESET(Temp);
      REWRITE(Q);
      CopyOpen(Temp, Q);
      WRITELN(Q);
    END;
  RESET(Q)
END {DelQ};

PROCEDURE HeadQ(VAR Elt: CHAR);
  {(Q = <,/,R> --> Elt := '#')|
   (Q = <,ax/,R>,где a символ и x строка  -->
     Elt:= 'a' }
BEGIN  {HeadQ}
  IF NOT EOLN(Q)
  THEN
    READ(Q, Elt)
  ELSE
    Elt := '#';
  RESET(Q)
END{HeadQ};

PROCEDURE WriteQ;
  { (Q = <,x/,R> и OUTPUT =<y,,W>,где y и x строка  -->
     OUTPUT := <y&x/,,W> }
BEGIN {WriteQ}
  CopyOpen(Q, OUTPUT);
  WRITELN(OUTPUT);
  RESET(Q)
END{WriteQ};

BEGIN {UNIT Queue}
END. {UNIT Queue}
