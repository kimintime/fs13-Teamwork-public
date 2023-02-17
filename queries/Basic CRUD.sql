--These queries will most likely not work because the id's for the mapping tables will have to match and be unique. But these can be used as a base.
--Working CREATE examples are in => Insert_dummy_data.sql
--More specific use cases in => Example_usage.sql

--CREATE

--book, category, author

--insert book title
INSERT INTO book(title) VALUES('Your book title here');

--If category, author or publisher already exists this step can be skipped
INSERT INTO author(author_firstname, author_lastname) VALUES('Author firstname', 'Author lastname'); --If many authors can be repeated
INSERT INTO category(title) VALUES("Category name") --If multiple categories can be repeated
INSERT INTO publisher(publisher_name) VALUES("Publisher name") --If multiple publishers can be repeated
--map out relations

--first get the id of added book 
SELECT id FROM book WHERE title = 'Your book title here';

--find author(s) id(s) (repeat if necessary for all authors)
SELECT id FROM author WHERE firstname = 'Author firstname' AND lastname = 'Author lastname';

--find category/categories id(s) (repeat if necessary for all categories)

SELECT id FROM category WHERE title = 'Your category';

--find publisher(s) id(s) (repeat if necessary for all publishers)

SELECT id FROM publisher WHERE publisher_name = 'Your publisher'

--Insert corresponding ids to mapping tables. (Examples will not work you'll need to find out the relations on your machine)

INSERT INTO book_author_map(book_id, author_id) VALUES(1,1)
INSERT INTO book_category_map(book_id, category_id) VALUES(1,1)
INSERT INTO book_publisher_map(book_id, publisher_id) VALUES(1,1)

--COPY

--As many copies of a book you have repeat this query with the id of your book from book table.
INSERT INTO copy(book_id) VALUES(1);

--USER

--first get the role id if exists
SELECT id FROM role WHERE user_role = 'Admin';

--if not insert the role
INSERT INTO role(user_role) VALUES('Your custom role here');
INSERT INTO user(firstname, lastname, password, role_id) VALUES('firstname', 'lastname', 'a hashed password', 1);

--DELETE
--use these with caution!

--book
--Remove by id, also title can be used: WHERE title = @title
--This will also remove all relations from mappoing tables, copies and reservations!!! Categories, authors and publishers will stay intact.

DELETE FROM book WHERE id = @id;

--user Remove by id, also fistname, lastame can be used: WHERE firstname = @firstname AND lastname = @lastname
--This also removes all cart items and reservations related to user!!!

DELETE FROM "user" WHERE id = @id;

--UPDATE

--Example is for book but this base query works for most tables (author,category,publisher,user)

UPDATE book SET title = @title WHERE id = @id;