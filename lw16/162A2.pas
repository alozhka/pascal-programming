PROGRAM SarahRevere(INPUT, OUTPUT); 
VAR
  W1, W2, W3, W4: CHAR;
  Looking, Land, Sea: BOOLEAN; 
 
BEGIN {SarahRevere}   
  {Инициализация}
  Land := FALSE;
  Sea := FALSE;
  Looking := TRUE;
  IF NOT EOLN
  THEN
    READ(W2);
  IF NOT EOLN
  THEN
    READ(W3);
  IF NOT EOLN
  THEN
    READ(W4);
  WHILE Looking AND NOT (Land OR Sea)   
  DO
    BEGIN
      {движение окна}
      W1 := W2;
      W2 := W3;
      W3 := W4;
      IF NOT EOLN
      THEN
        READ(W4)
      ELSE
        Looking := FALSE;
      {проверка окна на land}
      Land := (W1 = 'l') AND (W2 = 'a') AND (W3 = 'n') AND (W4 = 'd');
      {проверка окна на sea}
      Sea := (W1 = 's') AND (W2 = 'e') AND (W3 = 'a')
    END;
  {создание сообщения Sarah}
  IF Land
  THEN
    WRITELN('The british are coming by land.');
  IF Sea
  THEN
    WRITELN('The british are coming by sea');
  IF (NOT Land) AND (NOT Sea)
  THEN
    WRITELN('Sarah didn''t say')
END.  {SarahRevere} 

