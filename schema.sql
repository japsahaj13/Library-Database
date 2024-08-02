CREATE TABLE IF NOT EXISTS "Book" (
    "ID" INTEGER PRIMARY KEY AUTOINCREMENT,
    "Title" TEXT,
    "ISBN" CHAR(35) NOT NULL,
    "ISSN" CHAR(35) NOT NULL,
    "DateofPublishing" INTEGER,
    "Genre" TEXT CHECK ("Genre" IN ('educational textbook', 'fantasy', 'philosophy', 'autobiography', 'sci-fi')),
    "Series" TEXT,
    "Blurb" TEXT,
    "AuthorID" INTEGER,
    "PublisherID" INTEGER,
    FOREIGN KEY ("AuthorID") REFERENCES "Author"("ID"),
    FOREIGN KEY ("Genre") REFERENCES "genre"("Name")
);

CREATE TABLE IF NOT EXISTS "genre" (
    "ID" INTEGER PRIMARY KEY,
    "Name" TEXT CHECK ("Name" IN ('educational textbook', 'fantasy', 'philosophy', 'autobiography', 'sci-fi')), 
    "Blurb" TEXT
);

CREATE TABLE IF NOT EXISTS "Author" (
    "ID" INTEGER PRIMARY KEY AUTOINCREMENT,
    "Name" TEXT,
    "awardsandaccolades" TEXT CHECK ("awardsandaccolades" IN ('Nobel Prize', 'Pulitzer', 'Man Booker', 'Neustadt', 'Hugo', 'Printz', 'John Newbery')),
    "dateofbirth" INTEGER
);

CREATE TABLE IF NOT EXISTS "Member" (
    "ID" INTEGER PRIMARY KEY AUTOINCREMENT,
    "Name" TEXT NOT NULL,
    "Phonenumber" VARCHAR(13) NOT NULL UNIQUE,
    "Address" TEXT,
    "Email" TEXT NOT NULL UNIQUE,
    "Employee" BOOLEAN NOT NULL, 
    "Status" TEXT CHECK ("Status" IN ('Valid', 'Renewal Pending', 'Cancelled', 'On-Hold')) NOT NULL
);

CREATE TABLE IF NOT EXISTS "checkout" (
    "ID" INTEGER PRIMARY KEY AUTOINCREMENT,
    "BookID" INTEGER,
    "MemberID" INTEGER,
    "Dateofissue" DATE NOT NULL,
    "Duedate" DATE NOT NULL,
    "Extension" INTEGER DEFAULT 0, 
    "Actual return date" DATE NULL,
    FOREIGN KEY ("BookID") REFERENCES "Book"("ID"),
    FOREIGN KEY ("MemberID") REFERENCES "Member"("ID")
);

CREATE TABLE IF NOT EXISTS "latefees/penalties" (
    "ID" INTEGER PRIMARY KEY AUTOINCREMENT,
    "CheckoutID" INTEGER,
    "PenaltyAmount" NUMERIC(10, 2) NOT NULL,
    "PaymentComplete" BOOLEAN NOT NULL,
    FOREIGN KEY ("CheckoutID") REFERENCES "checkout"("ID")
);

CREATE TABLE IF NOT EXISTS "distancepickup" (
    "ID" INTEGER PRIMARY KEY AUTOINCREMENT,
    "BookID" INTEGER,
    "mEmberID" INTEGER,
    "PickupDate" DATE NOT NULL,
    "PickedUp" BOOLEAN NOT NULL,
    FOREIGN KEY ("mEmberID") REFERENCES "Member"("ID")
);

CREATE TRIGGER before_checkout_update
BEFORE UPDATE ON "checkout"
FOR EACH ROW
BEGIN
    UPDATE "checkout"
    SET "Extension" = CASE
        WHEN (SELECT "Employee" FROM "Member" WHERE "ID" = NEW."MemberID") = 1 THEN LEAST(NEW."Extension" + 1, 5)
        ELSE LEAST(NEW."Extension" + 1, 4)
        END;
END;

CREATE TRIGGER update_member_status
AFTER INSERT ON "distancepickup"
FOR EACH ROW
BEGIN
    UPDATE "Member"
    SET "Status" = 'On-Hold'
    WHERE "ID" = NEW."mEmberID" AND (SELECT COUNT(*) FROM "distancepickup" WHERE "mEmberID" = NEW."mEmberID" AND "PickedUp" = 0) = 3;
END;

CREATE TRIGGER CalculateLateFees
AFTER UPDATE ON "checkout"
FOR EACH ROW
WHEN NEW.`Actual return date` > OLD.`Duedate`
BEGIN
    INSERT INTO `latefees/penalties` (`CheckoutID`, `PenaltyAmount`, `PaymentComplete`)
    VALUES (NEW.`ID`, (julianday(NEW.`Actual return date`) - julianday(OLD.`Duedate`)) * 50, FALSE);
END;



--view
DROP VIEW IF EXISTS BookRecommendations;
DROP VIEW IF EXISTS FrequentReaders;
DROP VIEW IF EXISTS PopularGenres;
DROP VIEW IF EXISTS BookOfTheDay;


CREATE VIEW BookRecommendations AS
SELECT m.Name AS MemberName, b.Title AS RecommendedBook, b.Genre
FROM Member m
JOIN Checkout c ON m.ID = c.MemberID
JOIN Book b ON c.BookID = b.ID
WHERE b.Genre IN (
    SELECT Genre
    FROM Book
    JOIN Checkout ON Book.ID = Checkout.BookID
    WHERE Checkout.MemberID = m.ID
    GROUP BY Genre
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
AND c.`Actual return date` IS NOT NULL
AND c.MemberID <> m.ID;

CREATE VIEW FrequentReaders AS
SELECT m.Name AS MemberName, COUNT(*) AS BooksBorrowed
FROM Member m
JOIN Checkout c ON m.ID = c.MemberID
GROUP BY m.ID
ORDER BY BooksBorrowed DESC
LIMIT 5;

CREATE VIEW PopularGenres AS
SELECT Genre, COUNT(*) AS BooksBorrowed
FROM Book
JOIN Checkout ON Book.ID = Checkout.BookID
GROUP BY Genre
ORDER BY BooksBorrowed DESC
LIMIT 3;

CREATE VIEW BookOfTheDay AS
SELECT Title, AuthorID, Genre, Blurb
FROM Book
ORDER BY RANDOM()
LIMIT 1;



--index



CREATE INDEX idx_member_name ON Member (Name);
CREATE INDEX idx_book_title ON Book (Title);

--covering index
CREATE INDEX idx_book_covering ON Book (DateofPublishing, Genre);

--partial index
CREATE INDEX idx_book_partial_genre ON Book (Genre) WHERE Genre IN ('sci-fi', 'fantasy') AND DateofPublishing > 2000;

