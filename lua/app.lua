local lapis = require("lapis")
local app = lapis.Application()
local ShopCategory = require("models.shop_category")
local ShopProduct = require("models.shop_product")

app:get("/categories", function(self)
  local categories = ShopCategory:select("order by id")
  return { json = categories }
end)

app:get("/categories/:id", function(self)
  local category_id = self.params.id
  local category = ShopCategory:find(category_id)
  if not category then
    return { json = { error = "Category not found" } }
  end
  return { json = category }
end)

app:post("/categories", function(self)
  local category_name = self.params.name
  if not category_name then
    return { json = { error = "Name is required" } }
  end
  local data = { name = category_name }
  local category = ShopCategory:create(data)
  return { json = category }
end)

app:delete("/categories/:id", function(self)
  local category_id = self.params.id
  local category = ShopCategory:find(category_id)
cc  if not category then
    return { json = { error = "Category not found" } }
  end
  category:delete() -- Delete the category from the database
  return { json = { message = "Category deleted successfully" } }
end)

app:put("/categories/:id", function(self)
  local category_id = self.params.id
  local category = ShopCategory:find(category_id)
  if not category then
    return { json = { error = "Category not found" } }
  end
  local new_name = self.params.name -- Get the new name from the request parameters
  if not new_name then
    return { json = { error = "Name is required" } }
  end
  category.name = new_name -- Update the name of the category
  category:update("name") -- Save the changes to the database
  return { json = { message = "Category updated successfully" } }
end)

--
-- PRODUCTS
--

app:get("/products", function(self)
  local products = ShopProduct:select("order by id")
  return { json = products }
end)
app:get("/products/:id", function(self)
  local product_id = self.params.id
  local product = ShopProduct:find(product_id)
  if not product then
    return { json = { error = "Product not found" } }
  end
  return { json = product }
end)


return app
