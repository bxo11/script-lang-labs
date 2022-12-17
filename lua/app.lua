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
  if not category then
    return { json = { error = "Category not found" } }
  end
  category:delete()
  return { json = { message = "Category deleted successfully" } }
end)

app:put("/categories/:id", function(self)
  local category_id = self.params.id
  local category = ShopCategory:find(category_id)
  if not category then
    return { json = { error = "Category not found" } }
  end
  local new_name = self.params.name
  if not new_name then
    return { json = { error = "Name is required" } }
  end
  category.name = new_name
  category:update("name")
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

app:delete("/products/:id", function(self)
  local product_id = self.params.id
  local product = ShopProduct:find(product_id)
  if not product then
    return { json = { error = "Product not found" } }
  end
  product:delete()
  return { json = { message = "Product deleted successfully" } }
end)

app:post("/products", function(self)
  local required_fields = Set { "name", "description", "price", "category", "amount" }
  local data = {}
  for key, value in pairs(self.params) do
    if not required_fields[key] then
      return { json = { message = "Wrong param name" } }
    else
      data[key] = value
    end
  end
  if not tables_have_same_keys(data, required_fields) then
    return { json = { message = "Missing param" } }
  end

  local product = ShopProduct:create(data)
  return { json = product }
end)

app:put("/products/:id", function(self)
  local product_id = self.params.id
  local product = ShopProduct:find(product_id)
  if not product then
    return { json = { error = "Product not found" } }
  end

  product:update(self.params)
  return { json = { message = "Product updated successfully" } }
end)

function Set(list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

function tables_have_same_keys(table_a, table_b)
  for key, _ in pairs(table_b) do
    if not table_a[key] then
      return false
    end
  end
  return true
end

return app
