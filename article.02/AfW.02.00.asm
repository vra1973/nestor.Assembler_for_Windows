format PE GUI 4.0

include '%fasminc%/win32a.inc'

; секции не обозначены, поэтому fasm автоматически создаст секцию .flat
; в которой разместятся и код, и данные, что позволит уменьшить размер файла

invoke MessageBoxA,0,_message,_caption,MB_ICONQUESTION+MB_YESNOCANCEL
cmp eax,IDNO
je close
cmp eax,IDYES
jne exit

;open:
invoke mciSendString,_cd_open,0,0,0
jmp exit

close:
invoke mciSendString,_cd_close,0,0,0

exit:
invoke ExitProcess,0

_message db 'Вам нужна подставка для кофе?',0
_caption db 'Мастер Бытового Обслуживания.',0

_cd_open db 'set cdaudio door open',0
_cd_close db 'set cdaudio door closed',0

; импортируемые данные разместятся в этой же секции:

data import

library kernel32,'KERNEL32.DLL',\
user32,'USER32.DLL',\
winmm,'WINMM.DLL'

import kernel32,\
ExitProcess,'ExitProcess'

import user32,\
MessageBoxA,'MessageBoxA'

import winmm,\
mciSendString,'mciSendStringA'

end data