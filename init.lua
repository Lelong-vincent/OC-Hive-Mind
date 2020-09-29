local repositoryUrl = "https://raw.githubusercontent.com/Lelong-vincent/OC-Hive-Mind/master/"

local shell = require("shell")

local folders = {
}

local files = {
}

for _, folder in ipairs(folders) do
    shell.execute("mkdir " .. folder)
end

for _, file in ipairs(files) do
    shell.execute("wget " .. repositoryUrl .. file ..  " " .. file)
end