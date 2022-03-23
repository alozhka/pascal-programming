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
  { Копируем INPUT в F1 }
  REWRITE(F1);
  CopyFile(INPUT, F1);
  Sorted := 'N';
  WHILE Sorted = 'N'
  DO
    BEGIN
      Sorted := 'Y'
      { Копируем F1 в F2,проверяя отсортированность
       и переставляя первые соседние символы по порядку}
      { Копируем F2 в F1 }
    END;
  { Копируем F1 в OUTPUT }
  RESET(F1);
  REWRITE(OUTPUT);
  CopyFile(F1, OUTPUT)
END; { BubbleSort }


BEGIN {RunBubbleSort}
  BubbleSort(INPUT, OUTPUT)
END. {RunBubbleSort}
