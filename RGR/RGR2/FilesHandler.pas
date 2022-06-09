UNIT FilesHandler;
INTERFACE
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
          WRITE(FOut, Word1);
          READ(F1, Word1);
          READ(F2, Word2)
        END
    END;
  WHILE NOT EOF(F1)
  DO
    BEGIN
      IF Word1 < Word2
      THEN
        BEGIN
          WRITE(//глянь Merge процедуру в какой-то из лаб
    END
END; {MergeSortFiles}

BEGIN {FilesHandler}
END. {FilesHandler}
