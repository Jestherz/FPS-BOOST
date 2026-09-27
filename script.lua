-- DIRECT ULTRA FPS BOOSTER
local Lighting = game:GetService("Lighting")
local Terrain = game:GetService("Workspace").Terrain

-- Paksa grafis ke level paling rendah
settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

-- Matikan efek visual berat
pcall(function()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    for _, obj in pairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") or obj:IsA("Atmosphere") or obj:IsA("PostEffect") then
            obj:Destroy()
        end
    end
end)

-- Bersihkan objek berat di dunia game
local function clean(v)
    pcall(function()
        if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v.Enabled = false
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        elseif v:IsA("BasePart") or v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.CastShadow = false
        end
    end)
end

for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
    clean(v)
end

game:GetService("Workspace").DescendantAdded:Connect(function(v)
    clean(v)
end)

print("FPS Booster Sukses Dijalankan Secara Langsung!")
