-- lua/mycopilot/config.lua
local M = {}

function M.setup()
  -- Setup GitHub Copilot inline suggestions
  vim.cmd [[
    " Load copilot.vim on InsertEnter
    autocmd InsertEnter * if !exists('g:copilot_no_tab_map') | let g:copilot_no_tab_map = v:true | endif
  ]]

  -- Map a key for accepting suggestions (adjust as needed)
  vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true })

  -- Setup CopilotChat using CopilotChat.nvim
  require("CopilotChat").setup({
    model = "gpt-4o",  -- change to your preferred model
    window = {
      layout = "float",
      width = 0.6,
      height = 0.7,
      border = "rounded",
      title = "Copilot Chat",
    },
    mappings = {
      submit_prompt = {
        insert = "<C-s>",
      },
      close = {
        normal = "q",
        insert = "<C-c>",
      },
      reset = {
        normal = "<C-l>",
        insert = "<C-l>",
      },
      -- You can add more custom mappings here...
    },
    -- Additional settings (temperature, sticky prompts, etc.) can be set here.
  })
end

return M

