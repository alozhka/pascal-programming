PROGRAM CountWords(INPUT, OUTPUT);
USES
  TextHandler;
VAR
  WordsTree: Tree;

BEGIN {CountWords}
  WordsTree := NIL;
  WordsTree := TextHandle(INPUT);
  PrintTree(OUTPUT, WordsTree);
  WRITELN('����� ', CWords, ' ����, �� ��� ����������: ', CUniqueWords)
END. {CountWords}
//���������� �������� ������������ 
//������� rgr � �������� �����������
