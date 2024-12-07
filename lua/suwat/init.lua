local suwat = {}

-- load submodules
suwat.commads = require("suwat.commands")
suwat.mappings = require("suwat.mappings")

-- initialize the plugin
suwat.setup = function()
    suwat.commads.setup()
    suwat.mappings.setup()
end

return suwat
