[Variables]
[Header01]
Meter=String
Text=Dimensions
MeterStyle=Set.String:S | Set.OptionCat:S
[Option02]
Meter=String
Text=Skin scale

MeterStyle=Set.String:S | Set.OptionName:S
[Divider03]
Meter=Shape
MeterStyle=Set.Div:S
[Option03]
Meter=String
Text=Module Width

MeterStyle=Set.String:S | Set.OptionName:S
[Divider04]
Meter=Shape
MeterStyle=Set.Div:S
[Option04]
Meter=String
Text=Minium module height

MeterStyle=Set.String:S | Set.OptionName:S
[Divider05]
Meter=Shape
MeterStyle=Set.Div:S
[Option05]
Meter=String
Text=Width of the name list on the left

MeterStyle=Set.String:S | Set.OptionName:S
[Divider06]
Meter=Shape
MeterStyle=Set.Div:S
[Option06]
Meter=String
Text=Padding between each slider rows

MeterStyle=Set.String:S | Set.OptionName:S
[Header07]
Meter=String
Text=Selections
MeterStyle=Set.String:S | Set.OptionCat:S
[Option08]
Meter=String
Text=Show application names

MeterStyle=Set.String:S | Set.OptionName:S
[Divider09]
Meter=Shape
MeterStyle=Set.Div:S
[Option09]
Meter=String
Text=Show application icons

MeterStyle=Set.String:S | Set.OptionName:S
[Divider10]
Meter=Shape
MeterStyle=Set.Div:S
[Option10]
Meter=String
Text=Application icon size

MeterStyle=Set.String:S | Set.OptionName:S
[Divider11]
Meter=Shape
MeterStyle=Set.Div:S
[Option11]
Meter=String
Text=Font face

MeterStyle=Set.String:S | Set.OptionName:S
[Divider12]
Meter=Shape
MeterStyle=Set.Div:S
[Option12]
Meter=String
Text=Corner roundness

MeterStyle=Set.String:S | Set.OptionName:S
[Divider13]
Meter=Shape
MeterStyle=Set.Div:S
[Option13]
Meter=String
Text=Divider between sysVol and appVol

MeterStyle=Set.String:S | Set.OptionName:S
[Divider14]
Meter=Shape
MeterStyle=Set.Div:S
[Option14]
Meter=String
Text=Mixer icon in top left

MeterStyle=Set.String:S | Set.OptionName:S
[Divider15]
Meter=Shape
MeterStyle=Set.Div:S
[Option15]
Meter=String
Text=Mixer icon
FontColor=#Set.Text_Color#,(#MixerIcon# = 1 ? 255 : 150)
MeterStyle=Set.String:S | Set.OptionName:S
[Divider16]
Meter=Shape
MeterStyle=Set.Div:S
[Option16]
Meter=String
Text=Mixer title

MeterStyle=Set.String:S | Set.OptionName:S
[Divider17]
Meter=Shape
MeterStyle=Set.Div:S
[Option17]
Meter=String
Text=Volume icon theme

MeterStyle=Set.String:S | Set.OptionName:S
[Header18]
Meter=String
Text=Fill and coloring
MeterStyle=Set.String:S | Set.OptionCat:S
[Option19]
Meter=String
Text=Blur type

MeterStyle=Set.String:S | Set.OptionName:S
[Divider20]
Meter=Shape
MeterStyle=Set.Div:S
[Option20]
Meter=String
Text=Blur rounding size

MeterStyle=Set.String:S | Set.OptionName:S
[Divider21]
Meter=Shape
MeterStyle=Set.Div:S
[Option21]
Meter=String
Text=Panel opacity

MeterStyle=Set.String:S | Set.OptionName:S
[Divider22]
Meter=Shape
MeterStyle=Set.Div:S
[Option22]
Meter=String
Text=Accent color

MeterStyle=Set.String:S | Set.OptionName:S
[Divider23]
Meter=Shape
MeterStyle=Set.Div:S
[Option23]
Meter=String
Text=Node hover color

