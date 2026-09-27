local Lighting = game:GetService("Lighting")
local Terrain = game:GetService("Workspace").Terrain

Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 1

for _, effect in pairs(Lighting:GetChildren()) do
    if effect:IsA("DepthOfFieldEffect") or effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("SunRaysEffect") then
        effect.Enabled = false
    end
end

for _, sky in pairs(Lighting:GetChildren()) do
    if sky:IsA("Sky") then
        sky:Destroy()
    end
end

Lighting.Ambient = Color3.fromRGB(150, 150, 150)
Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
Lighting.ClockTime = 0

Terrain.WaterWaveSize = 0
Terrain.WaterWaveSpeed = 0
Terrain.WaterReflectance = 0
Terrain.WaterTransparency = 0

local function cleanObject(obj)
    if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
        obj.Enabled = false
    -- Menggunakan pcall agar jika properti dikunci game, Delta tidak akan crash/berhenti berjalan
    elseif obj:IsA("BasePart") then
        pcall(function()
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
            obj.CastShadow = false
        end)
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        pcall(function()
            obj:Destroy()
        end)
    end
end

for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
    cleanObject(obj)
end

game:GetService("Workspace").DescendantAdded:Connect(function(obj)
    cleanObject(obj)
end)

-- Menghapus setfpscap dan sethiddenproperty karena sering memicu error jika Delta belum diperbarui
print("FPS Booster versi aman berhasil dijalankan!")
