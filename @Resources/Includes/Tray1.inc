

[AppVolper0]
Measure=Plugin
Plugin=Win7AudioPlugin
IfCondition=AppVolper0 <= 0
iftrueaction=[!SetOption MeasureTray IconName "#@#Icons\Volume0#IconTheme#.ico"][!UpdateMeasure MeasureTray]
IfCondition2=(AppVolPer0 > 0) && (AppVolPer0 < 20)
IfTrueAction2=[!SetOption MeasureTray IconName "#@#Icons\Volume1#IconTheme#.ico"][!UpdateMeasure MeasureTray]
IfCondition3=(AppVolPer0 >= 20) && (AppVolPer0 < 50)
IfTrueAction3=[!SetOption MeasureTray IconName "#@#Icons\Volume2#IconTheme#.ico"][!UpdateMeasure MeasureTray]
IfCondition4=(AppVolPer0 >= 50) && (AppVolPer0 < 90)
IfTrueAction4=[!SetOption MeasureTray IconName "#@#Icons\Volume3#IconTheme#.ico"][!UpdateMeasure MeasureTray]
IfCondition5=(AppVolPer0 >= 90)
IfTrueAction5=[!SetOption MeasureTray IconName "#@#Icons\Volume4#IconTheme#.ico"][!UpdateMeasure MeasureTray]
DynamicVariables=1
UpdateDivider=1

[MeasureTray]
Measure=Plugin
Plugin=TrayIcon
IconName=#@#Icons\Volume0#IconTheme#.ico
ToolTipText=Volume: [AppVolper0:]
LeftMouseUpAction=[!UpdateMeasure mToggle]
RightMouseUpAction=[!UpdateMeasureGroup CurPos.XY][!CommandMEasure Ctx.Gen:M "Gen()"][!ActivateConfig "#JaxCore\Ctx"][!SetVariable Sec.Skin "#ROOTCONFIG#" "#JaxCore\Ctx"]
DynamicVariables=1