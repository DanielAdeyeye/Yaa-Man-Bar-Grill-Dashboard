-- ===================================================================
-- Yaa Man Bar & Grill — Star Schema
-- Grain of fact_sales_line: one row per item ordered per order
-- (an order can contain multiple lines, e.g. order 10006 = 3x dessert)
-- ===================================================================

-- ---------- DIMENSION TABLES ----------

CREATE TABLE dim_date (
    date_key      INTEGER PRIMARY KEY,
    date          DATE NOT NULL,
    day_name      VARCHAR(10) NOT NULL,
    month_name    VARCHAR(10) NOT NULL,
    month_number  INTEGER NOT NULL,
    quarter       INTEGER NOT NULL,
    year          INTEGER NOT NULL,
    is_weekend    BOOLEAN NOT NULL
);

CREATE TABLE dim_item (
    item_key      INTEGER PRIMARY KEY,
    item_name     VARCHAR(100) NOT NULL,
    category      VARCHAR(50) NOT NULL
);

CREATE TABLE dim_server (
    server_key    INTEGER PRIMARY KEY,
    server        VARCHAR(50) NOT NULL
);

CREATE TABLE dim_payment_method (
    payment_method_key INTEGER PRIMARY KEY,
    payment_method      VARCHAR(30) NOT NULL
);

CREATE TABLE dim_channel (
    channel_key   INTEGER PRIMARY KEY,
    channel       VARCHAR(30) NOT NULL
);

-- ---------- FACT TABLE ----------

CREATE TABLE fact_sales_line (
    sales_line_id       INTEGER PRIMARY KEY,   -- surrogate key, one per order line
    order_id            INTEGER NOT NULL,      -- degenerate dimension (no attributes of its own)
    date_key            INTEGER NOT NULL REFERENCES dim_date(date_key),
    item_key            INTEGER NOT NULL REFERENCES dim_item(item_key),
    server_key          INTEGER NOT NULL REFERENCES dim_server(server_key),
    payment_method_key  INTEGER NOT NULL REFERENCES dim_payment_method(payment_method_key),
    channel_key          INTEGER NOT NULL REFERENCES dim_channel(channel_key),
    table_number        INTEGER,               -- kept as a fact attribute, not its own dimension
                                                 -- (no descriptive attributes beyond the number itself)
    quantity             INTEGER NOT NULL,
    unit_price           DECIMAL(6,2) NOT NULL, -- kept on the fact: price varies over time for the
                                                 -- same item, so it belongs with the transaction,
                                                 -- not as a static attribute of dim_item
    sales_amount          DECIMAL(8,2) NOT NULL  -- quantity * unit_price, stored pre-calculated
);
