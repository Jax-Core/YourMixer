[ActionTimer]
Measure=Plugin
Plugin=ActionTimer
DynamicVariables=1
ActionList1=Show | Repeat In,2,#AniSteps#
ActionList2=Repeat Out,2,#AniSteps# | Hide
Show=[!CommandMeasure Func "initActions(1)"][!Show]
Hide=[!CommandMeasure Func "initActions(-1)"]
In=[!CommandMeasure Func "tweenAnimation('in')"]
Out=[!CommandMeasure Func "tweenAnimation('out')"]


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
