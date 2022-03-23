PROGRAM RunBubbleSort(INPUT, OUTPUT);


//CopyFile
PROCEDURE CopyFile(VAR InFile, OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN{CopyFile}
  WHILE NOT EOLN(InFile)
  DO
    BEGIN
      READ(InFile, Ch);
      WRITE(OutFile, Ch)
    END;
  WRITELN(OutFile)
END; {CopyFile}

//CopySwap
PROCEDURE CopySwap(VAR F1, F2: TEXT; VAR Sorted: CHAR);
VAR
  Ch1, Ch2: CHAR;
BEGIN {CopySwap}
  { �������� F1 � F2,�������� �����������������
  � ����������� ������ �������� ������� �� �������}
  Sorted := 'Y'; 
  IF NOT EOLN(F1)
  THEN
    BEGIN
      READ(F1,Ch1);
      WHILE NOT EOLN(F1)
      DO { �� ������� ���� ��� ������� �������� ��� Ch1,Ch2 }
        BEGIN
          READ(F1, Ch2);
          { �������   min(Ch1,Ch2) �  F2, ���������
          ��������������� ������� }
          IF Ch1 <= Ch2
          THEN
            BEGIN
              WRITE(F2, Ch1);
              Ch1 := Ch2
            END
          ELSE
            BEGIN
              WRITE(F2, Ch2);
              Sorted := 'N'
            END
        END;
      WRITELN(F2, Ch1) { ������� ��������� ������ � F2 }
    END
END; {CopySwap}

PROCEDURE BubbleSort(VAR INPUT, OUTPUT: TEXT);
VAR
  Sorted: CHAR;
  F1, F2: TEXT;
BEGIN { BubbleSort }
  { �������� INPUT � F1 }
  REWRITE(F1);
  CopyFile(INPUT, F1);
  Sorted := 'N';
  WHILE Sorted = 'N'
  DO
    BEGIN
      { �������� F1 � F2,�������� �����������������
       � ����������� ������ �������� ������� �� �������}
      RESET(F1);
      REWRITE(F2);
      CopySwap(F1, F2, Sorted);
      { �������� F2 � F1 }
      RESET(F2);
      REWRITE(F1);
      CopyFile(F2, F1)
    END;
  { �������� F1 � OUTPUT }
  RESET(F1);
  REWRITE(OUTPUT);
  CopyFile(F1, OUTPUT)
END; { BubbleSort }


BEGIN {RunBubbleSort}
  BubbleSort(INPUT, OUTPUT)
END. {RunBubbleSort}
