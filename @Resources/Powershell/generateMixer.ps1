function generateMixer {

    $saveLocation = "$($RmAPI.VariableStr('ROOTCONFIGPATH'))Main\Accessories\Page\Main.ini"
    $scale = $RmAPI.VariableStr('scale')
    $pageW = $RmAPI.VariableStr('W')
    $collapsetype = $RmAPI.VariableStr('CollapseIcons')

    $rows = $RmAPI.Measure('AppVolumeParent')
    if ($collapsetype -ne 0) {
        $AppArray = @()
        $SkipIndex = @()

        for (($i = 1); $i -le $rows; $i++) {
            $RmAPI.Bang("[!SetOption AppVolTester Index $i][!UpdateMeasure AppVolTester]")
            $AppName = $RmAPI.MeasureStr('AppvolTester')
            if ($AppName -in $AppArray) {
                $SkipIndex += $i
            } 
            $AppArray += $appName
        }

        if ($collapsetype -eq 2) {
            $AppHash = $AppArray | Group-Object -AsHashTable -AsString
        }
    } 

    if (($rows -gt 0) -and ($RmAPI.Variable('Stroke') -eq 1)) {
        $fileContent += @"

[Divider]
Meter=Shape
MeterStyle=DividerStyle

"@
    $additionalSize = 40
    }

    # $pageH = ((80+(40+($RmAPI.Variable('additionalPadding')))*($rows+1-$SkipIndex.Count)+20+$additionalSize) * $scale)
    $pad = $RmAPI.Variable('additionalPadding')
    $pageH = ((80 + (40 + $pad) * ($rows - $SkipIndex.Count) + 40 + $additionalSize) * $scale)

    if ($collapsetype -ne 2) {
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

[AppVolPer$i]
Measure=Calc
Formula=Round(AppVol$i * 100)
Group=UpdateWhenChange
Substitute="-100":"Muted"

[pVol$i]
Meter=Image
MeterStyle=ImageStyle | ImageStyle:#FetchIcons#

[Vol$i]
Meter=String
MeterStyle=RegularText | TextStyle | TextStyle:#FetchIcons#

[$i]
Meter=Shape
MeterStyle=ShapeStyle

[VolPer$i]
Meter=String
MeterStyle=RegularText | VolStyle

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

[AppVolPer$i]
Measure=Calc
Formula=Round(AppVol$i * 100)
Group=UpdateWhenChange
Substitute="-100":"Muted"

[pVol$i]
Meter=Image
MeterStyle=ImageStyle | ImageStyle:#FetchIcons#

"@
                if ($AppHash[$AppArray[$i-1]].Count -gt 1) {
                    $occuranceArray = (0..($AppArray.Count-1)) | where {$AppArray[$_] -eq "$($AppArray[$i-1])"}

                    $bang = ""
                    for ($j = 0; $j -lt $occuranceArray.Count; $j++) {
                        $bang += "[!CommandMeasure AppVol$($occuranceArray[$j] + 1) `"ToggleMute`"]"
                        }

                    $fileContent += @"

[Vol$i]
Meter=String
MeterStyle=RegularText | TextStyle | TextStyle:#FetchIcons#
LeftMouseDownAction=$bang[!UpdateMeasureGroup UpdateWhenChange][!UpdateMeter *][!Redraw]

"@
                    for ($j = 0; $j -lt $occuranceArray.Count; $j++) {
                        $fileContent += @"

[$($occuranceArray[$j] + 1)]
Meter=Shape
X=(#LeftW# * #scale# + ((#W#-(#LeftW#+22+75)*#scale#)/ $($AppHash[$AppArray[$i-1]].Count) - 10 * ($($AppHash[$AppArray[$i-1]].Count) - 1) + 20)* $j)
MeterStyle=ShapeStyle | ShapeStyle:$($AppHash[$AppArray[$i-1]].Count)

"@
                    }

                } else {
                    $fileContent += @"

[Vol$i]
Meter=String
MeterStyle=RegularText | TextStyle | TextStyle:#FetchIcons#
                
[$i]
Meter=Shape
MeterStyle=ShapeStyle

"@
                }
                $fileContent += @"

[VolPer$i]
Meter=String
MeterStyle=RegularText | VolStyle

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

[AppVolPer$i]
Measure=Calc
Formula=Round(AppVol$i * 100)
Group=UpdateWhenChange
Substitute="-100":"Muted"

"@
            }
        }
    
    }

    $fileContent | Out-File -FilePath $($RmAPI.VariableStr('ROOTCONFIGPATH') + 'Main\\Accessories\\Page\\Variants\\VolumeMixerCache.inc') -Encoding unicode

    $RmAPI.Bang("[!WriteKeyValue Variables W $pageW `"$saveLocation`"][!WriteKeyValue Variables H $pageH `"$saveLocation`"][!Activateconfig `"YourMixer\Main\Accessories\Page`"]")
}
