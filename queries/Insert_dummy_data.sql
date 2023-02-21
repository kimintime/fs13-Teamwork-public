INSERT INTO role(user_role) 
VALUES ('Admin'), ('Customer');

INSERT INTO "user"(firstname, lastname, password, role_id) 
VALUES 
('Jeremias', 'Ryttäri', 'ThisShouldBeHashed', 2),
('Kimberly', 'Ruohio', 'ComeonHashYourSecrets', 1),
('Ne', 'Luan Nguyen', 'hashhashhashhash', 1);

INSERT INTO author(firstname, lastname)
VALUES
('Hermann', 'Hesse'),
('Mihail', 'Bulgakov'),
('Aldous', 'Huxley'),
('Charles', 'Bukowski'),
('Marcus', 'Aurelius'),
('Viktor', 'Frankl'),
('Douglas', 'Adams');

INSERT INTO category(title)
VALUES
('Fiction'),
('Scifi'),
('Romance'),
('Satire'),
('Farce'),
('Autobiography'),
('Psychology'),
('Realism'),
('Dystopian'),
('Philosophy');

INSERT INTO book(title)
VALUES
('Steppenwolf'),
('Mans search for meaning'),
('Meditations'),
('Factotum'), 
('Brave new world'),
('The master and the margarita'),
('The hitchhikers guide to the galaxy');

INSERT INTO publisher(publisher_name)
VALUES
('WSOY'),
('Keltainen kirjasto'),
('Basam Books'),
('Ridler Books'), 
('Werner Söderstöm Osakeyhtiö');

INSERT INTO book_publisher_map(book_id, publisher_id)
VALUES
(1, 5),
(2, 4),
(3, 3),
(4, 1),
(5, 2),
(6, 1),
(7, 1);

INSERT INTO book_author_map(book_id, author_id)
VALUES
(1, 1),
(2, 6),
(3, 5),
(4, 4),
(5, 3),
(6, 2),
(7, 7);

INSERT INTO book_category_map(book_id, category_id)
VALUES
(1, 1),
(1, 3),
(2, 6),
(2, 7),
(3, 10),
(4, 6),
(4, 8),
(5, 9),
(5, 1),
(5, 2),
(6, 1),
(6, 3),
(6, 4),
(6, 5),
(7, 1),
(7, 2);

INSERT INTO copy(book_id)
VALUES
(1),(1),(1),
(2),(2),
(3),(3),(3),(3),
(4),(4),
(5),
(6),(6),(6),(6),
(7),(7),(7);

INSERT INTO review(book_id, review)
VALUES
(5, 'A chilling look into near future which might not be too far away from reality'),
(4, 'Much fun, somewhat relatable'),
(7, 'Dont panic!!');


