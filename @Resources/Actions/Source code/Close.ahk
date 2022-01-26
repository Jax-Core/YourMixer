#NoTrayIcon

CloseScript(Name)
{
    DetectHiddenWindows On
    SetTitleMatchMode RegEx
    IfWinExist, i)%Name%.* ahk_class AutoHotkey
    {
        WinClose
        WinWaitClose, i)%Name%.* ahk_class AutoHotkey, , 2
        If ErrorLevel
            return "Unable to close " . Name
        else
            return "Closed " . Name
    }
    else
        return Name . " not found"
}

CloseScript("YourMixer.ahk")
ExitApp