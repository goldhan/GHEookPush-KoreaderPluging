local iconv = require "iconv"
local mp = assert(require"lib.mimeparse")
local tool = {}
function tool.parseMime( mineStr )
    return mp.best_match({"application/octet-stream"}, mineStr)
end
return tool