#SingleInstance Force
#NoTrayIcon
IniRead, OutputVar, Hotkeys.ini, Variables, Key
IniRead, Variable, ..\Vars.inc, Variables, ReplaceWin
IniRead, Position, ..\Vars.inc, Variables, Position
IniRead, RainmeterPath, Hotkeys.ini, Variables, RMPATH

Hotkey,%OutputVar%,Button
Return

Button:
    if (Position = "MousePosition")
    {
        MouseGetPos, xpos, ypos 
        Run "%RainmeterPath%" [!CommandMeasure Func mixerMoveMouse(%xpos%`,%ypos%) YourMixer\Main]
    }
    Run "%RainmeterPath%" [!UpdateMeasure mToggle YourMixer\Main]
Return
