if not LibStub then error("AnglerAtlas requires LibStub.") end

AnglerAtlasSettings = AnglerAtlasSettings or {}
AnglerAtlas = AnglerAtlas or {}
AnglerAtlas.MM = {}

local modules = {}

function AnglerAtlas.MM:RegisterModule(name, module)
    if (not modules[name]) then
        modules[name] = module
        print("Module "..name.." registered")
        return modules[name]
    else
        error("Module "..name.." already exists")
    end
end

function AnglerAtlas.MM:GetModule(name)
    return modules[name]
end