MeterStyle=Set.String:S | Set.OptionName:S
[Divider24]
Meter=Shape
MeterStyle=Set.Div:S
[Option24]
Meter=String
Text=Node color

MeterStyle=Set.String:S | Set.OptionName:S
[Divider25]
Meter=Shape
MeterStyle=Set.Div:S
[Option25]
Meter=String
Text=Background color

MeterStyle=Set.String:S | Set.OptionName:S
[Divider26]
Meter=Shape
MeterStyle=Set.Div:S
[Option26]
Meter=String
Text=Divider color

MeterStyle=Set.String:S | Set.OptionName:S
[Divider27]
Meter=Shape
MeterStyle=Set.Div:S
[Option27]
Meter=String
Text=Font color

MeterStyle=Set.String:S | Set.OptionName:S
[Divider28]
Meter=Shape
MeterStyle=Set.Div:S
[Option28]
Meter=String
Text=Volume peak color

MeterStyle=Set.String:S | Set.OptionName:S
[Divider29]
Meter=Shape
MeterStyle=Set.Div:S
[Option29]
Meter=String
Text=Volume slider hover color

MeterStyle=Set.String:S | Set.OptionName:S
[Divider30]
Meter=Shape
MeterStyle=Set.Div:S
[Option30]
Meter=String
Text=Volume slider color

MeterStyle=Set.String:S | Set.OptionName:S
[Scale]
Meter=Shape
MeterStyle=Set.Textbox:S
Type=Num|0.5|2


