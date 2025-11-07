local blink = require("blink.cmp")

local get_intelephense_license = function()
  local license_path = os.getenv("HOME") .. "/.config/intelephense/license.txt"
  local f = io.open(license_path, "rb")
  if not f then
    return nil
  end
  local content = f:read("*a")
  f:close()
  return string.gsub(content, "%s+", "")
end

return {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php", "blade" },
  root_markers = { "composer.json", ".git" },
  init_options = {
    licenceKey = get_intelephense_license(),
  },
  -- capabilities = vim.tbl_deep_extend(
  --     "force",
  --     {},
  --     vim.lsp.protocol.make_client_capabilities(),
  --     blink.get_lsp_capabilities()
  -- ),
}

