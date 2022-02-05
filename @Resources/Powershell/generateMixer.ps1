function generateMixer {
    $saveLocation = "$($RmAPI.VariableStr('ROOTCONFIGPATH'))Main\Accessories\Page\Main.ini"
    $scale = $RmAPI.VariableStr('scale')
    $pageW = $RmAPI.VariableStr('W')

    $rows = $RmAPI.Measure('AppVolumeParent')
    if (($rows -gt 0) -and ($RmAPI.Variable('Stroke') -eq 1)) {
        $fileContent += @"

[Divider]
Meter=Shape
MeterStyle=DividerStyle

"@
    $additionalSize = 40
    }
    $pageH = ((60+(40+($RmAPI.Variable('additionalPadding')))*($rows+1)+20+$additionalSize) * $scale)
    for (($i = 1); $i -le $rows; $i++) {
        $fileContent += @"
[AppVol$i]
Measure=Plugin
Plugin=AppVolume
Parent=AppVolumeParent
Index=$i
Substitute=".exe":""
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
    $fileContent | Out-File -FilePath $($RmAPI.VariableStr('ROOTCONFIGPATH') + 'Main\\Accessories\\Page\\Variants\\VolumeMixerCache.inc') -Encoding unicode

    $RmAPI.Bang("[!WriteKeyValue Variables W $pageW `"$saveLocation`"][!WriteKeyValue Variables H $pageH `"$saveLocation`"][!Activateconfig `"YourMixer\Main\Accessories\Page`"]")
    
}
