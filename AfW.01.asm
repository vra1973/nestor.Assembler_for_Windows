include '%fasminc%/win32ax.inc'

.data
Caption db '��� ������ ���������.',0
Text db '���� ������!',0

.code
start:
invoke MessageBox,0,Text,Caption,MB_OK
invoke ExitProcess,0

.end start
