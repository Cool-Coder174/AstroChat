-- lua/mycopilot/init.lua
local config = require("astrochat.config")
local commands = require("astrochat.commands")

config.setup()
commands.setup()

-- Expose module functions (if needed)
return {
  config = config,
  commands = commands,
}

