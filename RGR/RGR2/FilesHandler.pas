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
  W1, W2: WordHandle;
  State: STRING[10];
BEGIN {MergeSortFiles}
  IF EOF(F1) AND EOF(F2)
  THEN
    State := 'Finish';
  IF EOF(F1) OR  EOF(F2)
  THEN
    State := 'Copy Tail'
  ELSE
    State := 'In Sort';
    
  IF State = 'In Sort'
  THEN
    BEGIN
      W1.Value := '*';
      W2.Value := '*';
      WHILE ( (NOT EOF(F1)) AND ( NOT EOF(F2) )                              ) OR
            ( (NOT EOF(F1)) AND (W1.Value <= W2.Value) AND (W2.Value <> '*') ) OR
            ( (NOT EOF(F2)) AND (W2.Value <= W1.Value) AND (W1.Value <> '*') )
      DO
        BEGIN
          IF (NOT EOF(F1)) AND (W1.Value = '*')
          THEN
            READ(F1, W1);
          IF (NOT EOF(F2)) AND (W2.Value = '*')
          THEN
            READ(F2, W2);
          IF W1.Value < W2.Value
          THEN
            BEGIN
              WRITE(FOut, W1);
              W1.Value := '*'
            END
          ELSE
            IF W2.Value < W1.Value
            THEN
              BEGIN
                WRITE(FOut, W2);
                W2.Value := '*'
              END
            ELSE
              IF W1.Value = W2.Value
              THEN
                BEGIN
                  W1.Amount := W1.Amount + W2.Amount;
                  WRITE(FOut, W1);
                  W1.Value := '*';
                  W2.Value := '*'
                END
        END;
      
      IF W1.Value <> '*'
      THEN
        WRITE(FOut, W1);
      IF W2.Value <> '*'
      THEN
        WRITE(FOut, W2);
      State := 'Copy Tail'
    END;

  IF State = 'Copy Tail'
  THEN
    IF NOT EOF(F1)
    THEN
      CopyTypeFile(F1, FOut)
    ELSE
      IF NOT EOF(F2)
      THEN
        CopyTypeFile(F2, FOut)
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
      DISPOSE(WTree);
      WTree := TextHandle(FIn)
    END;
  RESET(FRes);
  PrintTypeFile(FRes, FOut)
END; {FileTextHandler}


BEGIN {FilesHandler}
END. {FilesHandler}
