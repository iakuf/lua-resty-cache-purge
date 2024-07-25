
local _M = {}

local cache_base_path = "/cache/nginx/steamCache/depot"
local levels = {2, 2}

function _M.set_cache_path(path)
    cache_base_path = path
end

function _M.set_levels(level1, level2)
    levels = {level1, level2}
end

local function generate_cache_path(md5)
    local path_parts = {}
    local start = #md5 + 1

    for _, length in ipairs(levels) do
        start = start - length
        table.insert(path_parts, md5:sub(start, start + length - 1))
    end

    table.insert(path_parts, md5)
    return table.concat(path_parts, "/")
end

function _M.purge_cache(key)
    if not key then
        ngx.say("Missing key parameter")
        ngx.exit(ngx.HTTP_BAD_REQUEST)
    end

    local md5 = ngx.md5(key)
    local cache_path = string.format("%s/%s", cache_base_path, generate_cache_path(md5))

    -- 删除缓存文件
    local success, err = os.remove(cache_path)
    if not success then
        ngx.say("Failed to purge cache for: " .. key .. " Error: " .. (err or "unknown") .. " file: " .. cache_path)
        ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
    else
        ngx.status = ngx.HTTP_NO_CONTENT
        ngx.exit(ngx.HTTP_NO_CONTENT)
    end
end

return _M
 
             
             
             
 
             
             
             
 
             
             
             
             
             
             
             
             
             
