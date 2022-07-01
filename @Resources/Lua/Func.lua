globalMixerVolumeIndex = 0

function Initialize()

    if SKIN:GetVariable('CURRENTCONFIG') == [[YourMixer\Main\Elements\ControlScreen]] then
        -- ------------------------ built device context menu ----------------------- --
        local deviceList = SKIN:GetMeasure('p.AudioLevel.DeviceList'):GetStringValue()

        local i = 1
        for name in string.gmatch(deviceList, '{[.%d]*}.{[%x-]*}: ([^\n]*)') do
            local action = '[!CommandMeasure "AppVol0" "SetOutPutIndex ' .. i .. '"][!UpdateMeasure ACTIONREFRESH "YourMixer\\Main"]'
            if i == 1 then index = '' else index = i end
            SKIN:Bang('!SetOption', 'Rainmeter', 'ContextTitle' .. index, name)
            SKIN:Bang('!SetOption', 'Rainmeter', 'ContextAction' .. index, action)
            i = i + 1
        end

        SKIN:Bang('!SetOption', 'Rainmeter', 'ContextTitle' .. i, '▶️ &Configure Devices...')
        SKIN:Bang('!SetOption', 'Rainmeter', 'ContextAction' .. i, '[Shell:::{F2DDFC82-8F12-4CDD-B7DC-D4FE1425AA4D}]')

        -- ------------------------ stay on desktop operation ----------------------- --
        if SKIN:GetVariable('StayOnDesktop') == '0' then

            SKIN:Bang('[!Delay 100][!EnableMeasureGroup NUOL][!UpdateMeasure ACTIONLOAD][!CommandMeasure p.Focus "#CURRENTCONFIG#"][!Draggable 0][!ZPos 1]')

        -- ------------------------------- positioning ------------------------------ --

            local pos = SKIN:GetVariable('Position')
            local posX = string.sub(pos, 2, 2)
            local posY = string.sub(pos, 1, 1)
            local pad = SKIN:GetVariable('ScreenPadding')
            local MonitorIndex = SKIN:GetVariable('MonitorIndex')
            local taskbar = SKIN:GetVariable('PreserveTaskbarSpace')
            local sax =SKIN:GetVariable('SCREENAREAX@'..MonitorIndex)
            local say = SKIN:GetVariable('SCREENAREAY@'..MonitorIndex)
            local saw = SKIN:GetVariable('SCREENAREAWIDTH@'..MonitorIndex)
            local sah = SKIN:GetVariable('SCREENAREAHEIGHT@'..MonitorIndex)
            local waw = SKIN:GetVariable('WORKAREAWIDTH@'..MonitorIndex)
            local wah = SKIN:GetVariable('WORKAREAHEIGHT@'..MonitorIndex)
            local xdif = saw - waw
            local ydif = sah - wah
            MoveX = 0
            MoveY = 0
            AnchorX = 0
            AnchorY = 0

            if posX == 'L' then MoveX = (sax + pad + taskbar * xdif)
            elseif posX == 'C' then
                MoveX = (sax + saw/2)
                AnchorX = "50%"
            elseif posX == 'R' then
                MoveX = (sax + saw - pad - taskbar * xdif)
                AnchorX = "100%"
            end

            if posY == 'T' then MoveY = (say + pad + taskbar * ydif)
            elseif posY == 'C' then
                MoveY = (say + sah/2)
                AnchorY = "50%"
            elseif posY == 'B' then
                MoveY = (say + sah - pad - taskbar * ydif)
                AnchorY = "100%"
            end
            SKIN:Bang('!SetWindowPosition '..MoveX..' '..MoveY..' '..AnchorX..' '..AnchorY)

            -- ------------------------- handle animation toggle ------------------------ --

            if tonumber(SKIN:GetVariable('Animated')) == 1 then
                AniSteps = tonumber(SKIN:GetVariable('AniSteps'))
                TweenInterval = 100 / AniSteps
                ScreenPadding = SKIN:GetVariable('ScreenPadding')
                AnimationDisplacement = SKIN:GetVariable('AnimationDisplacement')
                AniDir = SKIN:GetVariable('AniDir')
                dofile(SELF:GetOption("ScriptFile"):match("(.*[/\\])") .. "tween.lua")
                subject = {
                    TweenNode = 0
                }
                t = tween.new(AniSteps, subject, {TweenNode=100}, SKIN:GetVariable('Easetype'))
            end
        else
            SKIN:Bang('[!Delay 100][!Show]')
            SKIN:Bang('!Draggable', '1')
            SKIN:Bang('!ZPos', '0')
            SKIN:Bang('[!SetAnchor 0 0]')
        end
    else
        if SKIN:GetVariable('StayOnDesktop') == '1' then
            SKIN:Bang('[!DisableMeasure mToggleSet][!DisableMeasure mToggle]')
            SKIN:Bang('[\"#@#Actions\\AHKv1.exe\" \"#@#Actions\\Source Code\\Close.ahk\"]')
            SKIN:Bang('[!SetOption AppVolumeParent OnChangeAction """[!CommandMeasure generateMixer "generateMixer"][!Refresh "YourMixer\\Main\\Elements\\ControlScreen"]"""]')
            SKIN:Bang('[!Delay 100][!EnableMeasureGroup NUOL][!UpdateMeasure ACTIONLOAD]')
        else
            if SKIN:GetVariable('Hotkey') == '1' then
                SKIN:Bang('[!Delay 100][!Deactivateconfig "YourMixer\\Main\\Elements\\ControlScreen"][\"#@#Actions\\AHKv1.exe\" \"#@#Actions\\Source Code\\YourMixer.ahk\"][!EnableMeasureGroup NUOL]')
            else
                SKIN:Bang('[!Delay 100][!Deactivateconfig "YourMixer\\Main\\Elements\\ControlScreen"][\"#@#Actions\\AHKv1.exe\" \"#@#Actions\\Source Code\\Close.ahk\"][!EnableMeasureGroup NUOL]')
            end
        end
    end
