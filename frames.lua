local function SETPOINT(FRAME, POINT, RELFRAME, REL, X, Y)
    FRAME:ClearAllPoints()
	FRAME:SetPoint(POINT, RELFRAME, REL, X, Y)
	-- breaks certain Blizzard functions
	-- but hooksecurefunc isn't persisent
	FRAME.SetPoint = function(...) end;
end

-- https://wowwiki-archive.fandom.com/wiki/Making_Draggable_Frames
local function UNLOCK(FRAME)
    FRAME:SetMovable(true)
    FRAME:EnableMouse(true)
    FRAME:SetScript("OnMouseDown", function(self, button)
        if button == "RightButton" then
            self:SetMovable(not self:IsMovable())
        end
        if
            button == "LeftButton"
            and self:IsMovable()
            and not self.IsMoving
        then
            self:StartMoving()
            self.IsMoving = true
        end
    end)
    FRAME:SetScript("OnMouseUp", function(self, button)
        if not self:IsMovable() then
            return
        end
        if button == "LeftButton" and self.IsMoving then
            self:StopMovingOrSizing()
            self.IsMoving = false
        end
    end)
end

-- damage font
DAMAGE_TEXT_FONT = "Fonts\\PEPSI.ttf"

misc = CreateFrame("Frame")
misc:RegisterEvent("PLAYER_ENTERING_WORLD")
misc:SetScript("OnEvent", function(self, event, isLogin, isReload)
    if isLogin or isReload then
		-- cvars
		SetCVar("UIScale", 768/1080)
		
		-- unit frames
		SETPOINT(PlayerFrame, "CENTER", UIParent, "CENTER", -230, -180)
		SETPOINT(TargetFrame, "CENTER", UIParent, "CENTER", 230, -180)
		
		-- move minimap
		MinimapBackdrop:SetPoint("CENTER", Minimap, "CENTER", -10, -20)
		MinimapZoneTextButton:SetPoint("CENTER", Minimap, "TOP", 0, 15)
		SETPOINT(Minimap, "TOPLEFT", UIParent, "TOPLEFT", 30, -30)
		UNLOCK(Minimap)
	end
end)