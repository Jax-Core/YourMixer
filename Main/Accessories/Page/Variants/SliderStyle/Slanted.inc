[ShapeStyle]
Shape=Line 0,0,(#W#-(180+22+75)*#scale#),0 | StrokeWidth (6*#Scale#) | Fill Color 0,0,0,1 | StrokeStartCap Triangle | StrokeEndCap Triangle | Stroke Color #BoxColor#
Shape2=Line 0,0,(#W#-(180+22+75)*#scale#),0 | StrokeWidth (6*#Scale#) | Fill Color 0,0,0,1 | StrokeStartCap Triangle | StrokeEndCap Triangle | Stroke Color #Accent# | Scale ([AppVolPer#CURRENTSECTION#:]/100 > 0 ? [AppVolPer#CURRENTSECTION#:]/100 : 0), 1, 0, 0
Shape3=Line 0,0,(#W#-(180+22+75)*#scale#),0 | StrokeWidth (30*#scale#) | Fill Color 0,0,0,1 | Stroke Color 0,0,0,1