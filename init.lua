local shell = require("shell")

local repositoryUrl = "https://raw.githubusercontent.com/Lelong-vincent/OC-Hive-Mind/master/"
local libFolder = "hiveMind/"

local folders = {
    "data",
    "lib",
}

local files = {
    "lib/map.lua",
    "lib/utils.lua",
    "lib/vector.lua",
}

for _, folder in ipairs(folders) do
    shell.execute("mkdir " .. folder)
end

for _, file in ipairs(files) do
    shell.execute("wget -f " .. repositoryUrl .. file ..  " " .. file)
end

shell.execute("rm -rf /lib/"..libFolder)
shell.execute("mkdir /lib/"..libFolder)
shell.execute("mv -f lib/* /lib/"..libFolder)
shell.execute("rm -rf lib")
