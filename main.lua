local GHEMailManager = require "lib.GHEMailManager"

local EMailManager = GHEMailManager:init('imap.163.com', 993, {protocol = 'tlsv1_2'})

EMailManager:login("gkebook@163.com", "xxxxxx")
EMailManager:loadAllMail()
EMailManager:logout()

-- require("ssl")
-- local https = require("ssl.https")
-- sudo luarocks install LuaSec