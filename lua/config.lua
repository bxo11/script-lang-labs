-- config.lua
local config = require("lapis.config")
config("development", {
  postgres = {
    host = "127.0.0.1",
    user = "lua",
    password = "secret123",
    database = "postgres"
  }
})