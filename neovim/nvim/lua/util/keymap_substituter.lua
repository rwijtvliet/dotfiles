local M = {}
-- lua/util/keymap_substituter.lua

local function norm(lhs)
  return string.lower(lhs or "")
end

-- keys: LazyVim-style keymap table
-- subs: e.g. { ["<A-n>"] = "]r" }
function M.apply(keys, subs)
  if not keys then
    return {}
  end

  local new = {}
  local subs_norm = {}

  -- normalize substitution keys
  for old, newlhs in pairs(subs) do
    subs_norm[norm(old)] = newlhs
  end

  for _, k in ipairs(keys) do
    local lhs = k[1]
    local lhs_norm = norm(lhs)

    local replacement = subs_norm[lhs_norm]

    if replacement == nil then
      -- not in substitution table → keep as-is
      table.insert(new, k)
    else
      -- substitution → clone entry but replace lhs
      local clone = vim.deepcopy(k)
      clone[1] = replacement
      table.insert(new, clone)
    end
  end

  return new
end

return M
