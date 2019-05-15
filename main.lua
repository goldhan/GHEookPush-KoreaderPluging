local GHEMailManager = require "lib.GHEMailManager"

function printAllList( list )
    for k, v in pairs(list) do
        print("id:"..v.id,"name:"..v.name)
    end
end

local EMailManager = GHEMailManager.init('imap.163.com', 993, {protocol = 'tlsv1_2'})
EMailManager.login("gkebook@163.com", "xxxxxx")
local list = EMailManager.loadAllMail()
printAllList(list)

EMailManager.downloadEBooks('book/push/',list)

EMailManager.logout()

-- local tab = {
--     1,2,3
-- }

-- print(table.concat( tab, ","))
-- require("ssl")
-- local https = require("ssl.https")
-- sudo luarocks install LuaSec