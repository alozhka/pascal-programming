PROGRAM ConditionalAssignment(INPUT, OUTPUT);
VAR
  V1, V2: CHAR;
BEGIN {ConditionalAssignment}
  READ(V1, V2);
  IF V1 < V2
  THEN
    V1 := V2
  ELSE
    IF V2 < V1
    THEN
      V2 := V1;
  WRITELN(V1, V2)
END. {ConditionalAssignment}
