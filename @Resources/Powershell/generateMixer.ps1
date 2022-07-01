function generateMixer {

    $SaveLocation = "$($RmAPI.VariableStr('ROOTCONFIGPATH'))Main\Elements\ControlScreen\Main.ini"
    $scale = $RmAPI.VariableStr('scale')
    $pageW = $RmAPI.VariableStr('W')
    $collapsetype = $RmAPI.VariableStr('CollapseIcons')

    $rows = $RmAPI.Measure('AppVolumeParent')
    if ($collapsetype -notcontains 'Separate') {
        $AppArray = @()
        $SkipIndex = @()
        for (($i = 1); $i -le $rows; $i++) {
            $RmAPI.Bang("[!SetOption AppVolTester Index $i][!UpdateMeasure AppVolTester]")
            $AppName = $RmAPI.MeasureStr('AppvolTester')
            # $RmAPI.Log($AppName)
            if ($AppName -in $AppArray) {
                $SkipIndex += $i
            } 
            $AppArray += $appName
        }

        if ($collapsetype -contains 'Combine') {
            $AppHash = $AppArray | Group-Object -AsHashTable -AsString
        }
    } 

#     if (($rows -gt 0) -and ($RmAPI.Variable('Stroke') -eq 1)) {
#         $fileContent += @"

# [Divider]
# Meter=Shape
# MeterStyle=Divider:S

# "@
#     $additionalSize = 40
#     }

    # $pageH = ((80+(40+($RmAPI.Variable('line_pad')))*($rows+1-$SkipIndex.Count)+20+$additionalSize) * $scale)
    $pad = $RmAPI.Variable('line_pad')
    # $pageH = ((80 + (40 + $pad) * ($rows - $SkipIndex.Count) + 40 + $additionalSize) * $scale)

    if ($collapsetype -notcontains 'Combine') {
        for (($i = 1); ($i -le $rows) ; $i++) {
            if ($i -notin $SkipIndex) {
                $fileContent += @"
[AppVol$i]
Measure=Plugin
Plugin=AppVolume
Parent=AppVolumeParent
Index=$i
Substitute=#ReplaceApp#
Group=UpdateWhenChange

[AppVolPeak$i]
Measure=Plugin
Plugin=AppVolume
Parent=AppVolumeParent
Index=$i
NumberType=Peak
UpdateDivider=1
Disabled=(#VolumePeaks#-1)

[AppVolPer$i]
Measure=Calc
Formula=Round(AppVol$i * 100)
Group=UpdateWhenChange
Substitute="-100":"Muted"

[ppVol$i]
Meter=Shape
MeterStyle=Item.Background.Shape:S

[pVol$i]
Meter=Image
MeterStyle=Item.Image:S

[Vol$i]
Meter=String
MeterStyle=String:S | Item.Name.String:S

[$i]
Meter=Shape
MeterStyle=Item.Shape:S

[VolPer$i]
Meter=String
MeterStyle=String:S | Item.Vol.String:S

"@
            }

        } 
    } else {
        for (($i = 1); ($i -le $rows) ; $i++) {
            if ($i -notin $SkipIndex) {
                $fileContent += @"

[AppVol$i]
Measure=Plugin
Plugin=AppVolume
Parent=AppVolumeParent
Index=$i
Substitute=#ReplaceApp#
Group=UpdateWhenChange

[AppVolPeak$i]
Measure=Plugin
Plugin=AppVolume
Parent=AppVolumeParent
Index=$i
NumberType=Peak
UpdateDivider=1
Disabled=(#VolumePeaks#-1)

[AppVolPer$i]
Measure=Calc
Formula=Round(AppVol$i * 100)
Group=UpdateWhenChange
Substitute="-100":"Muted"

"@
                if ($AppHash[$AppArray[$i-1]].Count -gt 1) {
                    $occuranceArray = (0..($AppArray.Count-1)) | where {$AppArray[$_] -eq "$($AppArray[$i-1])"}

                    $bang = ""
                    for ($j = 0; $j -lt $occuranceArray.Count; $j++) {
                        $bang += "[!CommandMeasure AppVol$($occuranceArray[$j] + 1) `"ToggleMute`"]"
                        }

                    $fileContent += @"

[ppVol$i]
Meter=Shape
MeterStyle=Item.Background.Shape:S

[pVol$i]
Meter=Image
MeterStyle=Item.Image:S
LeftMouseDownAction=$bang[!UpdateMeasureGroup UpdateWhenChange][!UpdateMeter *][!Redraw]

[Vol$i]
Meter=String
MeterStyle=String:S | Item.Name.String:S
LeftMouseDownAction=$bang[!UpdateMeasureGroup UpdateWhenChange][!UpdateMeter *][!Redraw]

"@
                    for ($j = 0; $j -lt $occuranceArray.Count; $j++) {
                        $fileContent += @"

[$($occuranceArray[$j] + 1)]
Meter=Shape

"@
                        if ($j -eq 0) {
                            $fileContent += @"
X=[0:X]

"@
                        }

                        $fileContent += @"
MeterStyle=Item.Shape:S | Item.Shape:S.$($AppHash[$AppArray[$i-1]].Count)

"@
                    }

                } else {
                    $fileContent += @"

[ppVol$i]
Meter=Shape
MeterStyle=Item.Background.Shape:S

[pVol$i]
Meter=Image
MeterStyle=Item.Image:S

[Vol$i]
Meter=String
MeterStyle=String:S | Item.Name.String:S
                
[$i]
Meter=Shape
MeterStyle=Item.Shape:S

"@
                }
                $fileContent += @"

[VolPer$i]
Meter=String
MeterStyle=String:S | Item.Vol.String:S

"@
            } else {
                $fileContent += @"
[AppVol$i]
Measure=Plugin
Plugin=AppVolume
Parent=AppVolumeParent
Index=$i
Substitute=#ReplaceApp#
Group=UpdateWhenChange

[AppVolPeak$i]
Measure=Plugin
Plugin=AppVolume
Parent=AppVolumeParent
Index=$i
NumberType=Peak
UpdateDivider=1
Disabled=(#VolumePeaks#-1)

[AppVolPer$i]
Measure=Calc
Formula=Round(AppVol$i * 100)
Group=UpdateWhenChange
Substitute="-100":"Muted"

"@
            }
        }
    
    }

    $fileContent | Out-File -FilePath $($RmAPI.VariableStr('ROOTCONFIGPATH') + 'Main\\Elements\\ControlScreen\\Cache\\MixerContent.inc') -Encoding unicode

    $RmAPI.Bang("[!Activateconfig `"YourMixer\Main\Elements\ControlScreen`"]")
}
