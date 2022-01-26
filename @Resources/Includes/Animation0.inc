[ActionTimer]
Measure=Plugin
Plugin=ActionTimer
ActionList1=Showfade | Custom0
ActionList2=Hidefade
Showfade=[!SHowFade][!CommandMeasure Func "initActions(1)"]
HideFade=[!HideFade][!CommandMeasure Func "initActions(-1)"]


; ---------------------------------------------------------------------------- ;
;                                     Load                                     ;
; ---------------------------------------------------------------------------- ;

[ACTIONLOAD]
Measure=String
OnUpdateAction=[!CommandMeasure ActionTimer "Execute 1"]
Disabled=1
Group=NUOL

[ACTIONUNLOAD]
Measure=String
OnUpdateAction=[!CommandMeasure ActionTimer "Execute 2"][!DisableMeasure #CURRENTSECTION#]
Disabled=1
Group=NUOL

; ---------------------------------------------------------------------------- ;
;                                    Content                                   ;
; ---------------------------------------------------------------------------- ;

