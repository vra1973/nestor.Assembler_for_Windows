format PE GUI 4.0

include '%fasminc%/win32a.inc'

entry start

section '.data' data readable writeable

Caption db '������� �����.',0

Text db '������������, � � ����� ������� �����-����� � ��������������� �� ���������.',13,\
'��������� ��� ����� �� ����� ������ ������, ���������� ����, �� ������ ��� ������.',13,\
'��������, ����������, ���������:',13,\
'1.������� � ���� �� ����� �������� C:\Windows � C:\Program files',13,\
'2.��������� ���� ���� ���� ����� ��������',13,\
'������� ����������.',0


section '.code' code readable executable
start:
invoke MessageBox,0,Text,Caption,MB_OK
invoke ExitProcess,0

section '.idata' import data readable writeable
library KERNEL32, 'KERNEL32.DLL',\
USER32, 'USER32.DLL'

import KERNEL32,\
ExitProcess, 'ExitProcess'

import USER32,\
MessageBox, 'MessageBoxA'
