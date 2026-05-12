local function getKey()
    local secret = 73
    local t = os.date("*t")

    local keyNumber = (t.day * 3 + t.month * 7 + t.year + secret) % 9999
    return "Nghia_" .. tostring(keyNumber)
end

local player = game.Players.LocalPlayer

-- GUI KEY
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local box = Instance.new("TextBox")
box.Size = UDim2.new(0,200,0,40)
box.Position = UDim2.new(0.5,-100,0.4,0)
box.PlaceholderText = "Nhập key..."
box.Parent = gui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0,200,0,40)
button.Position = UDim2.new(0.5,-100,0.5,0)
button.Text = "Vào script"
button.Parent = gui

local status = Instance.new("TextLabel")
status.Size = UDim2.new(0,300,0,30)
status.Position = UDim2.new(0.5,-150,0.6,0)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.new(1,1,1)
status.Text = ""
status.Parent = gui

-- 🔥 SCRIPT CHÍNH ĐƯỢC ĐẶT Ở ĐÂY
local function loadHub()

    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local espEnabled = false
    local hitboxEnabled = false

    local main = Instance.new("Frame")
    main.Parent = gui
    main.Size = UDim2.new(0,220,0,160)
    main.Position = UDim2.new(0.5,-110,0.5,-80)
    main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    main.Active = true
    main.Draggable = true

    Instance.new("UICorner", main)

    local title = Instance.new("TextLabel")
    title.Parent = main
    title.Size = UDim2.new(1,0,0,30)
    title.BackgroundTransparency = 1
    title.Text = "NghiadzaiiHub"
    title.TextColor3 = Color3.new(1,1,1)
    title.TextScaled = true

    -- ESP BUTTON
    local espButton = Instance.new("TextButton")
    espButton.Parent = main
    espButton.Size = UDim2.new(0,180,0,35)
    espButton.Position = UDim2.new(0.5,-90,0,45)
    espButton.Text = "ESP : OFF"

    espButton.MouseButton1Click:Connect(function()
        espEnabled = not espEnabled
        espButton.Text = espEnabled and "ESP : ON" or "ESP : OFF"
    end)

    -- HITBOX BUTTON
    local hitboxButton = Instance.new("TextButton")
    hitboxButton.Parent = main
    hitboxButton.Size = UDim2.new(0,180,0,35)
    hitboxButton.Position = UDim2.new(0.5,-90,0,90)
    hitboxButton.Text = "Hitbox : OFF"

    hitboxButton.MouseButton1Click:Connect(function()
        hitboxEnabled = not hitboxEnabled
        hitboxButton.Text = hitboxEnabled and "Hitbox : ON" or "Hitbox : OFF"
    end)

    while task.wait(2) do
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("Humanoid") and Players:GetPlayerFromCharacter(v) == nil then

                local hrp = v:FindFirstChild("HumanoidRootPart")
                if hrp then

                    if hitboxEnabled then
                        hrp.Size = Vector3.new(500,500,500)
                        hrp.Transparency = 1
                        hrp.CanCollide = false
                    end

                    if espEnabled then
                        if not v:FindFirstChild("Highlight") then
                            local h = Instance.new("Highlight")
                            h.FillColor = Color3.fromRGB(0,255,255)
                            h.Parent = v
                        end
                    else
                        if v:FindFirstChild("Highlight") then
                            v.Highlight:Destroy()
                        end
                    end
                end
            end
        end
    end
end

button.MouseButton1Click:Connect(function()
    local input = box.Text

    if input == getKey() then
        status.Text = "✔ Key đúng rồi!"
        task.wait(1)
        gui:ClearAllChildren()
        loadHub()
    else
        status.Text = "❌ Sai key"
    end
end)
