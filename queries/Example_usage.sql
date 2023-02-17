-- Getting all available books from database with category/categories, publisher(s) and author(s)

SELECT t1.title, t2.firstname as author_firstname, t2.lastname as author_lastname, t3.title as category, t4.publisher_name as publisher, (SELECT COUNT(*) as available_for_loan FROM copy WHERE t1.id = copy.book_id AND copy.is_available = true) 
FROM book t1 
JOIN book_author_map author_map ON t1.id = author_map.book_id
JOIN author t2 ON t2.id = author_map.author_id
JOIN book_category_map category_map ON t1.id = category_map.book_id
JOIN category t3 ON t3.id = category_map.category_id
JOIN book_publisher_map publisher_map ON t1.id = publisher_map.book_id
JOIN publisher t4 ON t4.id = publisher_map.publisher_id;

-- Getting single book (param @id = 1)

SELECT t1.title, t2.firstname, t2.lastname, t3.title, (SELECT COUNT(*) as available_for_loan FROM copy WHERE t1.id = copy.book_id AND copy.is_available = true) 
FROM book t1 
JOIN book_author_map author_map ON t1.id = author_map.book_id
JOIN author t2 ON t2.id = author_map.author_id
JOIN book_category_map category_map ON t1.id = category_map.book_id
JOIN category t3 ON t3.id = category_map.category_id
WHERE t1.id = 1; -- Here replace 1 with @id

-- Get a first available copy for loan using book id(param @book_id = 5)

SELECT id 
FROM copy
WHERE book_id = 5 --use parameter @book_id in place of 5
AND copy.is_available = true
LIMIT 1;

-- Reservation process, this will require a few queries since we have cart functionality planned. Copies will be set to not available if user has them in his/hers cart

-- 1. Adding items to cart use first available copy query or send @copy_id straight from app.

INSERT INTO cart_item(user_id, copy_id) 
VALUES (@user_id, @copy_id);

-- 2. change availablity of copy/copies

UPDATE copy SET is_available = false WHERE id = @copy_id;

-- 3. If user chooses to make loans for all the items in cart you query the cart_item table first to get all the copies for loaning. (param @user_id)

SELECT user_id, copy_id FROM copy WHERE user_id = @user_id;

-- 4. Making a reservation(s). (params @copy_id, @user_id)

INSERT INTO reservation(user_id, copy_id)
VALUES (@user_id, @copy_id);

-- 5. After reservations remove items from cart since they have been made to reservations.

DELETE FROM cart_item WHERE copy_id = @copy_id;

-- Returning a reservation. This requires two queries first to set returned = true and then changing the copy/copies availability to true

UPDATE reservation SET returned = true WHERE copy_id = @copy_id;
UPDATE copy SET is_available = true WHERE id = @copy_id;
