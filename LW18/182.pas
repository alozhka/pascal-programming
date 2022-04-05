PROGRAM AverageScore(INPUT, OUTPUT);
CONST
  NumberOfScores = 4;
  ClassSize = 3;
  EndOfLastName = ' ';
TYPE
  Score = 0..100;
VAR
  WhichScore: 1..NumberOfScores;
  Student: 1..ClassSize;
  NextScore: Score;
  Ave, TotalScore, ClassTotal: INTEGER;
  F: TEXT;
  Ch: CHAR;
BEGIN{AverageScore}
  ASSIGN(F, 'Marks.txt');
  RESET(F);
  ClassTotal := 0;
  WRITELN('Student averages:');
  Student := 1;
  NextScore := 0;
  WHILE (Student <= ClassSize) AND (NOT EOF(F))
  DO 
    BEGIN
      Ch := '#';
      WHILE Ch <> EndOfLastName
      DO
        BEGIN
          READ(F, Ch);
          WRITE(OUTPUT, Ch)
        END;
      TotalScore := 0;
      WhichScore := 1;
      WHILE WhichScore <= NumberOfScores
      DO
        BEGIN
          READ(F, NextScore);
          TotalScore := TotalScore + NextScore;
          WhichScore := WhichScore + 1
        END;
      READLN(F);
      TotalScore := TotalScore * 10;
      Ave := TotalScore DIV NumberOfScores;
      IF Ave MOD 10 >= 5
      THEN
        WRITELN(OUTPUT, Ave DIV 10 + 1)
      ELSE
        WRITELN(OUTPUT, Ave DIV 10);
      ClassTotal := ClassTotal + TotalScore;
      Student := Student + 1
    END;
  WRITELN;
  WRITELN(OUTPUT, 'Class average:');
  ClassTotal := ClassTotal DIV (ClassSize * NumberOfScores);
  WRITELN(OUTPUT, ClassTotal DIV 10, '.', ClassTotal MOD 10)
END.{AverageScore}
