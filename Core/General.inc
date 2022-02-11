[Variables]
@includeHotkeys=#SKINSPATH##Skin.Name#\@Resources\Actions\HotKeys.ini
[Sec.DirButton:S]
X=((26+5)*[Set.S])r
Y=r
Shape=Rectangle 0,0,26,26,3 | StrokeWidth 0 | Extend Fill | Scale [Set.S],[Set.S],0,0
Shape2=Path Arrow | StrokeWidth (2*[Set.S]) | StrokeStartCap Round | StrokeEndCap Round | Fill Color 0,0,0,1 | Stroke Color #Set.Text_Color# | Scale [Set.S],[Set.S],0,0 | Extend Rotation
Arrow=8,6 | LineTo 18,12 | LineTo 8,18
OverColor=[&Func:returnBool('AniDir', '#CURRENTSECTION#', '#Set.Accent_Color#', '#Set.Text_Color#')],200
LeaveColor=[&Func:returnBool('AniDir', '#CURRENTSECTION#', '#Set.Accent_Color#', '#Set.Text_Color#')],150
LeftMouseUpAction=[!WriteKeyValue Variables AniDir "#CURRENTSECTION#" #Sec.SaveLocation#][!UpdateMeasure Auto_Refresh:M][!Refresh]
Fill=Fill Color [&Func:LocalVar('#CURRENTSECTION#', 'LeaveColor')]
MouseOverAction=[!SetOption #CURRENTSECTION# Fill "Fill Color [&Func:LocalVar('#CURRENTSECTION#', 'OverColor')]"][!UpdateMeter #CURRENTSECTION#][!Redraw]
MouseLeaveAction=[!SetOption #CURRENTSECTION# Fill "Fill Color [&Func:LocalVar('#CURRENTSECTION#', 'LeaveColor')]"][!UpdateMeter #CURRENTSECTION#][!Redraw]
Container=ContentContainer
DynamicVariables=1
Hidden=(1-#Animated#)
[Header01]
Meter=String
Text=Activation & system tray
MeterStyle=Set.String:S | Set.OptionCat:S
[Option02]
Meter=String
Text=Use module as widget

MeterStyle=Set.String:S | Set.OptionName:S
[Divider03]
Meter=Shape
MeterStyle=Set.Div:S
[Option03]
Meter=String
Text=Use hotkey to activate YourMixer
FontColor=#Set.Text_Color#,(#StayOnDesktop# = 0 ? 255 : 150)
MeterStyle=Set.String:S | Set.OptionName:S
[Divider04]
Meter=Shape
MeterStyle=Set.Div:S
[Option04]
Meter=String
Text=Activation hotkey
FontColor=#Set.Text_Color#,(#Hotkey# = 1 ? 255 : 150)
MeterStyle=Set.String:S | Set.OptionName:S
[Divider05]
Meter=Shape
MeterStyle=Set.Div:S
[Option05]
Meter=String
Text=Create system volume tray icon
FontColor=#Set.Text_Color#,(#StayOnDesktop# = 0 ? 255 : 150)
MeterStyle=Set.String:S | Set.OptionName:S
[Divider06]
Meter=Shape
MeterStyle=Set.Div:S
[Option06]
Meter=String
Text=Volume tray icon theme
FontColor=#Set.Text_Color#,(#Tray# = 1 ? 255 : 150)
MeterStyle=Set.String:S | Set.OptionName:S
[Header07]
Meter=String
Text=Applications and operation
MeterStyle=Set.String:S | Set.OptionCat:S
[Option08]
Meter=String
Text=Stacking of duplicates of application channels

MeterStyle=Set.String:S | Set.OptionName:S
[Divider09]
Meter=Shape
MeterStyle=Set.Div:S
[Option09]
Meter=String
Text=Excluded applications

MeterStyle=Set.String:S | Set.OptionName:S
[Divider10]
Meter=Shape
MeterStyle=Set.Div:S
[Option10]
Meter=String
Text=Level to change when scrolling

MeterStyle=Set.String:S | Set.OptionName:S
[Header11]
Meter=String
Text=Animation
MeterStyle=Set.String:S | Set.OptionCat:S
[Option12]
Meter=String
Text=Animate volume peaks next to slider

MeterStyle=Set.String:S | Set.OptionName:S
[Divider13]
Meter=Shape
MeterStyle=Set.Div:S
[Option13]
Meter=String
Text=Slide animations

MeterStyle=Set.String:S | Set.OptionName:S
[Divider14]
Meter=Shape
MeterStyle=Set.Div:S
[Option14]
Meter=String
Text=Animation easing type
FontColor=#Set.Text_Color#,(#Animated# = 1 ? 255 : 150)
MeterStyle=Set.String:S | Set.OptionName:S
[Divider15]
Meter=Shape
MeterStyle=Set.Div:S
[Option15]
Meter=String
Text=Animation direction
FontColor=#Set.Text_Color#,(#Animated# = 1 ? 255 : 150)
MeterStyle=Set.String:S | Set.OptionName:S
[Divider16]
Meter=Shape
MeterStyle=Set.Div:S
[Option16]
Meter=String
Text=Animation steps
FontColor=#Set.Text_Color#,(#Animated# = 1 ? 255 : 150)
MeterStyle=Set.String:S | Set.OptionName:S
[Divider17]
Meter=Shape
MeterStyle=Set.Div:S
[Option17]
Meter=String
Text=Animation displacement
FontColor=#Set.Text_Color#,(#Animated# = 1 ? 255 : 150)
MeterStyle=Set.String:S | Set.OptionName:S
[StayOnDesktop]
Meter=Shape
MeterStyle=Set.Bool:S


Y=([Option02:Y]-#Set.P#+(-20/2+8)*[Set.S])
[Hotkey]
Meter=Shape
MeterStyle=Set.Bool:S
Hidden=#StayOnDesktop#

Y=([Option03:Y]-#Set.P#+(-20/2+8)*[Set.S])
[Button04]
Meter=Shape
MeterStyle=Set.Button:S
Y=([Option04:Y]-#Set.P#+(-30/2+8)*[Set.S])
Act=[!CommandMeasure Func "startSide('Hotkey', '')"]
Hidden=(1-#Hotkey#)
[Value04]
Meter=String
Text=#KeyInString#
Hidden=(1-#Hotkey#)
MeterStyle=Set.String:S | Set.Value:S
[Tray]
Meter=Shape
MeterStyle=Set.Bool:S
Hidden=#StayOnDesktop#

Y=([Option05:Y]-#Set.P#+(-20/2+8)*[Set.S])
[Button06]
Meter=Shape
MeterStyle=Set.Button:S
Y=([Option06:Y]-#Set.P#+(-30/2+8)*[Set.S])
OverColor=#Set.Accent_color#,150
LeaveColor=#Set.Accent_color#,50
Act=[!CommandMEasure Func "interactionBox([[#SKINSPATH##Skin.Name#\Core\InteractionBox\MixerIconTheme.inc]], '#IconTheme#')"]
Hidden=(1-#Tray#)
[Icon06]
Meter=String
Text=[\xe895]
FontFace=Material Icons Round
FontSize=(14*[Set.S])
Hidden=(1-#Tray#)
MeterStyle=Set.String:S | Set.Value:S
[Value06]
Meter=String
X=(-25*[Set.S])r
Y=r
Text=#IconTheme#
Hidden=(1-#Tray#)
MeterStyle=Set.String:S | Set.Value:S
[CollapseIcons:]
Meter=Shape
0Act=[!WriteKeyValue Variables CollapseIcons "0" "#Sec.SaveLocation#"]
1Act=[!WriteKeyValue Variables CollapseIcons "1" "#Sec.SaveLocation#"]
2Act=[!WriteKeyValue Variables CollapseIcons "2" "#Sec.SaveLocation#"]
MeterStyle=Set.Pick3:S
Shape2=Rectangle (100*[Set.S]*([&Func:returnBool('CollapseIcons', '1')]+[&Func:returnBool('CollapseIcons', '2')]*2)),0,(300/3*[Set.S]),(30*[Set.S]),(7*[Set.S]) | Fill Color #Set.Text_Color# | StrokeWidth 0
Y=([Option08:Y]-#Set.P#+(-30/2+8)*[Set.S])

[CollapseIcons:0]
Meter=String
Text=No
FontColor=[&Func:returnBool('CollapseIcons', '0', '#Set.Pri_color#', '#Set.Text_Color#')]
MeterStyle=Set.String:S | Set.PickOption3_0:S

[CollapseIcons:1]
Meter=String
Text=Hidden
FontColor=[&Func:returnBool('CollapseIcons', '1', '#Set.Pri_color#', '#Set.Text_Color#')]
MeterStyle=Set.String:S | Set.PickOption3_1:S

[CollapseIcons:2]
Meter=String
Text=Divide
FontColor=[&Func:returnBool('CollapseIcons', '2', '#Set.Pri_color#', '#Set.Text_Color#')]
MeterStyle=Set.String:S | Set.PickOption3_2:S
Hidden=

[ExcludeApp]
Meter=Shape
MeterStyle=Set.Textbox:S



Y=([Option09:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value09]
Meter=String
Text=#ExcludeApp#

MeterStyle=Set.String:S | Set.Value:S
[VolumeChangeLevel]
Meter=Shape
MeterStyle=Set.Textbox:S
Type=1|20


Y=([Option10:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value10]
Meter=String
Text=#VolumeChangeLevel#

MeterStyle=Set.String:S | Set.Value:S
[VolumePeaks]
Meter=Shape
MeterStyle=Set.Bool:S


Y=([Option12:Y]-#Set.P#+(-20/2+8)*[Set.S])
[Animated]
Meter=Shape
MeterStyle=Set.Bool:S


Y=([Option13:Y]-#Set.P#+(-20/2+8)*[Set.S])
[Button14]
Meter=Shape
MeterStyle=Set.Button:S
Y=([Option14:Y]-#Set.P#+(-30/2+8)*[Set.S])
OverColor=#Set.Accent_color#,150
LeaveColor=#Set.Accent_color#,50
Act=[!CommandMeasure Func "startSide('Ease')"]
Hidden=(1-#Animated#)
[Icon14]
Meter=String
Text=[\xe895]
FontFace=Material Icons Round
FontSize=(14*[Set.S])
Hidden=(1-#Animated#)
MeterStyle=Set.String:S | Set.Value:S
[Value14]
Meter=String
X=(-25*[Set.S])r
Y=r
Text=#Easetype#
Hidden=(1-#Animated#)
MeterStyle=Set.String:S | Set.Value:S
[Left]
Meter=Shape
X=(#Set.W#-#Set.L#-#Set.P#*2-((26*4+5*3)*[Set.S]))
Y=([Option15:Y]-#Set.P#+(-26/2+8)*[Set.S])
MeterStyle=Sec.DirButton:S
[Right]
Meter=Shape
Rotation=Rotate 180
MeterStyle=Sec.DirButton:S
[Top]
Meter=Shape
Rotation=Rotate 90
MeterStyle=Sec.DirButton:S
[Bottom]
Meter=Shape
Rotation=Rotate 270
MeterStyle=Sec.DirButton:S
[AniSteps]
Meter=Shape
MeterStyle=Set.Textbox:S
Type=Int|10|100
Hidden=(1-#Animated#)

Y=([Option16:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value16]
Meter=String
Text=#AniSteps#
Hidden=(1-#Animated#)
MeterStyle=Set.String:S | Set.Value:S
[AnimationDisplacement]
Meter=Shape
MeterStyle=Set.Textbox:S
Type=Int|5|300
Hidden=(1-#Animated#)

Y=([Option17:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value17]
Meter=String
Text=#AnimationDisplacement#
Hidden=(1-#Animated#)
MeterStyle=Set.String:S | Set.Value:S



;[Activation & system tray]
;Type=Header
;[Use module as widget]
;Type=Bool
;Variable=StayOnDesktop
;[Use hotkey to activate YourMixer]
;Type=Bool
;Variable=Hotkey
;Hidden=StayOnDesktop
;[Activation hotkey]
;Type=Hotkey
;Variable=1
;Hidden=!Hotkey
;[Create system volume tray icon]
;Type=Bool
;Variable=Tray
;Hidden=StayOnDesktop
;[Volume tray icon theme]
;Type=Button
;Act=[!CommandMEasure Func "interactionBox([[#SKINSPATH##Skin.Name#\Core\InteractionBox\MixerIconTheme.inc]], '#IconTheme#')"]
;Icon=e895
;String=#IconTheme#
;Hidden=!Tray
;
;[Applications and operation]
;Type=Header
;[Stacking of duplicates of application channels]
;Type=Switch
;Variable=CollapseIcons
;String=No|Hidden|Divide
;StringSet=0|1|2
;Limit=3
;[Excluded applications]
;Type=String
;Variable=ExcludeApp
;[Level to change when scrolling]
;Type=String
;Variable=VolumeChangeLevel
;Limit=1|20
;
;[Animation]
;Type=Header
;[Animate volume peaks next to slider]
;Type=Bool
;Variable=VolumePeaks
;[Slide animations]
;Type=Bool
;Variable=Animated
;[Animation easing type]
;Type=Button
;Act=[!CommandMeasure Func "startSide('Ease')"]
;Icon=e895
;String=#Easetype#
;Hidden=!Animated
;[Animation direction]
;Type=Direction
;Hidden=!Animated
;[Animation steps]
;Type=String
;Limit=Int|10|100
;Variable=AniSteps
;Hidden=!Animated
;[Animation displacement]
;Type=String
;Limit=Int|5|300
;Variable=AnimationDisplacement
;Hidden=!Animated