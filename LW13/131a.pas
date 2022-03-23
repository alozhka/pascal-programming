PROGRAM RunBubbleSort(INPUT, OUTPUT);
  
PROCEDURE BubbleSort(VAR INPUT, OUTPUT: TEXT);
VAR
  Sorted, Ch, Ch1, Ch2:CHAR;
  F1, F2:TEXT;
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

BEGIN { BubbleSort }
  { �������� INPUT � F1 }
  REWRITE(F1);
  CopyFile(INPUT, F1);
  Sorted := 'N';
  WHILE Sorted = 'N'
  DO
    BEGIN
      Sorted := 'Y'
      { �������� F1 � F2,�������� �����������������
       � ����������� ������ �������� ������� �� �������}
      { �������� F2 � F1 }
    END;
  { �������� F1 � OUTPUT }
  RESET(F1);
  REWRITE(OUTPUT);
  CopyFile(F1, OUTPUT)
END; { BubbleSort }


BEGIN {RunBubbleSort}
  BubbleSort(INPUT, OUTPUT)
END. {RunBubbleSort}