Y=([Option02:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value02]
Meter=String
Text=#Scale#

MeterStyle=Set.String:S | Set.Value:S
[Width]
Meter=Shape
MeterStyle=Set.Textbox:S
Type=Num|100|#SCREENAREAWIDTH#


Y=([Option03:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value03]
Meter=String
Text=#Width#

MeterStyle=Set.String:S | Set.Value:S
[MinH]
Meter=Shape
MeterStyle=Set.Textbox:S
Type=Num|0|#SCREENAREAHEIGHT#


Y=([Option04:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value04]
Meter=String
Text=#MinH#

MeterStyle=Set.String:S | Set.Value:S
[LeftW]
Meter=Shape
MeterStyle=Set.Textbox:S
Type=Num|22|#Width#


Y=([Option05:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value05]
Meter=String
Text=#LeftW#

MeterStyle=Set.String:S | Set.Value:S
[LinePad]
Meter=Shape
MeterStyle=Set.Textbox:S
Type=Num|0|100


Y=([Option06:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value06]
Meter=String
Text=#LinePad#

MeterStyle=Set.String:S | Set.Value:S
[DisplayName]
Meter=Shape
MeterStyle=Set.Bool:S


Y=([Option08:Y]-#Set.P#+(-20/2+8)*[Set.S])
[FetchIcons]
Meter=Shape
MeterStyle=Set.Bool:S


Y=([Option09:Y]-#Set.P#+(-20/2+8)*[Set.S])
[IconSize]
Meter=Shape
MeterStyle=Set.Textbox:S
Type=Num|16|100


Y=([Option10:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value10]
Meter=String
Text=#IconSize#

MeterStyle=Set.String:S | Set.Value:S
[Font]
Meter=Shape
MeterStyle=Set.Textbox:S



Y=([Option11:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value11]
Meter=String
Text=#Font#

MeterStyle=Set.String:S | Set.Value:S
[R]
Meter=Shape
MeterStyle=Set.Textbox:S
Type=Num|0|100


Y=([Option12:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value12]
Meter=String
Text=#R#

MeterStyle=Set.String:S | Set.Value:S
[Stroke]
Meter=Shape
MeterStyle=Set.Bool:S


Y=([Option13:Y]-#Set.P#+(-20/2+8)*[Set.S])
[MixerIcon]
Meter=Shape
MeterStyle=Set.Bool:S


Y=([Option14:Y]-#Set.P#+(-20/2+8)*[Set.S])
[Button15]
Meter=Shape
MeterStyle=Set.Button:S
Y=([Option15:Y]-#Set.P#+(-30/2+8)*[Set.S])
OverColor=#Set.Accent_color#,150
LeaveColor=#Set.Accent_color#,50
Act=[!CommandMEasure Func "interactionBox([[#SKINSPATH##Skin.Name#\Core\InteractionBox\MixerOrb.inc]], '#IconName#')"]
Hidden=(1-#MixerIcon#)
[Icon15]
Meter=String
Text=[\xe895]
FontFace=Material Icons Round
FontSize=(14*[Set.S])
Hidden=(1-#MixerIcon#)
MeterStyle=Set.String:S | Set.Value:S
[Value15]
Meter=String
X=(-25*[Set.S])r
Y=r
Text=#IconName#
Hidden=(1-#MixerIcon#)
MeterStyle=Set.String:S | Set.Value:S
[StartText]
Meter=Shape
MeterStyle=Set.Textbox:S



Y=([Option16:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value16]
Meter=String
Text=#StartText#

MeterStyle=Set.String:S | Set.Value:S
[Button17]
Meter=Shape
MeterStyle=Set.Button:S
Y=([Option17:Y]-#Set.P#+(-30/2+8)*[Set.S])
OverColor=#Set.Accent_color#,150
LeaveColor=#Set.Accent_color#,50
Act=[!CommandMEasure Func "interactionBox([[#SKINSPATH##Skin.Name#\Core\InteractionBox\MixerVolumeIconTheme.inc]], '#VolumeIconTheme#')"]

[Icon17]
Meter=String
Text=[\xe895]
FontFace=Material Icons Round
FontSize=(14*[Set.S])

MeterStyle=Set.String:S | Set.Value:S
[Value17]
Meter=String
X=(-25*[Set.S])r
Y=r
Text=#VolumeIconTheme#

MeterStyle=Set.String:S | Set.Value:S
[Blur:]
Meter=Shape
0Act=[!WriteKeyValue Variables Blur "None" "#Sec.SaveLocation#"]
1Act=[!WriteKeyValue Variables Blur "Acrylic" "#Sec.SaveLocation#"]
2Act=[!WriteKeyValue Variables Blur "Blur" "#Sec.SaveLocation#"]
MeterStyle=Set.Pick3:S
Shape2=Rectangle (100*[Set.S]*([&Func:returnBool('Blur', 'Acrylic')]+[&Func:returnBool('Blur', 'Blur')]*2)),0,(300/3*[Set.S]),(30*[Set.S]),(7*[Set.S]) | Fill Color #Set.Text_Color# | StrokeWidth 0
Y=([Option19:Y]-#Set.P#+(-30/2+8)*[Set.S])

[Blur:0]
Meter=String
Text=None
FontColor=[&Func:returnBool('Blur', 'None', '#Set.Pri_color#', '#Set.Text_Color#')]
MeterStyle=Set.String:S | Set.PickOption3_0:S

[Blur:1]
Meter=String
Text=Acrylic
FontColor=[&Func:returnBool('Blur', 'Acrylic', '#Set.Pri_color#', '#Set.Text_Color#')]
MeterStyle=Set.String:S | Set.PickOption3_1:S

[Blur:2]
Meter=String
Text=Standard
FontColor=[&Func:returnBool('Blur', 'Blur', '#Set.Pri_color#', '#Set.Text_Color#')]
MeterStyle=Set.String:S | Set.PickOption3_2:S
Hidden=

[BlurCorner:]
Meter=Shape
0Act=[!WriteKeyValue Variables BlurCorner "None" "#Sec.SaveLocation#"]
1Act=[!WriteKeyValue Variables BlurCorner "RoundSmall" "#Sec.SaveLocation#"]
2Act=[!WriteKeyValue Variables BlurCorner "Round" "#Sec.SaveLocation#"]
MeterStyle=Set.Pick3:S
Shape2=Rectangle (100*[Set.S]*([&Func:returnBool('BlurCorner', 'RoundSmall')]+[&Func:returnBool('BlurCorner', 'Round')]*2)),0,(300/3*[Set.S]),(30*[Set.S]),(7*[Set.S]) | Fill Color #Set.Text_Color# | StrokeWidth 0
Y=([Option20:Y]-#Set.P#+(-30/2+8)*[Set.S])

[BlurCorner:0]
Meter=String
Text=None
FontColor=[&Func:returnBool('BlurCorner', 'None', '#Set.Pri_color#', '#Set.Text_Color#')]
MeterStyle=Set.String:S | Set.PickOption3_0:S

[BlurCorner:1]
Meter=String
Text=Small
FontColor=[&Func:returnBool('BlurCorner', 'RoundSmall', '#Set.Pri_color#', '#Set.Text_Color#')]
MeterStyle=Set.String:S | Set.PickOption3_1:S

[BlurCorner:2]
Meter=String
Text=Standard
FontColor=[&Func:returnBool('BlurCorner', 'Round', '#Set.Pri_color#', '#Set.Text_Color#')]
MeterStyle=Set.String:S | Set.PickOption3_2:S
Hidden=

[Alpha]
Meter=Shape
MeterStyle=Set.Textbox:S
Type=Int|0|255


Y=([Option21:Y]-#Set.P#+(-30/2+8)*[Set.S])
[Value21]
Meter=String
Text=#Alpha#

MeterStyle=Set.String:S | Set.Value:S
[Accent]
Meter=Shape
MeterStyle=Set.Color:S
LeftMouseUpAction=["#@#Addons\RainRGB4.exe" "VarName=#CURRENTSECTION#" "FileName=#Sec.SaveLocation#" "RefreshConfig=#CURRENTCONFIG# | #Skin.Name#\Main"]
Y=([Option22:Y]-#Set.P#+(-30/2+8)*[Set.S])

[AccentNodeHover]
Meter=Shape
MeterStyle=Set.Color:S
LeftMouseUpAction=["#@#Addons\RainRGB4.exe" "VarName=#CURRENTSECTION#" "FileName=#Sec.SaveLocation#" "RefreshConfig=#CURRENTCONFIG# | #Skin.Name#\Main"]
Y=([Option23:Y]-#Set.P#+(-30/2+8)*[Set.S])

[AccentNode]
Meter=Shape
MeterStyle=Set.Color:S
LeftMouseUpAction=["#@#Addons\RainRGB4.exe" "VarName=#CURRENTSECTION#" "FileName=#Sec.SaveLocation#" "RefreshConfig=#CURRENTCONFIG# | #Skin.Name#\Main"]
Y=([Option24:Y]-#Set.P#+(-30/2+8)*[Set.S])

[Color]
Meter=Shape
MeterStyle=Set.Color:S
LeftMouseUpAction=["#@#Addons\RainRGB4.exe" "VarName=#CURRENTSECTION#" "FileName=#Sec.SaveLocation#" "RefreshConfig=#CURRENTCONFIG# | #Skin.Name#\Main"]
Y=([Option25:Y]-#Set.P#+(-30/2+8)*[Set.S])

[Border]
Meter=Shape
MeterStyle=Set.Color:S
LeftMouseUpAction=["#@#Addons\RainRGB4.exe" "VarName=#CURRENTSECTION#" "FileName=#Sec.SaveLocation#" "RefreshConfig=#CURRENTCONFIG# | #Skin.Name#\Main"]
Y=([Option26:Y]-#Set.P#+(-30/2+8)*[Set.S])

[FontColor]
Meter=Shape
MeterStyle=Set.Color:S
LeftMouseUpAction=["#@#Addons\RainRGB4.exe" "VarName=#CURRENTSECTION#" "FileName=#Sec.SaveLocation#" "RefreshConfig=#CURRENTCONFIG# | #Skin.Name#\Main"]
Y=([Option27:Y]-#Set.P#+(-30/2+8)*[Set.S])

[VolumePeakColor]
Meter=Shape
MeterStyle=Set.Color:S
LeftMouseUpAction=["#@#Addons\RainRGB4.exe" "VarName=#CURRENTSECTION#" "FileName=#Sec.SaveLocation#" "RefreshConfig=#CURRENTCONFIG# | #Skin.Name#\Main"]
Y=([Option28:Y]-#Set.P#+(-30/2+8)*[Set.S])

[BackVolColorOver]
Meter=Shape
MeterStyle=Set.Color:S
LeftMouseUpAction=["#@#Addons\RainRGB4.exe" "VarName=#CURRENTSECTION#" "FileName=#Sec.SaveLocation#" "RefreshConfig=#CURRENTCONFIG# | #Skin.Name#\Main"]
Y=([Option29:Y]-#Set.P#+(-30/2+8)*[Set.S])

[BackVolColorLeave]
Meter=Shape
MeterStyle=Set.Color:S
LeftMouseUpAction=["#@#Addons\RainRGB4.exe" "VarName=#CURRENTSECTION#" "FileName=#Sec.SaveLocation#" "RefreshConfig=#CURRENTCONFIG# | #Skin.Name#\Main"]
Y=([Option30:Y]-#Set.P#+(-30/2+8)*[Set.S])




;
;[Dimensions]
;Type=Header
;[Skin scale]
;Type=String
;Variable=Scale
;Limit=Num|0.5|2
;[Module Width]
;Type=String
;Variable=Width
;Limit=Num|100|#SCREENAREAWIDTH#
;[Minium module height]
;Type=String
;Variable=MinH
;Limit=Num|0|#SCREENAREAHEIGHT#
;[Width of the name list on the left]
;Type=String
;Variable=LeftW
;Limit=Num|22|#Width#
;[Padding between each slider rows]
;Type=String
;Variable=LinePad
;Limit=Num|0|100
;
;[Selections]
;Type=Header
;[Show application names]
;Type=Bool
;Variable=DisplayName
;[Show application icons]
;Type=Bool
;Variable=FetchIcons
;[Application icon size]
;Type=String
;Variable=IconSize
;Limit=Num|16|100
;[Font face]
;Type=String
;Variable=Font
;[Corner roundness]
;Type=String
;Variable=R
;Limit=Num|0|100
;[Divider between sysVol and appVol]
;Type=Bool
;Variable=Stroke
;[Mixer icon in top left]
;Type=Bool
;Variable=MixerIcon
;[Mixer icon]
;Type=Button
;Icon=e895
;String=#IconName#
;Act=[!CommandMEasure Func "interactionBox([[#SKINSPATH##Skin.Name#\Core\InteractionBox\MixerOrb.inc]], '#IconName#')"]
;Hidden=!MixerIcon
;[Mixer title]
;Type=String
;Variable=StartText
;[Volume icon theme]
;Type=Button
;Icon=e895
;String=#VolumeIconTheme#
;Act=[!CommandMEasure Func "interactionBox([[#SKINSPATH##Skin.Name#\Core\InteractionBox\MixerVolumeIconTheme.inc]], '#VolumeIconTheme#')"]
;
;[Fill and coloring]
;Type=Header
;[Blur type]
;Type=Switch
;Variable=Blur
;Limit=3
;String=None|Acrylic|Standard
;StringSet=None|Acrylic|Blur
;[Blur rounding size]
;Type=Switch
;Variable=BlurCorner
;Limit=3
;String=None|Small|Standard
;StringSet=None|RoundSmall|Round
;[Panel opacity]
;Type=String
;Variable=Alpha
;Limit=Int|0|255
;[Accent color]
;Type=Color
;Variable=Accent
;[Node hover color]
;Type=Color
;Variable=AccentNodeHover
;[Node color]
;Type=Color
;Variable=AccentNode
;[Background color]
;Type=Color
;Variable=Color
;[Divider color]
;Type=Color
;Variable=Border
;[Font color]
;Type=Color
;Variable=FontColor
;[Volume peak color]
;Type=Color
;Variable=VolumePeakColor
;[Volume slider hover color]
;Type=Color
;Variable=BackVolColorOver
;[Volume slider color]
;Type=Color
;Variable=BackVolColorLeave