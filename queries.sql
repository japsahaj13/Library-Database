INSERT INTO "genre" ("Name", "Blurb") 
VALUES
    ('educational textbook', 'Books designed to educate and teach'),
    ('fantasy', 'Books containing elements of imagination and magic'),
    ('philosophy', 'Books exploring fundamental questions about existence and reality'),
    ('autobiography', 'Books recounting the life story of the author'),
    ('sci-fi', 'Books featuring futuristic or speculative science-based themes');

INSERT INTO "Author" ("Name", "awardsandaccolades", "dateofbirth") 
VALUES
    ('J.K. Rowling', 'Pulitzer', 1965),
    ('Stephen Hawking', 'Nobel Prize', 1942),
    ('George Orwell', 'Man Booker', 1903),
    ('J.R.R. Tolkien', 'Neustadt', 1892),
    ('Haruki Murakami', 'Hugo', 1949),
    ('Ernest Hemingway', 'Printz', 1899),
    ('Jane Austen', 'John Newbery', 1775);

INSERT INTO "Member" ("Name", "Phonenumber", "Address", "Email", "Employee", "Status") 
VALUES
    ('John Doe', '+1234567890', '123 Main St, Anytown, USA', 'john@example.com', 1, 'Valid'),
    ('Alice Smith', '+1987654321', '456 Elm St, Othertown, USA', 'alice@example.com', 0, 'Valid'),
    ('Bob Johnson', '+1122334455', '789 Oak St, Another Town, USA', 'bob@example.com', 1, 'On-Hold'),
    ('Emily Brown', '+1555666777', '321 Pine St, Somewhere, USA', 'emily@example.com', 0, 'Renewal Pending');


INSERT INTO "Book" ("Title", "ISBN", "ISSN", "DateofPublishing", "Genre", "Series", "Blurb", "AuthorID", "PublisherID") 
VALUES
    ('Harry Potter and the Philosopher''s Stone','ISSN 0004-6361' , 'ISBN 978-0-306-40615-7', 1997, 'fantasy', 'Harry Potter', 'The first book in the Harry Potter series', 1, 1),
    ('1984','ISSN 0004-0021', 'ISBN 128-0-306-40315-4', 1949, 'sci-fi', NULL, 'A dystopian novel by George Orwell', 3, 2),
    ('The Hobbit', 'ISSN 0004-6361' , 'ISBN 478-3-306-40635-5', 1937, 'fantasy', NULL, 'A fantasy novel by J.R.R. Tolkien', 4, 3),
    ('Sputnik Sweetheart', 'ISSN 0203-6123 ', 'ISBN 978-0-306-23445-7', 1999, 'sci-fi', NULL, 'A novel by Haruki Murakami', 5, 4),
    ('To Kill a Mockingbird', 'ISSN 1204-2345 ', 'ISBN 324-4-121-12345-5', 1960, 'philosophy', NULL, 'A novel by Harper Lee', NULL, 5);


INSERT INTO "checkout" ("BookID", "MemberID", "Dateofissue", "Duedate", "Extension", "Actual return date") 
VALUES
    (1, 1, '2024-03-10', '2024-03-31', 0, '2024-03-31'),
    (2, 2, '2024-03-05', '2024-03-26', 0, '2024-03-26'),
    (3, 3, '2024-03-01', '2024-03-22', 0, '2024-03-22'),
    (4, 4, '2024-02-25', '2024-03-17', 1, '2024-03-17');


INSERT INTO "distancepickup" ("BookID", "mEmberID", "PickupDate", "PickedUp") 
VALUES
    (5, 2, '2024-03-10', 1),
    (1, 3, '2024-03-12', 0),
    (3, 4, '2024-03-10', 1);


INSERT INTO `latefees/penalties` ("CheckoutID", "PenaltyAmount", "PaymentComplete")
VALUES 
    (1, 50.00, FALSE),
    (2, 100.00, TRUE),
    (3, 75.00, FALSE);




--other queries
SELECT Book.Title, Book.DateofPublishing, Author.Name AS AuthorName
FROM Book
JOIN Author ON Book.AuthorID = Author.ID;

SELECT RecommendedBook, Genre
FROM BookRecommendations
WHERE MemberName = 'Emily Brown';

UPDATE Member
SET Address = '101 STREET'
WHERE Name = 'John Doe';

DELETE FROM checkout
WHERE BookID = (SELECT BookID FROM checkout WHERE MemberID = (SELECT ID FROM Member WHERE Name = 'Alice Smith') LIMIT 1);
DELETE FROM "checkout"
WHERE "BookID" = (SELECT "ID" FROM "Book" WHERE "Title" = 'The Hobbit');


ALTER TABLE Member ADD COLUMN Rating INTEGER DEFAULT 0;

SELECT Book.Title, Book.DateofPublishing, Author.Name AS AuthorName
FROM Book
JOIN Author ON Book.AuthorID = Author.ID;



