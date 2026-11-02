CREATE OR REPLACE VIEW orders AS
SELECT *
FROM read_csv_auto('data/olist_orders_dataset.csv');

CREATE OR REPLACE VIEW customers AS
SELECT *
FROM read_csv_auto('data/olist_customers_dataset.csv');

CREATE OR REPLACE VIEW order_items AS
SELECT *
FROM read_csv_auto('data/olist_order_items_dataset.csv');

CREATE OR REPLACE VIEW sellers AS
SELECT *
FROM read_csv_auto('data/olist_sellers_dataset.csv');

