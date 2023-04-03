--[[
Showcase Videos:
https://i.gyazo.com/535cbdda84788ab6d094...07f25f.gif
https://i.gyazo.com/1c97fed9fe33bdbf2768...26baff.gif
https://i.gyazo.com/3fde2e1e96cf2a4ab0c0...b23f5e.gif
Credits:
Elden - Right Grip method
AnthonyIsntHere - Script
ic3 - Tool drop method
Cool shout-outs:
ShownApe
Hydro
Arian
Primadon
]]--

local Config = {
   DemeshTools = true,
   RemoveTouchInterest = false,
   CustomRightGripWeld = true
}

local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local Character = Player.Character
local RightArm = Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")

local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
local Tool = Character:FindFirstChildWhichIsA("Tool") or Player.Backpack:FindFirstChildWhichIsA("Tool")
local FinalPath = Tool -- can change this to humanoid watever

Humanoid:UnequipTools()

local CreateCustomRightGrip = function(Tool, CF)
   local Handle = Tool:FindFirstChild("Handle")
   local RightGrip = Instance.new("Weld")
   RightGrip.Name = "RightGrip"
   RightGrip.Part0 = RightArm
   RightGrip.Part1 = Handle
   RightGrip.C0 = CF
   RightGrip.C1 = Tool.Grip
   RightGrip.Parent = RightArm
   Handle.Massless = true
end

local Demesh = function(Tool)
   for _, x in next, Tool:GetDescendants() do
       if x:IsA("Mesh") or x:IsA("SpecialMesh") or x:IsA("MeshPart") then
           x:Destroy()
       end
   end
end

for _, x in next, Player.Backpack:GetChildren() do
   if _ > 0 and x ~= Tool then
       x.Parent = Character
       x.Parent = Tool
       x.Parent = Player.Backpack
       x.Parent = FinalPath
       if Config.CustomRightGripWeld then
           CreateCustomRightGrip(x, CFrame.new(0, -_ + 5, 0) * CFrame.Angles(math.rad(90), math.rad(90), 0))
       end
   end
end

Tool.Parent = Character

if Config.DemeshTools then
  for _, x in next, Tool:GetChildren() do
       if x:IsA("Tool") then
           local Mesh = x:FindFirstChildWhichIsA("Mesh", true) or x:FindFirstChildWhichIsA("SpecialMesh", true) or x:FindFirstChildWhichIsA("MeshPart", true)
           if Mesh then
              Mesh:Destroy()
           end
       end
   end
end

if Config.RemoveTouchInterest then
   for _, x in next, Tool:GetChildren() do
       if x:IsA("Tool") then
           local Touch = x:FindFirstChildWhichIsA("TouchTransmitter", true)
           if Touch then
              Touch:Destroy()
           end
       end
   end
end
