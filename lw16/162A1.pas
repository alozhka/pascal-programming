PROGRAM SarahRevere(INPUT, OUTPUT); 
VAR
  W1, W2, W3, W4: CHAR;
  Looking, Land, Sea: BOOLEAN; 
 
BEGIN {SarahRevere}   
  {Инициализация}
  Land := FALSE;
  Sea := FALSE
  WHILE Looking AND NOT (Land OR Sea)   
  DO
    BEGIN
      {движение окна}
      {проверка окна на land}
      {проверка окна на sea}
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
    WRITELN('Sarah didn"t say')
END.  {SarahRevere} 

