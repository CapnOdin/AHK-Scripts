#Persistent
#SingleInstance, force

hookProcAdr := RegisterCallback("HookProc")
hHook := SetWinEventHook(0x800B,0x800B,0,hookProcAdr,0,0,0)    ; EVENT_OBJECT_LOCATIONCHANGE 

Gui, +hwndChildhWnd
Gui, Add, text, ,some text in a small gui that will move around with a notepad window
Gui, Add, Button, ,Button
Gui, Add, Picture, vtest, unf.png

Run notepad.exe
WinWait, ahk_class Notepad
MainhWnd := WinExist("ahk_class Notepad")

WinGetPos, mX, mY, mW, mH, ahk_id %MainhWnd%
offset := mW
cX := mX + offset
cY := mY

Gui, show, x%cX% y%cY%

return

;#######################################################################

HookProc(hWinEventHook, event, hwnd) 
{ 
    global   MainHwnd, ChildhWnd 
    if (hwnd = MainHwnd)
    {
        SetWinDelay, -1 
        WinGetPos hX, hY, hW, hH, ahk_id %MainhWnd% 
        WinGetPos cX, cY, cW, cH, ahk_id %ChildhWnd% 

        X := hX + hW
        Y := hY

        WinMove ahk_id %ChildhWnd%,,X,Y 
    }
} 

SetWinEventHook(eventMin, eventMax, hmodWinEventProc, lpfnWinEventProc, idProcess, idThread, dwFlags) { 
    DllCall("CoInitialize", "uint", 0) 
    return DllCall("SetWinEventHook", "uint", eventMin, "uint", eventMax, "uint", hmodWinEventProc, "uint", lpfnWinEventProc, "uint", idProcess, "uint", idThread, "uint", dwFlags) 
}
