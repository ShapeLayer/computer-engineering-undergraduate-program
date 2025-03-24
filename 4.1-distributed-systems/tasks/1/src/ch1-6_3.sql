USE distributed_systems;

CREATE TABLE products (
    prod_id CHAR(4) NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price INT NOT NULL,
    dept_no CHAR(4) NOT NULL
);
