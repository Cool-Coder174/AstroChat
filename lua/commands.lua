-- command.lua
local M = {}

function M.show_banner()
  local banner = [[
   ______           __                 ____     __                __      
  /\  _  \         /\ \__             /\  _`\  /\ \              /\ \__   
  \ \ \L\ \    ____\ \ ,_\  _ __   ___\ \ \/_\\ \ \___      __  \ \ ,_\  
   \ \  __ \  /',__\\ \ \/ /\`'__\/ __`\ \ \/_/_\ \  _ `\  /'__`\ \ \ \/  
    \ \ \/\ \/\__, `\\ \ \_\ \ \//\ \L\ \ \ \L\ \\ \ \ \ \/\ \L\.\_\ \ \_ 
     \ \_\ \_\/\____/ \ \__\\ \_\\ \____/\ \____/ \ \_\ \_\ \__/\.\\ \__\
      \/_/\/_/\/___/   \/__/ \/_/ \/___/  \/___/   \/_/\/_/\/__/\/_/ \/__/
                                                  
     🚀 Welcome to AstroChat - Powered by GitHub Copilot! 🚀
  ]]
  vim.api.nvim_echo({{banner, "None"}}, false, {})
end

function M.setup()
  M.show_banner()

  -- Space-themed chat commands
  vim.api.nvim_create_user_command("AstroChatLaunch", function()
    vim.api.nvim_echo({{"🚀 Launching AstroChat...", "None"}}, false, {})
    require("CopilotChat").open()
  end, { desc = "Launch AstroChat window" })

  vim.api.nvim_create_user_command("AstroChatDock", function()
    vim.api.nvim_echo({{"🛰️ Docking AstroChat...", "None"}}, false, {})
    require("CopilotChat").close()
  end, { desc = "Dock (close) AstroChat window" })

  vim.api.nvim_create_user_command("AstroChatToggle", function()
    vim.api.nvim_echo({{"🔄 Toggling AstroChat...", "None"}}, false, {})
    require("CopilotChat").toggle()
  end, { desc = "Toggle AstroChat window visibility" })

  vim.api.nvim_create_user_command("AstroChatAsk", function(opts)
    vim.api.nvim_echo({{"🛸 Asking AstroCopilot: " .. opts.args, "None"}}, false, {})
    require("CopilotChat").ask(opts.args)
  end, { nargs = '+', desc = "Ask AstroChat a question" })

  -- Authentication command
  vim.api.nvim_create_user_command("CopilotAuth", function()
    vim.api.nvim_echo({{"🌌 Connecting to GitHub Copilot...", "None"}}, false, {})
    vim.cmd("Copilot auth")
  end, { desc = "Authenticate to GitHub Copilot" })
end

return M
