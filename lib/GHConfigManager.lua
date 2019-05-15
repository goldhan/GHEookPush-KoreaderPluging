local cjson = require "cjson"

local GHConfigManager = {
    EBookFilePath = "",
    EBookList = {},
    AccountConfig = {},
    isHaveConfig = false,
    removeList = {},
    addList = {}
}
-- config = {
--     EBookFilePath = "",
--     EBookList = {},
--     AccountConfig = {},
-- }
local configName = "config.json"
function GHConfigManager.init()
    GHConfigManager.checkConfig()
    return GHConfigManager
end

function GHConfigManager.setEBookFilePath(path)
    GHConfigManager.EBookFilePath = path
end



function GHConfigManager.compare(maillAllList)
    if GHConfigManager.isHaveConfig == false or #GHConfigManager.EBookList <= 0 then
        GHConfigManager.EBookList = maillAllList
        GHConfigManager.addList = maillAllList
        return
    end

    if #maillAllList > #GHConfigManager.EBookList then
        for k, v in pairs(maillAllList.id) do
            
        end
    else
        for k, v in pairs(GHConfigManager.EBookList.id) do

        end
    end
    
end



function GHConfigManager.checkConfig()
    local f = io.open (configName, "r")
    local t = f:read( "*all" )
    f:close()
    if nil ~= t then
        local jsonData = cjson.decode(t)
        GHConfigManager.EBookFilePath = jsonData.EBookFilePath
        GHConfigManager.EBookList = jsonData.EBookList
        GHConfigManager.AccountConfig = jsonData.AccountConfig
        GHConfigManager.isHaveConfig = true
    else
        GHConfigManager.isHaveConfig = false
    end
end

return GHConfigManager