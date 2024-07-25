# lua-resty-cache-purge

A Lua module for dynamically purging cache in Nginx, with support for custom cache paths and levels.

## Installation

To install this module, you can use the OpenResty Package Manager (opm):

```sh
opm get iakuf/lua-resty-cache-purge
```


## Usage

### Nginx Configuration

Add the following configuration to your nginx.conf file:

```nginx
http {
    lua_package_path "/path/to/lib/?.lua;;";

    server {
        listen 80;
        server_name example.com;

        location /purge {
            content_by_lua_block {
                local cache_purge = require "resty.cache_purge"
                cache_purge.set_cache_path("/cache/nginx/steamCache/depot") -- Set cache path
                cache_purge.set_levels(2, 2)  -- Set cache levels
                cache_purge.purge_cache(ngx.var.arg_key)
            }
        }
    }
}
```

### Purge Cache Request

To purge the cache, make a request like this:

```shell
curl -sv http://127.0.0.1:8083/purge?key=http/depot/394360/chunk/763094ad824fac2c4ac7d912474533eeee075dfc
```

## API

`set_cache_path(path)`
Set the base path for the cache.

`set_levels(level1, level2)`
Set the directory levels for the cache.

`purge_cache(key)`
Purge the cache for the given key

## License

MIT
