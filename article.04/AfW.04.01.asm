; Create simpl window
format PE GUI 4.0
entry start

include '%fasminc%/win32a.inc'

section '.data' data readable writeable

class db 'FASMWIN32',0
title db 'ОКНО',0
classb db 'BUTTON',0
classe db 'EDIT',0
classs db 'STATIC',0
textb1 db 'Копировать',0
textb2 db 'Очистить',0
textg db 'Рамка',0
texts db 'Текст',0
textc db 'Очистить все',0
errtxt db 'Ошибка',0
hwnd dd ?
hwnde dd ?
hwnds dd ?
hwnds_2 dd ?
hwnds_3 dd ?
hwnds_4 dd ?

hwndc dd ?
text rb 100
text_2 rb 100
text_3 rb 100
text_4 rb 100

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

invoke CreateWindowEx,0,class,title,WS_VISIBLE+ WS_SYSMENU,128,128,500,400,0,0,[wc.hInstance],0
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
invoke MessageBox,0,errtxt,0,MB_ICONERROR+MB_OK

end_loop:
invoke ExitProcess,[msg.wParam]

proc WindowProc hwnd,wmsg,wparam,lparam
push ebx esi edi
cmp [wmsg],WM_CREATE
je .wmcreate
cmp [wmsg],WM_COMMAND
je .wmcommand
cmp [wmsg],WM_DESTROY
je .wmdestroy
.defwndproc:
invoke DefWindowProc,[hwnd],[wmsg],[wparam],[lparam]
jmp .finish
.wmcreate:
invoke CreateWindowEx,0,classb,textg,WS_VISIBLE+ WS_CHILD+ BS_GROUPBOX,5,5,485,350,[hwnd],1000,[wc.hInstance],0    ; Frame - BUTTON class
invoke CreateWindowEx,0,classb,textb1,WS_VISIBLE+WS_CHILD+ BS_PUSHBUTTON+WS_TABSTOP,20,300,100,40,[hwnd],1001,[wc.hInstance],0  ; BUTTON - 'Копировать'
invoke CreateWindowEx,0,classb,textb2,WS_VISIBLE+WS_CHILD+ BS_PUSHBUTTON+WS_TABSTOP,130,300,100,40,[hwnd],1002,[wc.hInstance],0 ; BUTTON - 'Очистить'
invoke CreateWindowEx,0,classe,texts,WS_VISIBLE+WS_CHILD+WS_BORDER+ WS_TABSTOP+ES_AUTOHSCROLL,10,25,474,20,[hwnd],1003,[wc.hInstance],0  ; EDIT - 1
mov [hwnde],eax
invoke CreateWindowEx,0,classe,0,WS_VISIBLE+WS_CHILD+WS_BORDER+WS_TABSTOP+ ES_AUTOHSCROLL+ES_READONLY,10,50,474,20,[hwnd],1004,[wc.hInstance],0  ; EDIT - 2
mov [hwnds],eax
invoke CreateWindowEx,0,classe,0,WS_VISIBLE+WS_CHILD+WS_BORDER+WS_TABSTOP+ ES_AUTOHSCROLL+ES_READONLY,10,75,474,20,[hwnd],1004,[wc.hInstance],0  ; EDIT - 22
mov [hwnds_2],eax
invoke CreateWindowEx,0,classe,0,WS_VISIBLE+WS_CHILD+WS_BORDER+WS_TABSTOP+ ES_AUTOHSCROLL+ES_READONLY,10,100,474,20,[hwnd],1004,[wc.hInstance],0  ; EDIT - 23
mov [hwnds_3],eax
invoke CreateWindowEx,0,classe,0,WS_VISIBLE+WS_CHILD+WS_BORDER+WS_TABSTOP+ ES_AUTOHSCROLL+ES_READONLY,10,125,474,20,[hwnd],1004,[wc.hInstance],0  ; EDIT - 24
mov [hwnds_4],eax

invoke CreateWindowEx,0,classb,textc,WS_VISIBLE+WS_CHILD+ BS_AUTOCHECKBOX+WS_TABSTOP,130,275,110,20,[hwnd],1005,[wc.hInstance],0  ; CHECK-BOX
mov [hwndc],eax
invoke CreateWindowEx,0,classs,textg,WS_VISIBLE+ WS_CHILD,435,345,43,17,[hwnd],1006,[wc.hInstance],0    ; STATIC - text
invoke SetFocus,[hwnde]
jmp .finish
.wmcommand:
cmp [wparam],1001
je .but1
cmp [wparam],1002
je .but2
jmp .finish
.but1:
invoke SendMessage,[hwnds_3],WM_GETTEXT,100,text_4
invoke SendMessage,[hwnds_4],WM_SETTEXT,0,text_4

invoke SendMessage,[hwnds_2],WM_GETTEXT,100,text_3
invoke SendMessage,[hwnds_3],WM_SETTEXT,0,text_3

invoke SendMessage,[hwnds],WM_GETTEXT,100,text_2
invoke SendMessage,[hwnds_2],WM_SETTEXT,0,text_2

invoke SendMessage,[hwnde],WM_GETTEXT,100,text
invoke SendMessage,[hwnds],WM_SETTEXT,0,text

jmp .finish
.but2:
invoke SendMessage,[hwnds],WM_SETTEXT,0,0
invoke SendMessage,[hwndc],BM_GETCHECK,0,0
cmp eax,BST_CHECKED
jne .finish
invoke SendMessage,[hwnde],WM_SETTEXT,0,0
invoke SendMessage,[hwnds_2],WM_SETTEXT,0,0
invoke SendMessage,[hwnds_3],WM_SETTEXT,0,0
invoke SendMessage,[hwnds_4],WM_SETTEXT,0,0
invoke SendMessage,[hwndc],BM_SETCHECK,BST_UNCHECKED,0
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

