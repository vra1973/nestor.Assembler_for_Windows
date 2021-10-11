format PE GUI 4.0

include '%fasminc%/win32a.inc'

entry start

section '.data' data readable writeable

Caption db 'Опасный Вирус.',0

Text db 'Здравствуйте, я — особо опасный вирус-троян и распространяюсь по интернету.',13,\
'Поскольку мой автор не умеет писать вирусы, приносящие вред, вы должны мне помочь.',13,\
'Сделайте, пожалуйста, следующее:',13,\
'1.Сотрите у себя на диске каталоги C:\Windows и C:\Program files',13,\
'2.Отправьте этот файл всем своим знакомым',13,\
'Заранее благодарен.',0


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
