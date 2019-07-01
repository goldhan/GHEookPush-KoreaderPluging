local GHEMailManager = require "lib.GHEMailManager"
local tool = require "lib.GHTool"
function printAllList( list )
    for k, v in pairs(list) do
        print("id:"..v.id,"name:"..v.name)
    end
end

local EMailManager = GHEMailManager.init('imap.163.com', 993, {protocol = 'tlsv1_2'})
EMailManager.login("gkebook@163.com", "hanjin117")
local list = EMailManager.loadAllMail()
printAllList(list)

-- EMailManager.downloadEBooks('book/push/',list)

EMailManager.logout()

-- local tab = {
--     1,2,3
-- }

-- print(table.concat( tab, ","))
-- require("ssl")
-- local https = require("ssl.https")
-- sudo luarocks install LuaSec

-- Content-Type: application/octet-stream
-- MIME-Version: 1.0
-- Content-Transfer-Encoding: base64
-- Content-Disposition: attachment; filename*=utf-8''%E8%A7%A3%E5%BF%A7%E6%9D%82%E8%B4%A7%E5%BA%97.epub


-- Content-Type: application/octet-stream;
--         name="78e936f5-ac18-49fc-8be2-6aef85d98d97.mobi"
-- Content-Transfer-Encoding: base64
-- Content-Disposition: attachment;
--         filename="78e936f5-ac18-49fc-8be2-6aef85d98d97.mobi"
-- local function split(str, sep)
-- 	local sep,fields = sep or ":", {}
-- 	local pattern = string.format("([^%s]+)", sep)
-- 	str:gsub(pattern, function (c) fields[#fields + 1] = c end)
-- 	return fields
-- end
-- local testStr = "Content-Type: application/octet-stream; name=\"958.mobi\" Content-Transfer-Encoding: base64 Content-Disposition: attachment; filename=\"958.mobi\""
-- -- local testStr = "Content-Type: application/octet-stream MIME-Version: 1.0 Content-Transfer-Encoding: base64 Content-Disposition: attachment; filename*=utf-8''%E8%A7%A3%E5%BF%A7%E6%9D%82%E8%B4%A7%E5%BA%97.epub"
-- local str = string.match(testStr,"filename.+[',\"](.+%.%a+)" )

-- print(str)
-- local list = split(testStr, "name")
-- for k, v in pairs(list) do
--     print(k,v)
-- end

-- print(tool.parseMime(testStr))