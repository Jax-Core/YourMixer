
#SingleInstance Force
#NoTrayIcon
IniRead, OutputVar, Hotkeys.ini, Variables, Key
IniRead, Position, ..\Vars.inc, Variables, Position
IniRead, RainmeterPath, Hotkeys.ini, Variables, RMPATH


Hotkey,%OutputVar%,Button

Name = ValliStart.ahk
DetectHiddenWindows On
SetTitleMatchMode RegEx
IfWinExist, i)%Name%.* ahk_class AutoHotkey
{
    ValliScriptPath = % RegExReplace(a_scriptdir,"YourMixer.*\\?$")"Vallistart\@Resources\Actions\Source code\Vallistart.ahk"
    ValliAhkPath = % RegExReplace(a_scriptdir,"YourMixer.*\\?$")"Vallistart\@Resources\Actions\"
    Run, %ValliAhkPath%AHKv1.exe `"%ValliScriptPath%`", %ValliAhkPath%
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
