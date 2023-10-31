local Util = require("util")
local Config = require("config")

---@class lazyvim.util.json
local M = {}

--- Encodes a Lua table to a JSON string.
---@param value any
---@return string
local function encode(value)
  if value == nil then
    return "null"
  elseif type(value) == "string" then
    return '"' .. value:gsub('"', '\\"') .. '"'
  elseif type(value) == "number" or type(value) == "boolean" then
    return tostring(value)
  elseif type(value) == "table" then
    local parts = {}
    for k, v in pairs(value) do
      table.insert(parts, encode(k) .. ":" .. encode(v))
    end
    return "{" .. table.concat(parts, ",") .. "}"
  end
end

--- Saves the JSON data to a file.
function M.save()
  local jsonData = {
    version = Config.json.version,
    colorscheme = Config.json.colorscheme,
    extras = Config.json.extras,
  }

  local jsonText = encode(jsonData)
  local path = vim.fn.stdpath("config") .. "/kicknv.json"
  local f = io.open(path, "w")
  if f then
    f:write(jsonText)
    f:close()
  end
end

--- Migrates JSON data to the current version.
function M.migrate()
  -- Util.info("Migrating `kicknv.json` to version `" .. Config.json.version .. "`")
  print("Migrating `kicknv.json` to version `" .. Config.json.version .. "`")
  -- Util.info("Migrating `kicknv.json` to version `" .. Config.json.version .. "`")
  print("Migrating `kicknv.json` to version `" .. Config.json.version .. "`")

  local json = Config.json.data

  if not json.version then
    json.new_field = "default_value"
  elseif json.version == 1 then
    json.new_name = json.old_name
    json.old_name = nil
  end

  json.version = Config.json.version
  M.save()
end

return M
