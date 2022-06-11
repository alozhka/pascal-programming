UNIT FilesHandler;
INTERFACE
PROCEDURE FileTextHandle(VAR FIn, FOut: TEXT);
IMPLEMENTATION


USES
  TextHandler;
TYPE
  SwitchRange = 1 .. 2;
  WordsFile = FILE OF WordHandle;


PROCEDURE GetTreeIntoFile(VAR FOut: WordsFile; Ptr: Tree);
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN {Печатает поддерево слева, вершину, поддерево справа}
    BEGIN
      GetTreeIntoFile(FOut, Ptr^.LLink);
      WRITE(FOut, Ptr^.Word);
      GetTreeIntoFile(FOut, Ptr^.RLink)
    END
END; {PrintTree}   


PROCEDURE CopyTypeFile(VAR FIn, FOut: WordsFile);
VAR
  Word: WordHandle;
BEGIN {CopyTipeFile}
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      READ(FIn, Word);
      WRITE(FOut, Word)
    END
END; {CopyTipeFile}


PROCEDURE MergeSortFiles(VAR FOut, F1, F2: WordsFile);
VAR
  Word1, Word2: WordHandle;
  HadSort, Is1Defined, Is2Defined: BOOLEAN;
BEGIN {MergeSortFiles}
  Is1Defined := TRUE;
  Is2Defined := TRUE;
  IF NOT EOF(F1)
  THEN
    READ(F1, Word1)
  ELSE
    Is1Defined := FALSE;
  IF NOT EOF(F2)
  THEN
    READ(F2, Word2)
  ELSE
    Is2Defined := FALSE;
  IF Is1Defined AND Is2Defined
  THEN
    BEGIN
      WHILE (NOT EOF(F1)) AND (NOT EOF(F2))
      DO
        BEGIN
          IF Word1.Value < Word2.Value
          THEN
            BEGIN
              WRITE(FOut, Word1);
              READ(F1, Word1)
            END;
          IF Word1.Value > Word2.Value
          THEN
            BEGIN                                
              WRITE(FOut, Word2);
              READ(F2, Word2)
            END;
          IF Word1.Value = Word2.Value
          THEN
            BEGIN
              Word1.Amount := Word1.Amount + Word2.Amount;
              WRITE(FOut, Word1);
              READ(F1, Word1);
              READ(F2, Word2)
            END;
        END;
      {last iteration}
      IF Word1.Value < Word2.Value
      THEN
        BEGIN
          WRITE(FOut, Word1, Word2);
          CopyTypeFile(F2, FOut)
        END;
      IF Word1.Value > Word2.Value
      THEN
        BEGIN
          WRITE(FOut, Word2, Word1);
          CopyTypeFile(F1, FOut)
        END;
      IF Word1.Value = Word2.Value
      THEN
        BEGIN
          Word1.Amount := Word1.Amount + Word2.Amount;
          WRITE(FOut, Word1);
          CopyTypeFile(F1, FOut);
          CopyTypeFile(F2, FOut)
        END
    END
  ELSE
    IF Is1Defined
    THEN
      BEGIN
        RESET(F1);
        CopyTypeFile(F1, FOut)
      END
    ELSE
      IF Is2Defined
      THEN
        BEGIN
          RESET(F2);
          CopyTypeFile(F2, FOut)
        END;
  IF Is1Defined AND Is2Defined
  THEN
    BEGIN
      {copy remains F2 in FOut}
      HadSort := FALSE;
      WHILE NOT EOF(F1)
      DO
        BEGIN
          HadSort := TRUE;
          READ(F1, Word1);
          IF Word1.Value < Word2.Value
          THEN
            WRITE(FOut, Word1);
          IF Word1.Value > Word2.Value
          THEN
            WRITE(FOut, Word2);
          IF Word1.Value = Word2.Value
          THEN
            BEGIN
              Word1.Amount := Word1.Amount + Word2.Amount;
              WRITE(FOut, Word1)
            END 
        END;
      IF (EOF(F1)) AND HadSort
      THEN
        WRITE(FOut, Word2);
      {copy remains F2 in FOut}
      HadSort := FALSE;
      WHILE NOT EOF(F2)
      DO
        BEGIN
          HadSort := TRUE;
          READ(F2, Word2);
          IF Word1.Value < Word2.Value
          THEN
            WRITE(FOut, Word1);
          IF Word1.Value > Word2.Value
          THEN
            WRITE(FOut, Word2);
          IF Word1.Value = Word2.Value
          THEN
            BEGIN
              Word2.Amount := Word2.Amount + Word1.Amount;
              WRITE(FOut, Word2)
            END 
        END;
      IF (EOF(F2)) AND HadSort
      THEN
        WRITE(FOut, Word1)
    END
END; {MergeSortFiles}


PROCEDURE PrintTypeFile(VAR FIn: WordsFile; VAR FOut: TEXT);
VAR
  Word: WordHandle;
  UniqueWords: LONGINT;
BEGIN {PrintTypeFile}
  UniqueWords := 0;
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      UniqueWords := UniqueWords + 1;
      READ(FIn, Word);
      WRITELN(FOut, Word.Value, ' ', Word.Amount)
    END;
  WRITELN('Всего слов: ', CWords, ', из них уникальных: ', UniqueWords)
END; {PrintTypeFile}


PROCEDURE FileTextHandle(VAR FIn, FOut: TEXT);
VAR
  WTree: Tree;
  FWords, FTemp, FRes: WordsFile;
  Switch: SwitchRange;
BEGIN {FileTextHandler}
  CWords := 0;
  Switch := 2; //устанавльвает номер temp(1,2).dat файла 
               //для результурующего файла FRes который в switch
  ASSIGN(FWords, 'Data/TreeData.dat');
  ASSIGN(FTemp, 'Data/Temp1.dat');
  ASSIGN(FRes, 'Data/Temp2.dat');
  REWRITE(FWords);
  REWRITE(FTemp);
  REWRITE(FRes);
  WTree := NIL;
  
  WTree := TextHandle(FIn);
  WHILE WTree <> NIL
  DO
    BEGIN
      CLOSE(FRes);
      CLOSE(FTemp);
      IF Switch = 1
      THEN
        BEGIN
          ASSIGN(FRes, 'Data/Temp1.dat');
          ASSIGN(FTemp, 'Data/Temp2.dat');
          Switch := 2
        END
      ELSE
        BEGIN
          ASSIGN(FTemp, 'Data/Temp1.dat');
          ASSIGN(FRes, 'Data/Temp2.dat');
          Switch := 1
        END;
      REWRITE(FWords);
      GetTreeIntoFile(FWords, WTree);
      RESET(FWords);
      RESET(FTemp);
      REWRITE(FRes);
      MergeSortFiles(FRes, FWords, FTemp);
      PrintTree(OUTPUT, WTree);
      WRITE(OUTPUT, CIterWords);
      WRITELN(OUTPUT);
      DISPOSE(WTree);
      WTree := TextHandle(FIn)
    END;
  RESET(FRes);
  PrintTypeFile(FRes, FOut)
END; {FileTextHandler}


BEGIN {FilesHandler}
END. {FilesHandler}
