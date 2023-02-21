DROP DATABASE IF EXISTS library;
CREATE DATABASE library;

\c library 

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TABLE role (
    id SERIAL PRIMARY KEY,
    user_role VARCHAR(50) NOT NULL
);
CREATE TABLE "user"(
    id uuid PRIMARY KEY DEFAULT uuid_generate_v1(),
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    role_id INT REFERENCES role(id)
);
CREATE TABLE book(
    id SERIAL PRIMARY KEY,
    title varchar(50) NOT NULL
);
CREATE TABLE author(
    id SERIAL PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL
);
CREATE TABLE category(
    id SERIAL PRIMARY KEY,
    title VARCHAR(50) NOT NULL
);
CREATE TABLE publisher(
    id serial PRIMARY KEY,
    publisher_name VARCHAR(50)
);
CREATE TABLE review(
    id SERIAL PRIMARY KEY,
    book_id INT REFERENCES book(id) ON DELETE CASCADE,
    review TEXT NOT NULL
);
CREATE TABLE book_publisher_map(
    id SERIAL PRIMARY KEY,
    book_id INT REFERENCES book(id) ON DELETE CASCADE,
    publisher_id INT REFERENCES publisher(id) ON DELETE CASCADE
);
CREATE TABLE book_author_map(
    book_id INT REFERENCES book(id) ON DELETE CASCADE,
    author_id INT REFERENCES author(id) ON DELETE CASCADE,
    PRIMARY KEY(book_id, author_id)
);
CREATE TABLE book_category_map(
    book_id INT REFERENCES book(id) ON DELETE CASCADE,
    category_id INT REFERENCES category(id) ON DELETE CASCADE,
    PRIMARY KEY (book_id, category_id)
);
CREATE TABLE copy(
    id SERIAL PRIMARY KEY,
    book_id INT REFERENCES book(id) ON DELETE CASCADE,
    is_available BOOLEAN DEFAULT true
);
CREATE TABLE cart_item(
    user_id uuid REFERENCES "user"(id) ON DELETE CASCADE,
    copy_id INT REFERENCES copy(id) ON DELETE CASCADE,
    PRIMARY KEY(user_id, copy_id)
);
CREATE TABLE reservation(
    id uuid PRIMARY KEY DEFAULT uuid_generate_v1(),
    user_id uuid REFERENCES "user"(id) ON DELETE CASCADE,
    copy_id INT UNIQUE REFERENCES copy(id) ON DELETE CASCADE,
    reserved_at DATE DEFAULT NOW(),
    due_date DATE DEFAULT NOW() + INTERVAL '1 month',
    returned BOOLEAN DEFAULT false
);
