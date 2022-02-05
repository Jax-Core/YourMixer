#SingleInstance Force
#NoTrayIcon
IniRead, OutputVar, Hotkeys.ini, Variables, Key
IniRead, Variable, ..\Vars.inc, Variables, ReplaceWin
IniRead, Position, ..\Vars.inc, Variables, Position
IniRead, RainmeterPath, Hotkeys.ini, Variables, RMPATH

; Menu, Tray, Icon, .\Source code\YourMixer.ico
; Menu, Tray, NoDefault
; Menu, Tray, NoStandard

; OnMessage(0x404, "AHK_NOTIFYICON")

Hotkey,%OutputVar%,Button
Return

; AHK_NOTIFYICON(wParam, lParam)
; {
;     if (lParam = 0x201) ; WM_LBUTTONUP
;     {
;         IniRead, RainmeterPath, Hotkeys.ini, Variables, RMPATH
;         Run "%RainmeterPath%" [!UpdateMeasure mToggle YourMixer\Main]
;         return 
;     }
;     else if (lParam = 0x205) ; WM_RBUTTONUP
;     {
;         return 
;     }
;     else if (lParam = 0x203) ; WM_LBUTTONDBLCLK
;     {
;         return 
;     }
;     else if (lParam = 0x208) ; WM_MBUTTONUP
;     {
;         return 
;     }
; }
; Return

Button:
    if (Position = "MousePosition")
    {
        MouseGetPos, xpos, ypos 
        Run "%RainmeterPath%" [!CommandMeasure Func mixerMoveMouse(%xpos%`,%ypos%) YourMixer\Main]
    }
    Run "%RainmeterPath%" [!UpdateMeasure mToggle YourMixer\Main]
Return
