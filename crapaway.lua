if C_Container ~= nil then
	GetContainerNumSlots = C_Container.GetContainerNumSlots
	GetContainerItemLink = C_Container.GetContainerItemLink
	UseContainerItem     = C_Container.UseContainerItem
end

frmcrapaway = CreateFrame("FRAME")
frmcrapaway:RegisterEvent("MERCHANT_SHOW");
frmcrapaway:SetScript('OnEvent', function()
	local caSlots,caLink,caQuality;
	local i=0,j;
	local _,caClass=UnitClass("player");
	repeat
		if not(GetContainerNumSlots(i)==nil)then
			caSlots=GetContainerNumSlots(i);
			j=1;
			repeat
				caLink=GetContainerItemLink(i,j);
				if not(caLink==nil)then                        
					_,_,caQuality=GetItemInfo(caLink);
					if(caQuality==0)then
						UseContainerItem(i,j);
					end
				end
				j=j+1;
			until(j>=caSlots+1)
		end
		i=i+1;
	until(i>=5)
end)
