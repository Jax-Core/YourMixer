function generateMixer {
    $saveLocation = "$($RmAPI.VariableStr('ROOTCONFIGPATH'))Main\Accessories\Page\Main.ini"
    $scale = $RmAPI.VariableStr('scale')
    $pageW = $RmAPI.VariableStr('W')

    $rows = $RmAPI.Measure('AppVolumeParent')
    $pageH = ((60+40*($rows+1)+20+40) * $scale)
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

[Vol$i]
Meter=String
MeterStyle=RegularText | TextStyle

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
