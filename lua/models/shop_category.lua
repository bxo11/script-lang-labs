local lapis = require("lapis")
local db = require("lapis.db")
local Model
Model = require("lapis.db.model").Model

local ShopCategory = Model:extend("shop_category")

return ShopCategory
