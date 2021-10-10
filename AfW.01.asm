include '%fasminc%/win32ax.inc'

.data
Caption db 'Моя первая программа.',0
Text db 'Всем привет!',0

.code
start:
invoke MessageBox,0,Text,Caption,MB_OK
invoke ExitProcess,0

.end start