end

function MixerMoveMouse(xpos, ypos)
    local isOff = SKIN:GetMeasure('mToggle'):GetValue()
    if isOff ~= 0 then
        if tonumber(SKIN:GetVariable('Animated')) == 2 then
            MoveX = xpos
            MoveY = ypos
            AnchorX = '50%'
            AnchorY = '50%'
        else
            SKIN:Bang('[!SetWindowPosition '..xpos..' '..ypos..' 50% 50%]')
        end
    end
end

function SaveLocation()
    local pos = SKIN:GetVariable('Position')
    MoveX = tonumber(SKIN:GetX())
    MoveY = tonumber(SKIN:GetY())
    AnchorX = 0
    AnchorY = 0
end

function InitActions(type, reset)
    if type == 1 and tonumber(SKIN:GetVariable('BackgroundMod')) == 1 then
        SKIN:Bang('[!ActivateConfig "YourMixer\\Main\\Elements\\Unload"]')
    elseif type == -1 then
        if tonumber(SKIN:GetVariable('BackgroundMod')) == 1 then
            SKIN:Bang('[!DeactivateConfig "YourMixer\\Main\\Elements\\Unload"]')
        end
        SKIN:Bang('[!DeactivateConfig]')
    end
end

function TweenAnimation(dir)
    if dir == 'in' then
        local complete = t:update(1)
    else
        local complete = t:update(-1)
    end
    local bang = ''
    resultantTN = subject.TweenNode
    if resultantTN > 100 then resultantTN = 100 elseif resultantTN < 0 then resultantTN = 0 end
    if AniDir == 'Left' then
        bang = bang..'[!SetWindowPosition '..MoveX + (resultantTN / 100 - 1) * AnimationDisplacement..' '..MoveY..' '..AnchorX..' '..AnchorY..']'
    elseif AniDir == 'Right' then
        bang = bang..'[!SetWindowPosition '..MoveX + (1 - resultantTN / 100) * AnimationDisplacement..' '..MoveY..' '..AnchorX..' '..AnchorY..']'
    elseif AniDir == 'Top' then
        bang = bang..'[!SetWindowPosition '..MoveX..' '..MoveY + (resultantTN / 100 - 1) * AnimationDisplacement..' '..AnchorX..' '..AnchorY..']'
    elseif AniDir == 'Bottom' then
        bang = bang..'[!SetWindowPosition '..MoveX..' '..MoveY + (1 - resultantTN / 100) * AnimationDisplacement..' '..AnchorX..' '..AnchorY..']'
    end
    bang = bang .. '[!SetTransparency '..(resultantTN / 100 * 255)..']'
    bang = bang..'[!UpdateMeasure ActionTimer]'
    SKIN:Bang(bang)
