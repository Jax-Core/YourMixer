globalMixerVolumeIndex = 0

function Initialize()

    if SKIN:GetVariable('CURRENTCONFIG') == [[YourMixer\Main\Accessories\Page]] then
        -- ------------------------ built device context menu ----------------------- --
        local deviceList = SKIN:GetMeasure('MeasureDeviceList'):GetStringValue()

        local i = 1
        for id, name in string.gmatch(deviceList, '{[.%d]*}.{([%x-]*)}: ([^\n]*)') do
            local action = '[!CommandMeasure "AppVol0" "SetOutPutIndex ' .. i .. '"][!Refresh]'
            if i == 1 then index = '' else index = i end
            SKIN:Bang('!SetOption', 'Rainmeter', 'ContextTitle' .. index, name)
            SKIN:Bang('!SetOption', 'Rainmeter', 'ContextAction' .. index, action)
            i = i + 1
        end
        -- ------------------------ stay on desktop operation ----------------------- --
        if SKIN:GetVariable('StayOnDesktop') == '0' then

            SKIN:Bang('[!Delay 100][!EnableMeasureGroup NUOL][!UpdateMeasure ACTIONLOAD][!CommandMEasure Focus "#CURRENTCONFIG#"]')
            SKIN:Bang('!Draggable', '0')
            SKIN:Bang('!ZPos', '1')

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
            MoveX = 0
            MoveY = 0
            AnchorX = 0
            AnchorY = 0

            if posX == 'L' then MoveX = sax + pad
            elseif posX == 'C' then
                MoveX = (sax + saw/2)
                AnchorX = "50%"
            elseif posX == 'R' then
                MoveX = (sax + saw-pad)
                AnchorX = "100%"
            end

            if posY == 'T' then MoveY = say + pad
            elseif posY == 'C' then
                MoveY = (say + sah/2)
                AnchorY = "50%"
            elseif posY == 'B' then
                MoveY = (say + sah-pad - taskbar * 40)
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
        end
    else
        if SKIN:GetVariable('StayOnDesktop') == '1' then
            SKIN:Bang('[!DisableMeasure mToggleSet][!DisableMeasure mToggle]')
            SKIN:Bang('[\"#@#Actions\\AHKv1.exe\" \"#@#Actions\\Source Code\\Close.ahk\"]')
            SKIN:Bang('[!SetOption AppVolumeParent OnChangeAction """[!CommandMeasure generateMixer "generateMixer"][!Refresh "YourMixer\\Main\\Accessories\\Page"]"""]')
            SKIN:Bang('[!Delay 100][!EnableMeasureGroup NUOL][!UpdateMeasure ACTIONLOAD]')
        else
            if SKIN:GetVariable('Hotkey') == '1' then
                SKIN:Bang('[!Delay 100][!Deactivateconfig "YourMixer\\Main\\Accessories\\Page"][\"#@#Actions\\AHKv1.exe\" \"#@#Actions\\Source Code\\YourMixer.ahk\"][!EnableMeasureGroup NUOL]')
            else
                SKIN:Bang('[!Delay 100][!Deactivateconfig "YourMixer\\Main\\Accessories\\Page"][\"#@#Actions\\AHKv1.exe\" \"#@#Actions\\Source Code\\Close.ahk\"][!EnableMeasureGroup NUOL]')
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
        SKIN:Bang('[!ActivateConfig "YourMixer\\Main\\Accessories\\Unload"]')
    elseif type == -1 then
        if tonumber(SKIN:GetVariable('BackgroundMod')) == 1 then
            SKIN:Bang('[!DeactivateConfig "YourMixer\\Main\\Accessories\\Unload"]')
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
    resultantTN = subject.TweenNode
    if resultantTN > 100 then resultantTN = 100 elseif resultantTN < 0 then resultantTN = 0 end
    local bang = '[!SetTransparency '..(resultantTN / 100 * 255)..']'
    if AniDir == 'Left' then
        bang = bang..'[!SetWindowPosition '..MoveX + (resultantTN / 100 - 1) * AnimationDisplacement..' '..MoveY..' '..AnchorX..' '..AnchorY..']'
    elseif AniDir == 'Right' then
        bang = bang..'[!SetWindowPosition '..MoveX + (1 - resultantTN / 100) * AnimationDisplacement..' '..MoveY..' '..AnchorX..' '..AnchorY..']'
    elseif AniDir == 'Top' then
        bang = bang..'[!SetWindowPosition '..MoveX..' '..MoveY + (resultantTN / 100 - 1) * AnimationDisplacement..' '..AnchorX..' '..AnchorY..']'
    elseif AniDir == 'Bottom' then
        bang = bang..'[!SetWindowPosition '..MoveX..' '..MoveY + (1 - resultantTN / 100) * AnimationDisplacement..' '..AnchorX..' '..AnchorY..']'
    end
    bang = bang..'[!UpdateMeasure ActionTimer]'
    SKIN:Bang(bang)
