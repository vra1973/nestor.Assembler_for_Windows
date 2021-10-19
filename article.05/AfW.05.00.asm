; Create simpl window & menu
format PE GUI 4.0
entry start
include '%fasminc%\win32a.inc'
include '%fasminc%\encoding\WIN1251.INC'

section '.data' data readable writeable

class db 'FASMWIN32',0
title db 'ОКНО',0
title2 db 'wparam =',0
str_wmcommand  db 'wmcommand',0
hwnd dd ?

mb111 db 'Пункт 1-1-1',0
mb12 db 'Пункт 1-2',0
mb13 db ' Пункт 1-3',13,10,'END PROGRAMM ?',0
mb30 db ' Пункт 3-0',0
hmenu dd ?
menuinfo MENUITEMINFO sizeof.MENUITEMINFO,MIIM_STATE


wc WNDCLASS 0,WindowProc,0,0,0,0,0,COLOR_BTNFACE+1,0,class

msg MSG

section '.code' code readable executable

start:
invoke GetModuleHandle,0
mov [wc.hInstance],eax
invoke LoadIcon,0,IDI_APPLICATION
mov [wc.hIcon],eax
invoke LoadCursor,0,IDC_ARROW
mov [wc.hCursor],eax
invoke RegisterClass,wc
cmp eax,0
je error
invoke LoadMenu,[wc.hInstance],1
mov [hmenu],eax

invoke CreateWindowEx,0,class,title,WS_VISIBLE+WS_OVERLAPPEDWINDOW,CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT,\
0,eax,[wc.hInstance],0

cmp eax,0
je error
mov [hwnd],eax
msg_loop:
invoke GetMessage,msg,0,0,0
cmp eax,0
je end_loop
invoke IsDialogMessage,[hwnd],msg
cmp eax,0
jne msg_loop
invoke TranslateMessage,msg
invoke DispatchMessage,msg
jmp msg_loop

error:
invoke MessageBox,0,0,0,0

end_loop:
invoke ExitProcess,[msg.wParam]


proc WindowProc hwnd,wmsg,wparam,lparam
push ebx esi edi
cmp [wmsg],WM_COMMAND
je .wmcommand
cmp [wmsg],WM_DESTROY
je .wmdestroy
.defwndproc:
invoke DefWindowProc,[hwnd],[wmsg],[wparam],[lparam]
jmp .finish
.wmcommand:
;invoke MessageBox,0,str_wmcommand,title2,MB_OK
cmp [wparam],111
je .111
cmp [wparam],12
je .12
cmp [wparam],13
je .13
cmp [wparam],21
je .21
cmp [wparam],30
je .30
jmp .finish

.111:
invoke MessageBox,0,mb111,title,MB_OK
jmp .finish
.12:
invoke MessageBox,0,mb12,title,MB_OK
jmp .finish
.13:
invoke MessageBox,0,mb13,title,MB_OKCANCEL
jmp .finish

.30:
invoke MessageBox,0,mb30,title,MB_OK
jmp .finish

.21:
invoke GetMenuItemInfo,[hmenu],21,0,menuinfo
xor [menuinfo.fState],MFS_CHECKED
invoke SetMenuItemInfo,[hmenu],21,0,menuinfo
jmp .finish
.wmdestroy:
invoke PostQuitMessage,0
mov eax,0
.finish:
pop edi esi ebx
ret
endp



section '.idata' import data readable writeable

library kernel32,'KERNEL32.DLL',\
user32,'USER32.DLL'

include 'api\kernel32.inc'
include 'api\user32.inc'

section '.rsrc' resource data readable
directory RT_MENU,menus

resource menus,\
1,LANG_RUSSIAN+SUBLANG_DEFAULT,main_menu

menu main_menu
menuitem 'Меню 1',10,MFR_POPUP
menuitem 'Пункт 1-1',11,MFR_POPUP
menuitem 'Пункт 1-1-1',111,MFR_END
menuitem 'Пункт 1-2',12,MFT_STRING,MF_ENABLED  ;|MFR_END,MFS_GRAYED
menuseparator
menuitem 'Пункт 1-3',13,MFR_END,MFS_DEFAULT
menuitem 'Меню 2',20,MFR_POPUP
menuitem 'Пункт 2-1',21,MFR_END,MFS_CHECKED
menuitem 'Меню 3',30,MFR_END

; EOF