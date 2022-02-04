; ---------------------------------------------------------------------------- ;
;                                   Functions                                  ;
; ---------------------------------------------------------------------------- ;



[AppVolumeParent]
Measure=Plugin
Plugin=AppVolume
IgnoreSystemSound=1
ExcludeApp=rainmeter.exe; explorer.exe;

[MeasureMouse]
Measure=Plugin
Plugin=Mouse
; this measure uses the Plugin:Mouse
LeftMouseDragAction=[!CommandMEasure Func "dragMultiSlider($mouseX$)"]
; [!SetVariable SliderX "(Clamp(($MouseX$),(#SliderM#),((#SliderM#)+#SliderW#)))"][!UpdateMeasure SliderPercent][!UpdateMeterGroup VolumeElements][!Redraw]
; actions to be executed when the mouse drags. The first bang gets the mouse value and make sure it's in the slider. The bangs after that updates the required measures and the slider.
LeftMouseUpAction=[!CommandMEasure Func "termMultiSlider()"]
; actions to be executed after the mouse click is lifted. The first bang stops the measure to retrieve information from mouse dragging.
RelativeToSkin=1
RequireDragging=1
DynamicVariables=1

; ---------------------------------------------------------------------------- ;
;                                  MeterStyleS                                 ;
; ---------------------------------------------------------------------------- ;

[ShapeStyle]
Y=r
X=(180*#scale#)
DynamicVariables=1
LeftMouseDownAction=[!CommandMEasure Func "initMultiSlider('#CURRENTSECTION#')"]
[ShapeStyleInclude]
@includeSliderStyle=SliderStyle\#SliderStyle#.inc


[TextStyle]
X=(22*#scale#)
Y=(40*#scale#)r
W=((180-44)*#scale#)
MeasureName=App#CURRENTSECTION#
StringAlign=LeftCenter
Clipstring=1
FontColor=#FontColor#,([App#CURRENTSECTION#:] = -1 ? 180 : 255)
LeftMouseDownAction=[!CommandMeasure App#CURRENTSECTION# "ToggleMute"][!UpdateMeasureGroup UpdateWhenChange][!UpdateMeter *][!Redraw]
StringCase=Proper
DynamicVariables=1

[VolStyle]
X=(#W#-22*#scale#)
Y=r
W=(75*#scale#)
Text=[App#CURRENTSECTION#]
StringAlign=RightCenter
DynamicVariables=1
Clipstring=1



[AppVol0]
Measure=Plugin
Plugin=Win7AudioPlugin
DynamicVariables=1
UpdateDivider=1
Group=UpdateWhenChange
[AppVolPer0]
Measure=Calc
Formula=Round(AppVol0)
Group=UpdateWhenChange
IfCondition=AppVolPer0 < 20
IfTrueAction=[!SetOption VolumeIcon Text "[\xe04f]"]
IfCondition2=(AppVolPer0 >= 20) && (AppVolPer0 < 50)
IfTrueAction2=[!SetOption VolumeIcon Text "[\xe04e]"]
IfCondition3=(AppVolPer0 >= 50) && (AppVolPer0 < 90)
IfTrueAction3=[!SetOption VolumeIcon Text "[\xe04d]"]
IfCondition4=(AppVolPer0 >= 90)
IfTrueAction4=[!SetOption VolumeIcon Text "[\xe050]"]
Substitute="-100":"Muted"

; ---------------------------------------------------------------------------- ;
;                                    Content                                   ;
; ---------------------------------------------------------------------------- ;
[WinIcon]
ImageName=#@#Images\Orbs\#IconName#.png
[Start]
Text=#StartText#

[VolumeIcon]
Meter=String
MeterStyle=RegularText
X=(22*#scale#)
Y=(38*#scale#)R
FontFace=Material Icons Round
StringAlign=LeftCenter
FontSize=(16*#scale#)
DynamicVariables=1
Greyscale=1
ImageTint=#FontColor#
LeftMouseDownAction=[!CommandMeasure AppVol0 "ToggleMute"][!UpdateMeasureGroup UpdateWhenChange][!UpdateMeter *][!Redraw]
[Vol0]
Meter=String
X=(10*#Scale#)R
Y=(-2*#scale#)r
W=((180-16-44-10)*#scale#)
LeftMouseDownAction=[!CommandMeasure "AppVol0" "TogglePrevious"][!UpdateMeasureGroup UpdateWhenChange][!UpdateMeter *][!Redraw]
RightMouseUpAction=[!CommandMeasure "AppVol0" "ToggleNext"][!UpdateMeasureGroup UpdateWhenChange][!UpdateMeter *][!Redraw]
MeterStyle=RegularText | TextStyle
[0]
Meter=Shape
MeterStyle=ShapeStyle
[VolPer0]
Meter=String
MeterStyle=RegularText | VolStyle

@includeGenerated=#ROOTCONFIGPATH#Main\Accessories\Page\Variants\VolumeMixerCache.inc