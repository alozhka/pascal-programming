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


PROCEDURE MergeSortFiles(VAR FOut, F1, F2: WordsFile);
VAR
  Word1, Word2: WordHandle;
  WasInSort: BOOLEAN;
BEGIN {MergeSortFiles}
  WasInSort := FALSE;

  IF NOT EOF(F1)
  THEN
    READ(F1, Word1);
  IF NOT EOF(F2)
  THEN
    READ(F2, Word2);
    
  WHILE (NOT EOF(F1)) AND (NOT EOF(F2))
  DO
    BEGIN
      WasInSort := TRUE;
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
  IF WasInSort
  THEN
    BEGIN
      IF Word1.Value < Word2.Value
      THEN
        WRITE(FOut, Word1, Word2);
      IF Word1.Value > Word2.Value
      THEN
        WRITE(FOut, Word2, Word1);
      IF Word1.Value = Word2.Value
      THEN
        BEGIN
          Word1.Amount := Word1.Amount + Word2.Amount;
          WRITE(FOut, Word1)
        END
    END
  ELSE
    BEGIN
      IF EOF(F2)
      THEN
        WRITE(FOut, Word1);
      IF EOF(F1)
      THEN
        WRITE(FOut, Word2);
    END; 
    
  {Копировать остаток F2 в FOut}
  WHILE NOT EOF(F1)
  DO
    BEGIN
      READ(F1, Word1);
      WRITE(FOut, Word1)
    END;
    
  {Копировать остаток F3 в FOut}
  WHILE NOT EOF(F2)
  DO
    BEGIN
      READ(F2, Word2);
      WRITE(FOut, Word2)
    END;
     
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
      DISPOSE(WTree);
      WTree := TextHandle(FIn)
    END;
  RESET(FRes);
  PrintTypeFile(FRes, FOut)
END; {FileTextHandler}


BEGIN {FilesHandler}
END. {FilesHandler}
