globalMixerVolumeIndex = 0

function Initialize()

    -- ------------------------------- positioning ------------------------------ --
    
    local pos = SKIN:GetVariable('Position')
    local posX = string.sub(pos, 2, 2)
    local posY = string.sub(pos, 1, 1)
    local pad = SKIN:GetVariable('ScreenPadding')
    local saw = SKIN:GetVariable('SCREENAREAWIDTH')
    local sah = SKIN:GetVariable('SCREENAREAHEIGHT')
    moveX = 0
    moveY = 0
    anchorX = 0
    anchorY = 0
    
    if posX == 'L' then moveX = pad
    elseif posX == 'C' then
        moveX = (saw/2)
        anchorX = "50%"
    elseif posX == 'R' then
        moveX = (saw-pad)
        anchorX = "100%"
    end
    
    if posY == 'T' then moveY = pad
    elseif posY == 'C' then
        moveY = (sah/2)
        anchorY = "50%"
    elseif posY == 'B' then
        moveY = (sah-pad)
        anchorY = "100%"
    end

    SKIN:Bang('!SetWindowPosition '..moveX..' '..moveY..' '..anchorX..' '..anchorY)

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
end

function mixerMoveMouse(xpos, ypos)
    local isOff = SKIN:GetMeasure('mToggle'):GetValue()
    if isOff ~= 0 then
        if tonumber(SKIN:GetVariable('Animated')) == 2 then
            moveX = xpos
            moveY = ypos
            anchorX = '50%'
            anchorY = '50%'
        else
            SKIN:Bang('[!SetWindowPosition '..xpos..' '..ypos..' 50% 50%]')
        end
    end
end

function saveLocation()
    local pos = SKIN:GetVariable('Position')
    moveX = tonumber(SKIN:GetX())
    moveY = tonumber(SKIN:GetY())
    anchorX = 0
    anchorY = 0
end

function initActions(type, reset)
    if type == 1 and tonumber(SKIN:GetVariable('BackgroundMod')) == 1 then
        SKIN:Bang('[!ActivateConfig "YourMixer\\Main\\Accessories\\Unload"]')
    elseif type == -1 then
        if tonumber(SKIN:GetVariable('BackgroundMod')) == 1 then
            SKIN:Bang('[!DeactivateConfig "YourMixer\\Main\\Accessories\\Unload"]')
        end
        SKIN:Bang('[!DeactivateConfig]')
    end
end

function tweenAnimation(dir)
    if dir == 'in' then 
        local complete = t:update(1)
    else
        local complete = t:update(-1)
    end
    resultantTN = subject.TweenNode
    if resultantTN > 100 then resultantTN = 100 elseif resultantTN < 0 then resultantTN = 0 end
    local bang = '[!SetTransparency '..(resultantTN / 100 * 255)..']'
    if AniDir == 'Left' then
        bang = bang..'[!SetWindowPosition '..moveX + (resultantTN / 100 - 1) * AnimationDisplacement..' '..moveY..' '..anchorX..' '..anchorY..']'
    elseif AniDir == 'Right' then
        bang = bang..'[!SetWindowPosition '..moveX + (1 - resultantTN / 100) * AnimationDisplacement..' '..moveY..' '..anchorX..' '..anchorY..']'
    elseif AniDir == 'Top' then
        bang = bang..'[!SetWindowPosition '..moveX..' '..moveY + (resultantTN / 100 - 1) * AnimationDisplacement..' '..anchorX..' '..anchorY..']'
    elseif AniDir == 'Bottom' then
        bang = bang..'[!SetWindowPosition '..moveX..' '..moveY + (1 - resultantTN / 100) * AnimationDisplacement..' '..anchorX..' '..anchorY..']'
    end
    bang = bang..'[!UpdateMeasure ActionTimer]'
    SKIN:Bang(bang)
end

function generateMixer()
    local function clamp(num, lower, upper)
        assert(num and lower and upper, 'error: Clamp(num, lower, upper)')
        return math.max(lower, math.min(upper, num))
    end
    local saveLocation = SKIN:GetVariable('ROOTCONFIGPATH')..'Main\\Accessories\\Page\\Main.ini'
    local scale = SKIN:GetVariable('scale')
    local pageW = SKIN:GetW()

    local rows = SKIN:GetMeasure('AppVolumeParent'):GetValue()
    local pageH = clamp(((60+40*rows+20) * scale),SKIN:GetVariable('MinH'),SKIN:GetVariable('SCREENAREAHEIGHT'))
    local File = io.open(SKIN:GetVariable('ROOTCONFIGPATH')..'Main\\Accessories\\Page\\Variants\\VolumeMixerCache.inc','w')
    for i = 1, rows do
        File:write(
            '[AppVol'..i..']\n',
            'Measure=Plugin\n',
            'Plugin=AppVolume\n',
            'Parent=AppVolumeParent\n',
            'Index='..i..'\n',
            'Substitute=".exe":""\n',
            'Group=UpdateWhenChange\n',
            '[AppVolPer'..i..']\n',
            'Measure=Calc\n',
            'Formula=Round(AppVol'..i..' * 100)\n',
            'Group=UpdateWhenChange\n',
            'Substitute="-100":"Muted"\n',
            '[Vol'..i..']\n',
            'Meter=String\n',
            'MeterStyle=RegularText | TextStyle\n',
            '['..i..']\n',
            'Meter=Shape\n',
            'MeterStyle=ShapeStyle\n',
            '[VolPer'..i..']\n',
            'Meter=String\n',
            'MeterStyle=RegularText | VolStyle\n'
        )
    end
    File:close()

    SKIN:Bang('[!WriteKeyValue Variables W '..pageW..' "'..saveLocation..'"][!WriteKeyValue Variables H '..pageH..' "'..saveLocation..'"][!Activateconfig "YourMixer\\Main\\Accessories\\Page"]')
end

function initMultiSlider(index)
    local AppVolPer = SKIN:GetMeasure('AppVolPer'..index):GetValue()
    globalMixerVolumeIndex = index
    SKIN:Bang('[!SetOption AppVolPer'..index..' Formula '..AppVolPer..'][!CommandMeasure MeasureMouse "Start"]')
end
function dragMultiSlider(posX)
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
    local index = globalMixerVolumeIndex
    local globalW = SKIN:GetVariable('W')
    local scale = SKIN:GetVariable('scale')
    local SliderX = SKIN:GetMeter(index):GetX()
    local SliderW = globalW - (150+22+75) * scale
    local rawPer = ((posX-SliderX)*100/(((SliderX)+SliderW)-(SliderX)))
    local resultantPer = round(clamp(rawPer, 0, 100), 0)
    SKIN:Bang('[!SetOption AppVolPer'..index..' Formula '..resultantPer..'][!CommandMeasure AppVol'..index..' "SetVolume '..resultantPer..'"][!UpdateMeter *][!UpdateMeasureGroup UpdateWhenChange][!Redraw]')
end

function termMultiSlider()
    local index = globalMixerVolumeIndex
    SKIN:Bang('[!SetOption AppVolPer'..index..' Formula "Round(AppVol'..index..' * 100)"][!CommandMeasure MeasureMouse "Stop"][!UpdateMeter *][!UpdateMeasureGroup UpdateWhenChange][!Redraw]')
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