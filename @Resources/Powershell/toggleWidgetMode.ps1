
# ---------------------------------------------------------------------------- #
#                                   Functions                                  #
# ---------------------------------------------------------------------------- #

function Get-IniContent ($filePath) {
    $ini = [ordered]@{}
    if (![System.IO.File]::Exists($filePath)) {
        throw "$filePath invalid"
    }
    # $section = ';ItIsNotAFuckingSection;'
    # $ini.Add($section, [ordered]@{})

    foreach ($line in [System.IO.File]::ReadLines($filePath)) {
        if ($line -match "^\s*\[(.+?)\]\s*$") {
            $section = $matches[1]
            $secDup = 1
            while ($ini.Keys -contains $section) {
                $section = $section + '||ps' + $secDup
            }
            $ini.Add($section, [ordered]@{})
        }
        elseif ($line -match "^\s*;.*$") {
            $notSectionCount = 0
            while ($ini[$section].Keys -contains ';NotSection' + $notSectionCount) {
                $notSectionCount++
            }
            $ini[$section][';NotSection' + $notSectionCount] = $matches[1]
        }
        elseif ($line -match "^\s*(.+?)\s*=\s*(.+?)$") {
            $key, $value = $matches[1..2]
            $ini[$section][$key] = $value
        }
        else {
            $notSectionCount = 0
            while ($ini[$section].Keys -contains ';NotSection' + $notSectionCount) {
                $notSectionCount++
            }
            $ini[$section][';NotSection' + $notSectionCount] = $line
        }
    }

    return $ini
}

function Set-IniContent($ini, $filePath) {
    $str = @()

    foreach ($section in $ini.GetEnumerator()) {
        if ($section -ne ';ItIsNotAFuckingSection;') {
            $str += "[" + ($section.Key -replace '\|\|ps\d+$', '') + "]"
        }
        foreach ($keyvaluepair in $section.Value.GetEnumerator()) {
            if ($keyvaluepair.Key -match "^;NotSection\d+$") {
                $str += $keyvaluepair.Value
            }
            else {
                $str += $keyvaluepair.Key + "=" + $keyvaluepair.Value
            }
        }
    }

    $finalStr = $str -join [System.Environment]::NewLine

    $finalStr | Out-File -filePath $filePath -Force -Encoding unicode
}

# ---------------------------------------------------------------------------- #
#                                    Actions                                   #
# ---------------------------------------------------------------------------- #


function Toggle-MixerMode {

    $CurrentMode = $RmAPI.VariableStr('StayOnDesktop')
    $SaveLocation = $RmAPI.VariableStr('Sec.SaveLocation')

    $Ini = Get-IniContent -filePath "$($RmAPI.VariableStr('SETTINGSPATH'))Rainmeter.ini"
    if ($CurrentMode -eq 1) {
        # ---------------------------- Set to module mode ---------------------------- #
        $Ini['YourMixer\Main\Elements\ControlScreen'].SavePosition = 0
        $Ini['YourMixer\Main\Elements\ControlScreen'].AlphaValue = 1
        $Ini['YourMixer\Main\Elements\ControlScreen'].Remove('WindowX')
        $Ini['YourMixer\Main\Elements\ControlScreen'].Remove('WindowY')
        Set-IniContent -ini $Ini -filePath "$($RmAPI.VariableStr('SETTINGSPATH'))Rainmeter.ini"
        # ------------- Standard actions ------------- #
        $RmAPI.Bang('[!SetVariable StayOnDesktop 0][!WriteKeyValue Variables StayOnDesktop "0" '+$SaveLocation+'][!UpdateMeasure Auto_Refresh:M][!UpdateMeter *][!Redraw]')
    } else {
        # ---------------------------- Set to widget mode ---------------------------- #
        $Ini['YourMixer\Main\Elements\ControlScreen'].SavePosition = 1
        $Ini['YourMixer\Main\Elements\ControlScreen'].AlphaValue = 255
        Set-IniContent -ini $Ini -filePath "$($RmAPI.VariableStr('SETTINGSPATH'))Rainmeter.ini"
        # ------------- Standard actions ------------- #
        $RmAPI.Bang('[!SetVariable StayOnDesktop 1][!WriteKeyValue Variables StayOnDesktop "1" '+$SaveLocation+'][!UpdateMeasure Auto_Refresh:M][!UpdateMeter *][!Redraw]')
    }
}