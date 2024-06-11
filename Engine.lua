Credits = [[
 ______     __     ______   ______     __   __        _____     ______     __   __  
/\___  \   /\ \   /\__  _\ /\  __ \   /\ "-.\ \      /\  __-.  /\  ___\   /\ \ / /  
\/_/  /__  \ \ \  \/_/\ \/ \ \ \/\ \  \ \ \-.  \     \ \ \/\ \ \ \  __\   \ \ \'/   
  /\_____\  \ \_\    \ \_\  \ \_____\  \ \_\\"\_\     \ \____-  \ \_____\  \ \__|   
  \/_____/   \/_/     \/_/   \/_____/   \/_/ \/_/      \/____/   \/_____/   \/_/    
                                                                                    
Beam Detector for the Flow2 System
Full credits for the script base from the Flow2 remasterd
Get this on Github @ https://github.com/Ziton-Development/Beam-Detector

Script Version: 1.1
Date = 11/06/2024
]]

local alarmstate = false
local candetect = true

local SystemSettings = require(script.Parent.Parent.Parent.FlowConfiguration)

script.Parent.Parent.Parent.FlowNetwork.Event:Connect(function(datain)
	if datain.AllCommand == "Reset" then
		alarmstate = false
	    candetect = true
	end
end)
if script.Parent.Parent.Parent.FlowNetwork.Disabled.Value == false then
	workspace.DescendantAdded:Connect(function(newdesc)
		if newdesc:IsA("Smoke") then
			local parent = newdesc:FindFirstAncestorWhichIsA("BasePart")
			if parent then
				if (script.Parent.Beam.Position - parent.Position).Magnitude < 80 and candetect then
					candetect = false
					for i = 1,math.ceil(((script.Parent.Beam.Position - parent.Position).Magnitude)/5),1 do
						wait(5)
					end
					if newdesc then
						script.Parent.Parent.Parent.FlowNetwork:Fire({FireInfo = {DeviceName = script.Parent.Device_Name.Value , AlarmType = script.Parent.Alarm_Type.Value}})
						alarmstate = true
					end
				end
			end
		end
	end)
end

