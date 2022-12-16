local lapis = require("lapis")
local db = require("lapis.db")
local Model
Model = require("lapis.db.model").Model

local ShopProduct = Model:extend("shop_product")

return ShopProduct
