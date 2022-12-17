CREATE TABLE shop_category (
   id serial PRIMARY KEY,
   name text NOT NULL
);

CREATE TABLE shop_product (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    price NUMERIC(10,2) NOT NULL,
    category integer REFERENCES shop_category(id) ON DELETE CASCADE,
    amount INTEGER NOT NULL
);


INSERT INTO shop_category (name)
VALUES ('Clothing'), ('Electronics'), ('Home Goods');

INSERT INTO shop_product (name, description, price, category, amount)
VALUES 
('T-shirt', 'A soft, comfortable t-shirt', 19.99, 1, 50),
('Laptop', 'A powerful laptop for all your computing needs', 799.99, 2, 25),
('Blender', 'A high-quality blender for smoothies and more', 99.99, 3, 35),
('Jeans', 'A pair of classic blue jeans', 59.99, 1, 40),
('Smartphone', 'A sleek smartphone with the latest features', 499.99, 2, 30),
('Couch', 'A comfortable couch for your living room', 299.99, 3, 15),
('Sweater', 'A warm, cozy sweater', 39.99, 1, 45),
('Tablet', 'A portable tablet for on-the-go entertainment', 349.99, 2, 20),
('Microwave', 'A reliable microwave for all your cooking needs', 49.99, 3, 30),
('Dress', 'A stylish dress for any occasion', 79.99, 1, 35);
