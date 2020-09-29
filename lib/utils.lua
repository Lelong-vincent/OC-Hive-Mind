local serialization = require("serialization")

local utils = {}

function utils.prettyPrint(x)
    print(serialization.serialize(x, true))
end

return utils
