-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Helper function to merge tables
local function merge_tables(...)
  local merged = {}
  for _, t in ipairs({...}) do
    for k, v in pairs(t) do
      merged[k] = v
    end
  end
  return merged
end

local config = {}
merge_tables(config, require('wezterm_general'))
merge_tables(config, require('wezterm_osspecific'))

return config
