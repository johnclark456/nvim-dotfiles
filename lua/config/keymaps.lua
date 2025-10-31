-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- lua/config/keymaps.lua
local map = vim.keymap.set

-- Function to add or update include guards in C headers
local function add_or_update_include_guard()
  local filename = vim.fn.expand("%:t")
  local ext = vim.fn.expand("%:e")

  if ext ~= "h" and ext ~= "hpp" then
    vim.notify("Not a header file", vim.log.levels.WARN)
    return
  end

  local guard = filename:upper():gsub("[^A-Z0-9]", "_") .. "_"
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local found_ifndef, found_define = nil, nil

  for i, line in ipairs(lines) do
    if line:match("^#ifndef") then
      found_ifndef = i
    end
    if line:match("^#define") then
      found_define = i
    end
  end

  -- Remove old guard lines if found
  if found_ifndef and found_define then
    table.remove(lines, found_define)
    table.remove(lines, found_ifndef)
  end

  -- Remove existing #endif guard at end if present
  if #lines > 0 and lines[#lines]:match("^#endif") then
    table.remove(lines)
  end

  -- Insert new include guard
  table.insert(lines, 1, "#define " .. guard)
  table.insert(lines, 1, "#ifndef " .. guard)
  table.insert(lines, "#endif /* " .. guard .. " */")

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.notify("Include guard added: " .. guard, vim.log.levels.INFO)
end

-- Keymap: <leader>ig to add/update include guard
map("n", "<leader>ig", add_or_update_include_guard, { desc = "Add or update C include guard" })
