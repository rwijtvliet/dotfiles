-- Substitute keymaps of the plugins set by lazyvim.
-- Lazyvim keymaps are found here: https://www.lazyvim.org/keymaps

local substitute = require("util.keymap_substituter")

local plugin_substitutions = {
  ["mini.pairs"] = false,
  ["saghen/blink.cmp"] = { ["<C-p>"] = "<C-t>" },
}

local specs = {}
for plugin, subs in pairs(plugin_substitutions) do
  if subs == false then
    table.insert(specs, { plugin, enabled = false })
  else
    table.insert(specs, {
      import = plugin,
      keys = function(_, keys)
        return substitute.apply(keys, subs)
      end,
    })
  end
end

return specs
