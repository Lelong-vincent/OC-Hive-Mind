local component = require("component")
local utils = require("hiveMind/utils")
local vector = require("hiveMind/vector")
local robot = require("robot")
local serialization = require("serialization")
local sides = require("sides")

local filesystem = component.filesystem
local navigation = component.navigation

local mapFilePath = "data/map"

local map = { data = {} }

function vectorToMapKey(vector)
    utils.error.checkIsVector(vector, "map.vectorToMapKey")

	return vector.x .. "," .. vector.y .. "," .. vector.z
end

function map.load()
    map.data = {}
    local fd = io.open(mapFilePath, "r")
    if fd == nil then return end

    while true do
        local line = fd:read()
        if line == nil then break end
        map.data[line] = true
    end

    fd:close()
end

function map.save()
    local fd, fullPath = io.open(mapFilePath, "w")
    if fd == nil then error("map.save: Can't open map file ("..fullPath..")") end

    for key, isBlock in pairs(map.data) do
        if isBlock then
            fd:write(key, "\n")
        end
    end
    fd:close()
end

function map.isEmptyBlock(vector)
    utils.error.checkIsVector(vector, "map.isEmptyBlock")

    return map.data[vectorToMapKey(vector)] == nil or map.data[vectorToMapKey(vector)] == false
end

function map.scan()
    local position = vector(navigation.getPosition()) - vector(0.5, 0.5, 0.5)
    local direction = navigation.getFacing()

    local _, description = robot.detect()
    map.registerBlock(position + utils.sideToVector(direction), description ~= "air" and description ~= "entity")

    local _, description = robot.detectUp()
    map.registerBlock(position + utils.sideToVector(sides.up), description ~= "air" and description ~= "entity")

    local _, description = robot.detectDown()
    map.registerBlock(position + utils.sideToVector(sides.down), description ~= "air" and description ~= "entity")
end

function map.registerBlock(position, isBlock)
    map.data[vectorToMapKey(position)] = isBlock
end

return map
