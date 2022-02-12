#SingleInstance Force
#NoTrayIcon
IniRead, OutputVar, Hotkeys.ini, Variables, Key
IniRead, Position, ..\Vars.inc, Variables, Position
IniRead, RainmeterPath, Hotkeys.ini, Variables, RMPATH

Name = ValliStart.ahk

Hotkey,%OutputVar%,Button

DetectHiddenWindows On
SetTitleMatchMode RegEx
IfWinExist, i)%Name%.* ahk_class AutoHotkey
{
    ValliScriptPath = % RegExReplace(a_scriptdir,"YourMixer.*\\?$")"Vallistart\@Resources\Actions\Source code\Vallistart.ahk"
    ValliAhkPath = % RegExReplace(a_scriptdir,"YourMixer.*\\?$")"Vallistart\@Resources\Actions\AHKv1.exe"
    Run, %ValliAhkPath% `"%ValliScriptPath%`"
}
Return

Button:
    if (Position = "MousePosition")
    {
        MouseGetPos, xpos, ypos 
        Run "%RainmeterPath%" [!CommandMeasure Func MixerMoveMouse(%xpos%`,%ypos%) YourMixer\Main]
    }
    Run "%RainmeterPath%" [!UpdateMeasure mToggle YourMixer\Main]
Return