end

-- -------------------------------------------------------------------------- --
--                                   Sliders                                  --
-- -------------------------------------------------------------------------- --

function InitMultiSlider(index, customW, useCurrentSliderX)
    local AppVolPer = SKIN:GetMeasure('AppVolPer'..index):GetValue()
    if useCurrentSliderX then sliderMeterHandler = useCurrentSliderX else sliderMeterHandler = index end
    globalMixerVolumeIndex = index
    -- -------------------------- Volume bar properties ------------------------- --
    volbar_width = customW or tonumber(SKIN:GetMeasure('m.volbar_width'):GetValue())
    volbar_padding = SKIN:GetMeasure('m.volbar_padding')
    volbar_divide_margin = SKIN:GetMeasure('m.volbar_divide_margin')
    if volbar_padding == nil then volbar_padding = 0 else volbar_padding = tonumber(volbar_padding:GetValue()) end
    if volbar_divide_margin == nil then volbar_divide_margin = 0 else volbar_divide_margin = tonumber(volbar_divide_margin:GetValue()) end
    SliderX = SKIN:GetMeter(sliderMeterHandler):GetX() + volbar_padding
    -- ------------------------------- Start drag ------------------------------- --
    SKIN:Bang('[!SetOption AppVolPer'..index..' Formula '..AppVolPer..'][!CommandMeasure p.MeasureMouse "Start"]')
end
function DragMultiSlider(posX)
    local function round(num, idp)
        assert(tonumber(num), 'Round expects a number.')
        local mult = 10 ^ (idp or 0)
        if num >= 0 then
            return math.floor(num * mult + 0.5) / mult
        else
            return math.ceil(num * mult - 0.5) / mult
        end
    end
    local function clamp(num, lower, upper)
        assert(num and lower and upper, 'error: Clamp(num, lower, upper)')
        return math.max(lower, math.min(upper, num))
    end
    local index = globalMixerVolumeIndex --Index of volume to change
    local Int = SKIN:GetMeter(sliderMeterHandler):GetOption('Int')
    local SliderW = (volbar_width / Int - volbar_divide_margin * (Int-1) - volbar_padding * 2) -- Calculate actual SliderW by Int
    local rawPer = ((posX-SliderX)*100/(((SliderX)+SliderW)-(SliderX))) -- Calculate raw percentage for bar
    local resultantPer = round(clamp(rawPer, 0, 100), 0) -- Calculate rounded percentage for changing volume
    SKIN:Bang('[!SetOption AppVolPer'..index..' Formula '..resultantPer..'][!CommandMeasure AppVol'..index..' "SetVolume '..resultantPer..'"][!UpdateMeter *][!UpdateMeasureGroup UpdateWhenChange][!Redraw]')
end

function TermMultiSlider()
    local function clamp(num, lower, upper)
        assert(num and lower and upper, 'error: Clamp(num, lower, upper)')
        return math.max(lower, math.min(upper, num))
    end
    local index = globalMixerVolumeIndex
    SKIN:Bang('[!SetOption AppVolPer'..index..' Formula "Round(AppVol'..index..' * '..clamp(100*index,1,100)..')"][!CommandMeasure p.MeasureMouse "Stop"][!UpdateMeter *][!UpdateMeasureGroup UpdateWhenChange][!Redraw]')
end
-- -------------------------------------------------------------------------- --
--                                    Util                                    --
-- -------------------------------------------------------------------------- --

function returnBool(Variable, Match, ReturnStringT, ReturnStringF)

	local Var = SKIN:GetVariable(Variable)

	local ReturnStringT = ReturnStringT or '1'
	local ReturnStringF = ReturnStringF or '0'
	if Var == Match then
		return(ReturnStringT)
	  else
		return(ReturnStringF)
	end
end

function returnCenterString(MinimumWidth)
    if MinimumWidth <= SKIN:GetW() then
        return 'Center'
    else
        return 'Left'
    end
end

function volumeLevel(handler, rep, suf)
    rep = rep or '0'
    suf = suf or ''
    local level = SKIN:GetMeasure('App'..handler):GetValue()
    if level <= -1 then
        return rep
    else
        return level .. suf
    end
end