end

-- function generateMixer()
--     local function clamp(num, lower, upper)
--         assert(num and lower and upper, 'error: Clamp(num, lower, upper)')
--         return math.max(lower, math.min(upper, num))
--     end
--     local SaveLocation = SKIN:GetVariable('ROOTCONFIGPATH')..'Main\\Accessories\\Page\\Main.ini'
--     local scale = SKIN:GetVariable('scale')
--     local pageW = SKIN:GetW()

--     local rows = SKIN:GetMeasure('AppVolumeParent'):GetValue()
--     local pageH = clamp(((60+40*(rows+1)+20+40) * scale),SKIN:GetVariable('MinH'),SKIN:GetVariable('SCREENAREAHEIGHT'))
--     local File = io.open(SKIN:GetVariable('ROOTCONFIGPATH')..'Main\\Accessories\\Page\\Variants\\VolumeMixerCache.inc','w')
--     File:write(
--         '[Divider]\n',
--         'Meter=Shape\n',
--         'MeterStyle=DividerStyle\n'
--     )
--     for i = 1, rows do
--         File:write(
--             '[AppVol'..i..']\n',
--             'Measure=Plugin\n',
--             'Plugin=AppVolume\n',
--             'Parent=AppVolumeParent\n',
--             'Index='..i..'\n',
--             'Substitute=".exe":""\n',
--             'Group=UpdateWhenChange\n',
--             '[AppVolPer'..i..']\n',
--             'Measure=Calc\n',
--             'Formula=Round(AppVol'..i..' * 100)\n',
--             'Group=UpdateWhenChange\n',
--             'Substitute="-100":"Muted"\n',
--             '[Vol'..i..']\n',
--             'Meter=String\n',
--             'MeterStyle=RegularText | TextStyle\n',
--             '['..i..']\n',
--             'Meter=Shape\n',
--             'MeterStyle=ShapeStyle\n',
--             '[VolPer'..i..']\n',
--             'Meter=String\n',
--             'MeterStyle=RegularText | VolStyle\n'
--         )
--     end
--     File:close()

--     SKIN:Bang('[!WriteKeyValue Variables W '..pageW..' "'..SaveLocation..'"][!WriteKeyValue Variables H '..pageH..' "'..SaveLocation..'"][!Activateconfig "YourMixer\\Main\\Accessories\\Page"]')
-- end

function InitMultiSlider(index)
    local AppVolPer = SKIN:GetMeasure('AppVolPer'..index):GetValue()
    globalMixerVolumeIndex = index
    SKIN:Bang('[!SetOption AppVolPer'..index..' Formula '..AppVolPer..'][!CommandMeasure MeasureMouse "Start"]')
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
    local index = globalMixerVolumeIndex
    local LeftW = SKIN:GetVariable('leftW')
    local globalW = SKIN:GetVariable('W')
    local scale = SKIN:GetVariable('scale')
    local SliderX = SKIN:GetMeter(index):GetX()
    local Int = SKIN:GetMeter(index):GetOption('Int')
    local SliderW = ((globalW - (LeftW + 22 + 75) * scale ) / Int - 10 * (Int-1))
    local rawPer = ((posX-SliderX)*100/(((SliderX)+SliderW)-(SliderX)))
    local resultantPer = round(clamp(rawPer, 0, 100), 0)
    SKIN:Bang('[!SetOption AppVolPer'..index..' Formula '..resultantPer..'][!CommandMeasure AppVol'..index..' "SetVolume '..resultantPer..'"][!UpdateMeter *][!UpdateMeasureGroup UpdateWhenChange][!Redraw]')
end

function TermMultiSlider()
    local function clamp(num, lower, upper)
        assert(num and lower and upper, 'error: Clamp(num, lower, upper)')
        return math.max(lower, math.min(upper, num))
    end
    local index = globalMixerVolumeIndex
    SKIN:Bang('[!SetOption AppVolPer'..index..' Formula "Round(AppVol'..index..' * '..clamp(100*index,1,100)..')"][!CommandMeasure MeasureMouse "Stop"][!UpdateMeter *][!UpdateMeasureGroup UpdateWhenChange][!Redraw]')
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