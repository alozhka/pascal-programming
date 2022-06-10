UNIT FilesHandler;
INTERFACE
PROCEDURE FileTextHandle(VAR FIn, FOut: TEXT);
IMPLEMENTATION


USES
  TextHandler;
TYPE
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
BEGIN {MergeSortFiles}

  IF NOT EOF(F1)
  THEN
    READ(F1, Word1);
  IF NOT EOF(F2)
  THEN
    READ(F2, Word2);
    
  IF (EOF(F1)) AND (EOF(F2))
  THEN
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
  FWords, FTemp1, FTemp2: WordsFile;
BEGIN {FileTextHandler}
  ASSIGN(FWords, 'TreeData.dat');
  REWRITE(FWords);
  WTree := NIL;
  
  WTree := TextHandle(FIn);
  CUniqueWords := CUniqueWords + CIterWords;
  GetTreeIntoFile(FWords, WTree);
  RESET(FWords);
  
  PrintTypeFile(FWords, FOut)
END; {FileTextHandler}


BEGIN {FilesHandler}
END. {FilesHandler}
