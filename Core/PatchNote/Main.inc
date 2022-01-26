; ---------------------------------------------------------------------------- ;
;                                   Functions                                  ;
; ---------------------------------------------------------------------------- ;
; ---------------------------------------------------------------------------- ;
;                                    Content                                   ;
; ---------------------------------------------------------------------------- ;
[ImageContainer]
Hidden=1
[Image]
Hidden=1

[Title]
Meter=String
Text="Change log"
MeterStyle=Sec.String:S | Style.Title:S

[Description.1]
Meter=String
Text="- NEW! Hit the esc key to quickly close IdleStyle when it's active."
MeterStyle=Sec.String:S | Style.Description:S
; [Link.1]
; Meter=String
; Text="https://jax-core.github.io/"
; LeftMouseUpAction=["https://jax-core.github.io/"]
; MeterStyle=Sec.String:S | Style.Link:S

[Description.2]
Meter=String
Text="- IdleStyle now uses global variables for some options."
MeterStyle=Sec.String:S | Style.Description:S

; [Description.3]
; Meter=String
; Text="- Updated blur variant for better blurring effect"
; MeterStyle=Sec.String:S | Style.Description:S

; [Description.4]
; Meter=String
; Text="- Fixed big circ progress"
; MeterStyle=Sec.String:S | Style.Description:S

; [Description.5]
; Meter=String
; Text="- Added Scrollbar and a few bug fixes"
; MeterStyle=Sec.String:S | Style.Description:S

; [Description.6]
; Meter=String
; Y=(#Sec.P#*2)R
; Text="Happy Holidays everyone! This is the biggest update Core has ever received, if you liked it consider leaving a star on the DeviantArt post!"
; MeterStyle=Sec.String:S | Style.Description:S


[DA:]
Meter=Shape
X=(#Sec.W#/2-(#Sec.BottomWidth#*1+#Sec.P#*0)/2)
Y=(#Sec.H#-#Sec.P#-#SEc.BottomHeight#)
LeftMouseUpAction=[!Deactivateconfig]
meterStyle=BottomBox:S | FalseStyleDesk
[DA:String]
Meter=String
StringAlign=CenterCenter
Text=Got it!
MeterStyle=Sec.String:S | BottomText:S
; [DiscordServer:]
; Meter=Shape
; ColorLeave=88, 101, 242,150
; ColorOver=88, 101, 242
; LeftMouseUpAction=["https://discord.gg/JmgehPSDD6"]
; meterStyle=BottomBox:S | FalseStyleDesk
; [DiscordServer:String]
; Meter=String
; StringAlign=CenterCenter
; Text=Join the Discord
; MeterStyle=Sec.String:S | BottomText:S