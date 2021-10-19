format PE GUI 4.0

include '%fasminc%/win32a.inc'

; секции не обозначены, поэтому fasm автоматически создаст секцию .flat
; в которой разместятся и код, и данные, что позволит уменьшить размер файла
start:
invoke mciSendString,_wav_play,0,0,0     ; start sound
invoke mciSendString,_cd_state,_ret,5,0  ; check status cd-rom
invoke MessageBoxA,0,_ret,_caption_status,MB_OK

invoke MessageBoxA,0,_message,_caption,MB_ICONQUESTION+MB_YESNOCANCEL
cmp eax,IDNO
je close
cmp eax,IDYES
jne exit

;open:
invoke mciSendString,_Ring03,0,0,0

invoke MessageBoxA,0,_message_open,_cd_open,MB_OK
invoke mciSendString,_cd_open,0,0,0
jmp exit

close:
invoke mciSendString,_exclamation,0,0,0
invoke MessageBoxA,0,_message_close,_cd_close,MB_OK
invoke mciSendString,_cd_close,0,0,0

exit:
invoke mciSendString,_Ring05,0,0,0
invoke MessageBoxA,0,_message_exit,_caption_exit,MB_YESNO
cmp eax,IDNO
je start

invoke ExitProcess,0

_cd_state db 'status cdaudio mode',0
_ret db 5 dup (?)
_caption_status db 'status cd-rom = ',0

_message db 'Вы хотите извлечь диск cd-rom ?',0
_message_open db 'OPEN CDROM !',0
_message_close db 'CLOSE CDROM !',0
_message_exit db 'EXIT PROGRAMM ?!',0

_caption db 'Выберите действие для cd-rom.',0
_caption_open db 'Мастер Бытового Обслуживания.',0
_caption_exit db 'Вы хотите выйти из программы ?',0

_cd_open db 'set cdaudio door open',0
_cd_close db 'set cdaudio door closed',0

_wav_play db 'play tada.wav',0
_Ring03 db 'play Ring03.wav',0
_Ring05 db 'play Ring05.wav',0
_exclamation db 'play Windows_Exclamation.wav',0

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