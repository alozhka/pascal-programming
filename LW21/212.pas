PROGRAM Encryption(INPUT, OUTPUT);
{��������� ������� �� INPUT � ��� �������� Chiper 
  � �������� ����� ������� � OUTPUT}
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
{��������� Code ���� ������}
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
{������� ������� �� Code, ��������������� �������� �� S}
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
  {���������������� Code}
  Initialize(Crypto, KeyValue, Plenty);
  WHILE NOT EOF
  DO
    BEGIN
      {������ ������ � Msg � ����������� ��}
      I := 0;
      WHILE NOT EOLN AND (I < Len)
      DO
        BEGIN
          I := I + 1;
          READ(Msg[I]);
          WRITE(Msg[I])
        END;
      READLN;
      {����������� ������������ ���������}
      Encode(Msg, KeyValue, Plenty, I);
      WRITELN
    END
END. {Encryption}
