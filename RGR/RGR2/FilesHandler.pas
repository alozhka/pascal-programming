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
  InSort, Is1Defined, Is2Defined: BOOLEAN;
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
    IF (NOT EOF(F1)) AND (NOT EOF(F2))
    THEN  //files have 2 and more symbols
   {1}BEGIN
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
              END
          END;
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
              END
          END;
          WHILE NOT EOF(F1)
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
              WRITE(FOut, Word2);
            IF Word1.Value = Word2.Value
            THEN
              BEGIN
                Word1.Amount := Word1.Amount + Word2.Amount;
                WRITE(FOut, Word1);
                READ(F1, Word1)
              END
          END;
        {last iteration}
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
          END;
        {copy remains F2 in FOut}
        WHILE NOT EOF(F1)
        DO
          BEGIN
            READ(F1, Word1);
            WRITE(FOut, Word1)
          END;
        {copy remains F2 in FOut}
        WHILE NOT EOF(F2)
        DO
          BEGIN
            READ(F2, Word2);
            WRITE(FOut, Word2)
          END   
   {1}END
    ELSE  //at least one among files have only one symbol
   {2}BEGIN
        InSort := TRUE;
        {F1 has only 1 symbol}
        IF EOF(F1)
        THEN
          BEGIN {if}
            WHILE (NOT EOF(F2)) AND (NOT InSort)
            DO
              BEGIN {while}
                IF Word2.Value < Word1.Value
                THEN
                  BEGIN
                    WRITE(FOut, Word2);
                    READ(F2, Word2)
                  END;
                IF Word2.Value > Word1.Value
                THEN
                  BEGIN
                    WRITE(FOut, Word1);
                    InSort := TRUE
                  END;
                IF Word1.Value = Word2.Value
                THEN
                  BEGIN
                    Word2.Amount := Word2.Amount + Word1.Amount;
                    WRITE(FOut, Word2);
                    InSort := TRUE
                  END;
              END; {while}
            IF EOF(F2)
            THEN
              BEGIN {EOF(F2)}
                IF Word1.Value = Word2.Value
                THEN
                  BEGIN
                    Word1.Amount := Word1.Amount + Word2.Amount;
                    WRITE(FOut, Word1);
                  END;
                IF Word1.Value < Word2.Value
                THEN
                  WRITE(FOut, Word1);
                IF Word1.Value > Word2.Value
                THEN
                  WRITE(FOut, Word2)
              END {EOF(F2)}
            ELSE
              CopyTypeFile(F2, FOut)
          END; {if}
        {F2 has only 1 symbol}
        IF EOF(F2)
        THEN
          BEGIN {if}
            WHILE (NOT EOF(F1)) AND InSort
            DO
              BEGIN {while}
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
                    InSort := FALSE
                  END;
                IF Word1.Value = Word2.Value
                THEN
                  BEGIN
                    Word1.Amount := Word1.Amount + Word2.Amount;
                    WRITE(FOut, Word1);
                    InSort := FALSE
                  END  
              END; {while}
            IF EOF(F1)
            THEN
              BEGIN {EOF(F1)}
                IF Word1.Value = Word2.Value
                THEN
                  BEGIN
                    Word2.Amount := Word1.Amount + Word2.Amount;
                    WRITE(FOut, Word2);
                  END;
                IF Word1.Value < Word2.Value
                THEN
                  WRITE(FOut, Word1);
                IF Word1.Value > Word2.Value
                THEN
                  WRITE(FOut, Word2)
              END {EOF(F1)}
            ELSE
              CopyTypeFile(F1, FOut)
          END {if}
   {2}END
  ELSE    // someone is not defined
 {3}BEGIN  
      IF Is1Defined
      THEN
        BEGIN
          RESET(F1);
          CopyTypeFile(F1, FOut)
        END;
      IF Is2Defined
      THEN
        BEGIN
          RESET(F2);
          CopyTypeFile(F2, FOut)
        END
 {3}END
     
END; {MergeSortFiles}


PROCEDURE PrintTypeFile(VAR FIn: WordsFile; VAR FOut: TEXT);
VAR
  Word: WordHandle;
BEGIN {PrintTypeFile}
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      READ(FIn, Word);
      WRITELN(FOut, Word.Value, ' ', Word.Amount)
    END;
  WRITELN('Всего слов: ', CWords, ', из них уникальных: ', CUniqueWords)
END; {PrintTypeFile}


PROCEDURE FileTextHandle(VAR FIn, FOut: TEXT);
VAR
  WTree: Tree;
  FWords, FTemp, FRes: WordsFile;
  Switch: SwitchRange;
BEGIN {FileTextHandler}
  CWords := 0;
  CUniqueWords := 0;
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
      CUniqueWords := CUniqueWords + CIterWords;
      REWRITE(FWords);
      GetTreeIntoFile(FWords, WTree);
      RESET(FWords);
      RESET(FTemp);
      REWRITE(FRes);
      MergeSortFiles(FRes, FWords, FTemp);
      PrintTree(OUTPUT, WTree);
      WRITELN(OUTPUT);
      DISPOSE(WTree);
      WTree := TextHandle(FIn)
    END;
  RESET(FRes);
  PrintTypeFile(FRes, FOut)
END; {FileTextHandler}


BEGIN {FilesHandler}
END. {FilesHandler}
