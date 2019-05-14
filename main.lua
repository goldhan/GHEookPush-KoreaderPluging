local GHEMailManager = require "lib.GHEMailManager"

local EMailManager = GHEMailManager:init('imap.163.com', 143)
EMailManager:login("gkebook@163.com", "xxxxxx")
EMailManager:loadAllMail()
EMailManager:logout()