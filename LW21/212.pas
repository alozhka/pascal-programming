PROGRAM Encryption(INPUT, OUTPUT);
{Переводит символы из INPUT в код согласно Chiper 
  и печатает новые символы в OUTPUT}
CONST
  Len = 20;
TYPE
  RangeInt = 1 .. Len;
  Str = ARRAY [RangeInt] OF CHAR;
  TKeyValue = ARRAY [CHAR] OF CHAR;
  TPlenty = SET OF CHAR;
VAR
  Msg: Str;
  Crypto: TEXT;
  KeyValue: TKeyValue;
  Plenty: TPlenty;
  I: INTEGER;


 
PROCEDURE Initialize(VAR F: TEXT; VAR Code: TKeyValue; VAR Pl: TPlenty);
{Присвоить Code шифр замены}
VAR
  Ch1, Ch2: CHAR;
BEGIN {Initialize}
  WHILE NOT EOF(F)
  DO
    BEGIN
      
      IF NOT EOLN(F)
      THEN
        BEGIN
          READ(F, Ch1);
          IF NOT EOLN(F)
          THEN
            BEGIN
              READ(F, Ch2);
              Code[Ch1] := Ch2;
              Pl := Pl + [Ch1]
            END
        END;
      READLN
    
    END
END;  {Initialize}

 
PROCEDURE Encode(VAR S: Str; VAR Code: TKeyValue; Pl: TPlenty; StrLen: INTEGER);
{Выводит символы из Code, соответствующие символам из S}
VAR
  Index: RangeInt;
BEGIN {Encode}
  FOR Index := 1 TO StrLen
  DO
    IF S[Index] IN Pl
    THEN
      WRITE(Code[S[Index]])
    ELSE
      WRITE(S[Index]);
  WRITELN
END;  {Encode}


 
BEGIN {Encryption}
  ASSIGN(Crypto, 'Cryption.txt');
  {Инициализировать Code}
  Initialize(Crypto, KeyValue, Plenty);
  WHILE NOT EOF
  DO
    BEGIN
      {читать строку в Msg и распечатать ее}
      I := 0;
      WHILE NOT EOLN AND (I < Len)
      DO
        BEGIN
          I := I + 1;
          READ(Msg[I]);
          WRITE(Msg[I])
        END;
      READLN;
      {распечатать кодированное сообщение}
      Encode(Msg, KeyValue, Plenty, I);
      WRITELN
    END
END. {Encryption}
