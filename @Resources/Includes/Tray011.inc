
[AppVolper0]
Measure=Plugin
Plugin=Win7AudioPlugin
IfCondition=AppVolper0 < 0
iftrueaction=[!SetOption MeasureTray IconName "#@#Icons\Tray\#IconTheme#\Volume0.ico"][!UpdateMeasure MeasureTray]
IfCondition2=(AppVolPer0 = 0)
IfTrueAction2=[!SetOption MeasureTray IconName "#@#Icons\Tray\#IconTheme#\Volume1.ico"][!UpdateMeasure MeasureTray]
IfCondition3=(AppVolPer0 > 0) && (AppVolPer0 < 30)
IfTrueAction3=[!SetOption MeasureTray IconName "#@#Icons\Tray\#IconTheme#\Volume2.ico"][!UpdateMeasure MeasureTray]
IfCondition4=(AppVolPer0 >= 30) && (AppVolPer0 < 70)
IfTrueAction4=[!SetOption MeasureTray IconName "#@#Icons\Tray\#IconTheme#\Volume3.ico"][!UpdateMeasure MeasureTray]
IfCondition5=(AppVolPer0 >= 70)
IfTrueAction5=[!SetOption MeasureTray IconName "#@#Icons\Tray\#IconTheme#\Volume4.ico"][!UpdateMeasure MeasureTray]
DynamicVariables=1
UpdateDivider=1

[MeasureTray]
Measure=Plugin
Plugin=TrayIcon
IconName=#@#Icons\Tray\#IconTheme#\Volume0.ico
ToolTipText=Volume: [AppVolper0:]
LeftMouseUpAction=[!UpdateMeasure mToggle]
RightMouseUpAction=[!UpdateMeasureGroup CurPos.XY][!CommandMeasure Ctx.Gen:M "Gen()"][!ActivateConfig "#JaxCore\Ctx"][!SetVariable Sec.Skin "#ROOTCONFIG#" "#JaxCore\Ctx"]
DynamicVariables=1
MouseScrollUpAction=[!CommandMeasure AppVolPer0 "ChangeVolume +#VolumeChangeLevel#"][!UpdateMeasure AppVolPer0][!UpdateMeasure MeasureTray]
MouseScrollDownAction=[!CommandMeasure AppVolPer0 "ChangeVolume -#VolumeChangeLevel#"][!UpdateMeasure AppVolPer0][!UpdateMeasure MeasureTray]