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

general_config = require('wezterm_general')
specific_config = require('wezterm_osspecific')
return merge_tables({}, general_config, specific_config)
