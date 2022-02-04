[Variables]
CircSize=8
[ShapeStyle]
Shape=Line 0,0,(#W#-(180+22+75)*#scale#),0 | StrokeWidth (2*#Scale#) | Fill Color 0,0,0,1 | StrokeStartCap Round | StrokeEndCap Round | Stroke Color #BoxColor#
Shape2=Line 0,0,(#W#-(180+22+75)*#scale#),0 | StrokeWidth (2*#Scale#) | Fill Color 0,0,0,1 | StrokeStartCap Round | StrokeEndCap Round | Stroke Color #Accent# | Scale ([AppVolPer#CURRENTSECTION#:]/100 > 0 ? [AppVolPer#CURRENTSECTION#:]/100 : 0), 1, 0, 0
Shape3=Line 0,0,(#W#-(180+22+75)*#scale#),0 | StrokeWidth (30*#Scale#) | Fill Color 0,0,0,1 | Stroke Color 0,0,0,1
Shape4=Ellipse ((#W#-(180+22+75)*#scale#)*[AppVolPer#CURRENTSECTION#:]/100),0,(#CircSize#*#scale#),(#CircSize#*#scale#) | StrokeWidth 0 | Fill Color #Accent#