# Setup
Installing the Dependencies

    - luarocks, lua, nginx
    - Install OpenResty (http://openresty.org/en/linux-packages.html)
    - sudo luarocks install lapis


https://leafo.net/lapis/reference/lua_getting_started.html

https://leafo.net/lapis/reference/moon_getting_started.html

install postgres, and create role `lua` with password `secret123`

run `postgres-models.sql` in postgres database to load schemas and init data

# Endpoints
category:
- post endpoint: http://localhost:8080/categories
    Body (form-data):
    `name:Clothing2`
- put endpoint: http://localhost:8080/categories
    Body (form-data):
    `name:Clothing2`
- delete endpoint: http://localhost:8080/categories/id
- get single endpoint: http://localhost:8080/categories/id
- get all endpoint: http://localhost:8080/categories

product:
- post endpoint: http://localhost:8080/products
    Body (form-data):
    `name:TV
    description:tv
    price:1000
    amount:2
    category:2`
- put endpoint: http://localhost:8080/products
    Body (form-data):
    `name:TV
    description:tv
    price:1000
    amount:2
    category:2`    
- delete endpoint: http://localhost:8080/products/id
- get single endpoint: http://localhost:8080/products/id
- get all endpoint: http://localhost:8080/products
