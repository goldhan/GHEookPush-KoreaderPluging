local imap4 = require 'imap4'

-- EBookList_All = {
--     {id=1,name=""},
--     {id=2,name=""},
--     {id=3,name=""},
-- }

local function split(str, sep)
		local sep,fields = sep or ":", {}
		local pattern = string.format("([^%s]+)", sep)
		str:gsub(pattern, function (c) fields[#fields + 1] = c end)
		return fields
end

local function urlDecode(s)
    s = string.gsub(s, '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
    return s
end

local function trim(s)
	return (string.gsub(s, "^%s*(.-)%s*$", "%1")) 
end


local GHEMailManager = {
    imapHost = "",
    imapPort = 143,
    connection = {},
    tls_params = {},
    EBookList_All = {}
}

function GHEMailManager:init(host, port, tls_params)
    GHEMailManager.imapHost = host
    GHEMailManager.imapPort = port
    GHEMailManager.tls_params = tls_params
    GHEMailManager.connection = imap4(host, port, tls_params)
    assert(GHEMailManager.connection:isCapable('IMAP4rev1'))
    self.__index = self;
    return self
end


function GHEMailManager:login(username, password)
    GHEMailManager.connection:login(username, password)
    GHEMailManager.connection:examine('INBOX')
end

function GHEMailManager:logout()
    GHEMailManager.connection:logout()
end

function GHEMailManager:loadAllMail()
for _,v in pairs(GHEMailManager.connection:fetch('(UID BODY[2.MIME])')) do
if v.BODY.value ~= "NIL" then
    local str = trim(v.BODY.value)
	local list = split(str, '\'\'')
	local fileName = list[#list]
local date = {id=v.id, name=urlDecode(fileName)}
table.insert(GHEMailManager.EBookList_All,date)
end

end

for k, v in pairs(GHEMailManager.EBookList_All) do
    print(k,v.name)
end
end

return GHEMailManager