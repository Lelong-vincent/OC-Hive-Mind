local serialization = require("serialization")
local sides = require("sides")

local vector = require("hiveMind/vector")

local utils = {
    error = {}
}

function utils.prettyPrint(x)
    print(serialization.serialize(x, true))
end

function utils.sideToVector(side)
    if type(side) == "string" then
        side = sides[side]
    end

    if side == sides.bottom then return vector(0,-1,0) end
    if side == sides.top then return vector(0,1,0) end
    if side == sides.back then return vector(0,0,-1) end
    if side == sides.front then return vector(0,0,1) end
    if side == sides.right then return vector(-1,0,0) end
    if side == sides.left then return vector(1,0,0) end

    error("utils.sideToVector: Unknown side "..serialization.serialize(side, true))
end

function utils.error.checkIsVector(vector, functionName)
    if type(vector) ~= "table" then error(functionName..": vector is not a table") end
    if not vector.isvec3(vector) then error(functionName..": vector is not a vector") end
end

return utils
