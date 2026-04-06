-- disable apps

local plugins_disable = {
  "mini.pairs",
}
local specs = {}
for _, plugin in ipairs(plugins_disable) do
  table.insert(specs, { plugin, enabled = false })
end

return specs
