.read data.sql


CREATE TABLE average_prices AS
  SELECT category, AVG(MSRP) AS average_price FROM products GROUP BY category;


CREATE TABLE lowest_prices AS
  SELECT store, item, MIN(price) AS price FROM inventory GROUP BY item;


CREATE TABLE best_items AS
  SELECT name, MIN(MSRP / rating) FROM products GROUP BY category;

CREATE TABLE shopping_list AS
  SELECT name, store FROM best_items, lowest_prices WHERE name = item;


CREATE TABLE total_bandwidth AS
  SELECT SUM(Mbs) FROM shopping_list, stores WHERE shopping_list.store = stores.store;

