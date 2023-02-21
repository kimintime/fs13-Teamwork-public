-- Check users
SELECT t1.id, t1.firstname, t1.lastname, t1.password, t2.user_role FROM "user" t1 JOIN role t2 ON t1.role_id = t2.id; 

-- Getting all available books from database with category/categories, publisher(s) and author(s)
-- example result using this query => demo_pics / get_all_books_with_info

SELECT t1.id as book_id, t1.title, t2.firstname || ' ' || t2.lastname as author, t3.title as category, t4.publisher_name as publisher, (SELECT COUNT(*) as available_for_loan FROM copy WHERE t1.id = copy.book_id AND copy.is_available = true) 
FROM book t1 
JOIN book_author_map author_map ON t1.id = author_map.book_id
JOIN author t2 ON t2.id = author_map.author_id
JOIN book_category_map category_map ON t1.id = category_map.book_id
JOIN category t3 ON t3.id = category_map.category_id
JOIN book_publisher_map publisher_map ON t1.id = publisher_map.book_id
JOIN publisher t4 ON t4.id = publisher_map.publisher_id;

-- Getting single book (param @id = 1)
-- example result => demo_pics / get_single_books_with_info //result has a book with two categories

SELECT t1.title, t2.firstname as author_firstname, t2.lastname as author_lastname, t3.title as category, (SELECT COUNT(*) as available_for_loan FROM copy WHERE t1.id = copy.book_id AND copy.is_available = true) 
FROM book t1 
JOIN book_author_map author_map ON t1.id = author_map.book_id
JOIN author t2 ON t2.id = author_map.author_id
JOIN book_category_map category_map ON t1.id = category_map.book_id
JOIN category t3 ON t3.id = category_map.category_id
WHERE t1.id = 1; -- Here replace 1 with @id

-- Get a first available copy for loan using book id(param @book_id = 5)

SELECT id 
FROM copy
WHERE book_id = 6
AND copy.is_available = true
LIMIT 1;

-- Reservation process, this will require a few queries since we have cart functionality planned. Copies will be set to not available if user has them in his/hers cart

-- 1. Adding items to cart use first available copy query or send @copy_id straight from app.

INSERT INTO cart_item(user_id, copy_id) 
VALUES (@user_id, @copy_id);

-- 2. change availablity of copy/copies

UPDATE copy SET is_available = false WHERE id = @copy_id;
--example results =>  demo_pics / add_items_to_cart 

-- Get cart with info (param @user_id)
-- example result => demo_pics / get_cart_info
SELECT t3.title as book, copy.id as copy_id FROM cart_item t1
JOIN "user" t2 ON t1.user_id = t2.id
JOIN copy ON copy.id = t1.copy_id
JOIN book t3 ON copy.book_id = t3.id
WHERE t2.id = @user_id;

-- 3. If user chooses to make loans for all the items in cart you query the cart_item table first to get all the copies for loaning. (param @user_id)

SELECT user_id, copy_id FROM copy WHERE user_id = @user_id;

-- 4. Making a reservation(s). (params @copy_id, @user_id)
-- example result => demo_pics / making_reservations

INSERT INTO reservation(user_id, copy_id)
VALUES (@user_id, @copy_id);

-- 5. After reservations remove items from cart since they have been made to reservations.

DELETE FROM cart_item WHERE copy_id = @copy_id;

-- Returning a reservation. This requires two queries first to set returned = true and then changing the copy/copies availability to true

UPDATE reservation SET returned = true WHERE copy_id = @copy_id;
UPDATE copy SET is_available = true WHERE id = @copy_id;

-- Check for reservations not returned on time. Requires a current date as parameter in form = YYYY-MM-DD in javascript you get it like this new Date(Date.now()).ToISOString()
SELECT t3.firstname, t3.lastname, t4.title as book, t2.id as copy_id, t1.reserved_at, t1.due_date 
FROM reservation t1
JOIN copy t2 ON t1.copy_id = t2.id
JOIN "user" t3 ON t1.user_id = t3.id
JOIN book t4 ON t2.book_id = t4.id
WHERE due_date < @date AND returned = 'false';

-- Check reservations with book titles and user first and last names

SELECT t3.firstname, t3.lastname, t4.title as book, t2.id as copy_id, t1.reserved_at, t1.due_date 
FROM reservation t1
JOIN copy t2 ON t1.copy_id = t2.id
JOIN "user" t3 ON t1.user_id = t3.id
JOIN book t4 ON t2.book_id = t4.id;

-- Read book reviews for books that have reviews ---

SELECT * FROM book JOIN review ON book.id = review.book_id;

-- Read book reviews for a specific book. Book id needs to be added manually ---

SELECT * FROM book JOIN review ON book.id = review.book_id WHERE book.id = @id;
