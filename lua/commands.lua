local http = require("http.client")  -- Because making HTTP requests with your bare hands is so last century.
local json = require("dkjson")  -- JSON: The universal data format that everyone loves to hate.
local M = {}

-- The sacred path to our precious config file.
local config_file = vim.fn.stdpath('config') .. '/astrochat_config.json'

-- Function to read the config file. Because who doesn't love reading files?
local function read_config()
  local file = io.open(config_file, "r")
  if file then
    local content = file:read("*a")  -- Read the whole file. Because why not?
    file:close()
    return json.decode(content)  -- Decode the JSON. Let's hope it's not a mess.
  end
  return nil  -- No file, no config. No config, no fun.
end

-- Function to write the config file. Because saving your work is important, kids.
local function write_config(config)
  local file = io.open(config_file, "w")
  if file then
    file:write(json.encode(config))  -- Encode the config as JSON. Because plain text is for amateurs.
    file:close()
  end
end

-- Function to prompt the user for their GitHub token and API endpoint.
-- Because we can't read minds. Yet.
local function prompt_user_for_info()
  local token = vim.fn.input("Enter your GitHub token: ")  -- Enter your token. No, not that kind of token.
  local endpoint = vim.fn.input("Enter the GitHub API endpoint: ")  -- Enter the endpoint. No, not that kind of endpoint.
  local config = {
    token = token,
    endpoint = endpoint
  }
  write_config(config)  -- Save the config. Because losing it would be tragic.
  return config
end

-- Function to show a banner. Because every good plugin needs a banner.
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
  vim.api.nvim_echo({{banner, "None"}}, false, {})  -- Show the banner. Because why not?
end

-- Function to make an API call. Because talking to servers is fun.
function M.make_api_call()
  local config = read_config()  -- Read the config. Because we need it.
  if not config then
    config = prompt_user_for_info()  -- Prompt the user for info. Because we can't proceed without it.
  end

  local url = config.endpoint  -- The endpoint. Because every API call needs one.
  local headers = {
    ["Authorization"] = "Bearer " .. config.token,  -- The token. Because security is important.
    ["Content-Type"] = "application/json",  -- JSON. Because XML is so 2000s.
  }
  local body = '{"query": "your query"}'  -- The body. Because empty requests are boring.

  local res, err = http.request("POST", url, {
    headers = headers,
    body = body,
  })

  if err then
    vim.api.nvim_err_writeln("API call failed: " .. err)  -- Error handling. Because things go wrong.
  else
    vim.api.nvim_echo({{"API call succeeded: " .. res.body, "None"}}, false, {})  -- Success message. Because we like good news.
  end
end

-- Function to set up the plugin. Because initialization is key.
function M.setup()
  M.show_banner()  -- Show the banner. Because first impressions matter.

  -- Space-themed chat commands. Because space is cool.
  vim.api.nvim_create_user_command("AstroChatLaunch", function()
    vim.api.nvim_echo({{"🚀 Launching AstroChat...", "None"}}, false, {})
    require("CopilotChat").open()
  end, { desc = "Launch AstroChat window" })

  vim.api.nvim_create_user_command("AstroChatDock", function()
    vim.api.nvim_echo({{"🛰️ Docking AstroChat...", "None"}}, false, {})
    require("CopilotChat").close()
  end, { desc = "Dock (close) AstroChat window" })

  vim.api.nvim_create_user_command("AstroChatSetInfo", function()
    prompt_user_for_info()
    vim.api.nvim_echo({{"🔧 Configuration saved.", "None"}}, false, {})
  end, { desc = "Set GitHub token and API endpoint" })

  vim.api.nvim_create_user_command("AstroChatLogout", function()
    os.remove(config_file)
    vim.api.nvim_echo({{"🔒 Logged out and configuration deleted.", "None"}}, false, {})
  end, { desc = "Logout and delete configuration" })

  vim.api.nvim_create_user_command("AstroChatApiCall", function()
    M.make_api_call()
  end, { desc = "Make an API call to GitHub Copilot" })
end

return M  -- Return the module. Because Lua modules are cool.