format PE GUI 4.0

include 'win32a.inc'

invoke mciSendString,_cd_state,_ret,5,0
invoke MessageBoxA,0,_ret,_caption,MB_OK
invoke lstrcmp,_ret,_ret_open
cmp eax,0
je close
;open:
invoke mciSendString,_cd_open,0,0,0
invoke mciSendString,_cd_state,_ret,5,0
invoke MessageBoxA,0,_ret,_caption3,MB_OK

jmp exit
close:
invoke mciSendString,_cd_close,0,0,0
invoke mciSendString,_cd_state,_ret,5,0
invoke MessageBoxA,0,_ret,_caption2,MB_OK
exit:
invoke ExitProcess,0

_cd_state db 'status cdaudio mode',0
_cd_open db 'set cdaudio door open',0
_cd_close db 'set cdaudio door closed',0
_ret_open db 'open',0
_ret db 5 dup (?)
_caption db '_ret = ',0
_caption2 db '_ret = close ?',0
_caption3 db '_ret = open ?',0

data import

library kernel32,'KERNEL32.DLL',\
user32,'USER32.DLL',\
winmm,'WINMM.DLL'

import kernel32,\
ExitProcess,'ExitProcess',\
GetWindowsDirectory,'GetWindowsDirectory',\
lstrcmp,'lstrcmpA'

import user32,\
MessageBoxA,'MessageBoxA'

import winmm,\
mciSendString,'mciSendStringA',\
PlaySound,'PlaySoundA'
end data

