local imap4 = require 'lib.imap4'

-- EBookList_All = {
--     ["1"]={id=1,name=""},
--     ["33"]={id=2,name=""},
--     ["2"]={id=3,name=""},
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

function GHEMailManager.init(host, port, tls_params)
    GHEMailManager.imapHost = host
    GHEMailManager.imapPort = port
    GHEMailManager.tls_params = tls_params
    GHEMailManager.connection = imap4(host, port, tls_params)
    assert(GHEMailManager.connection:isCapable('IMAP4rev1'))
    return GHEMailManager
end


function GHEMailManager.login(username, password)
    GHEMailManager.connection:login(username, password)
    GHEMailManager.connection:examine('INBOX')
end

function GHEMailManager.logout()
    GHEMailManager.connection:logout()
end

function GHEMailManager.loadAllMail()
    for _,v in pairs(GHEMailManager.connection:fetch('(UID BODY[2.MIME])')) do
        if v.BODY.value ~= "NIL" then
            local fileName = string.match(v.BODY.value,"filename.+[',\"](.+%.%a+)" )
            if fileName then
                local date = {id=v.id, name= urlDecode(fileName)}
                GHEMailManager.EBookList_All[v.id] = date
            end
        end
    end
    -- for _,v in pairs(GHEMailManager.connection:_do_cmd("FETCH 1 BODY.PEEK[2.MIME]")) do

    --     for x, y in pairs(v) do
    --         print(y)
    --     end
    --     -- if v.BODY.value ~= "NIL" then
    --     --     local str = trim(v.BODY.value)
    --     --     local list = split(str, '\'\'')
    --     --     local fileName = list[#list]
    --     --     local date = {id=v.id, name=urlDecode(fileName)}
    --     --     table.insert(GHEMailManager.EBookList_All,date)
    --     -- end
    -- end
    return GHEMailManager.EBookList_All
end

function GHEMailManager.downloadEBooks(Path, EBookList)
    local ids = {}
    for _, v in pairs(EBookList) do
        table.insert(ids,v.id)
    end
    local mime = require  "mime"
    for _,v in pairs(GHEMailManager.connection:fetch('(UID BODY[2])',table.concat(ids, ","))) do
        if v.BODY.value ~= "NIL" then
            local gFile = io.open(EBookList[v.id].name,"w+");
            local data = mime.unb64(v.BODY.value)
            gFile:write(data)
            gFile:close()
        end
    end
end


return GHEMailManager