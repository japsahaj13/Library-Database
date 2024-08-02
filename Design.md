### Scope

### Purpose of the Database:

The purpose of the database is to create a comprehensive library management system. It allows users to efficiently search, browse, and manage books, providing a user-friendly interface for accessing and maintaining library resources. The system targets libraries, schools, and individuals who wish to manage their book collections effectively.

### Included in the Scope:

- Authors
- Books
- Genres
- Members (Library patrons)
- Checkouts
- Distance Pickups
- Penalties

### Outside the Scope:

- Financial transactions related to book sales.
- Detailed user profiles beyond basic contact information.
- Detailed information on publishers beyond basic association with books.

### Functional Requirements

### User Abilities:

- Users should be able to search for books by title, author, genre, etc.
- Users should be able to browse through available books.
- Users should be able to check out books.
- Users should be able to request distance pickups.
- Librarians should be able to manage book checkouts and penalties.

### Beyond the Scope:

- Detailed book reviews and ratings.
- Purchase transactions for books.
- Inventory management of non-book items (e.g., DVDs, CDs).

### Representation

### Entities:

1. **Author:**
    - Attributes: ID, Name, Awards and Accolades, Date of Birth.
    - Types and Constraints: Name is string, ID is integer (primary key), Date of Birth is integer (assuming year only), Awards and Accolades is string.
2. **Book:**
    - Attributes: ID, Title, ISBN, ISSN, Date of Publishing, Genre, Series, Blurb, AuthorID, PublisherID.
    - Types and Constraints: ID is integer (primary key), Date of Publishing is integer, Genre is string, AuthorID and PublisherID are integer (foreign keys).
3. **Genre:**
    - Attributes: ID, Name, Blurb.
    - Types and Constraints: ID is integer (primary key), Name is string, Blurb is string.
4. **Member:**
    - Attributes: ID, Name, Phone Number, Address, Email, Employee, Status.
    - Types and Constraints: ID is integer (primary key), Name is string, Phone Number is string, Address is string, Email is string, Employee and Status are boolean.
5. **Checkout:**
    - Attributes: ID, BookID, MemberID, Date of Issue, Due Date, Extension, Actual Return Date.
    - Types and Constraints: ID is integer (primary key), BookID and MemberID are integer (foreign keys), Date of Issue, Due Date, Extension, and Actual Return Date are date/time.
6. **DistancePickup:**
    - Attributes: ID, BookID, MemberID, Pickup Date, Picked Up.
    - Types and Constraints: ID is integer (primary key), BookID and MemberID are integer (foreign keys), Pickup Date is date/time, Picked Up is boolean.
7. **Penalties:**
    - Attributes: ID, CheckoutID, Penalty Amount, Payment Complete.
    - Types and Constraints: ID is integer (primary key), CheckoutID is integer (foreign key), Penalty Amount is numeric, Payment Complete is boolean.

### Relationships:

- **Author - Book:** Many-to-Many
- **Book - Genre:** Many-to-One
- **Book - Publisher:** Many-to-One
- **Book - Member:** Many-to-One
- **Member - Checkout:** One-to-Many
- **Member - DistancePickup:** One-to-Many
- **Checkout - Penalties:** One-to-One

### Optimizations

### Indexes:

- Indexed columns for faster retrieval rate.
- Parameterized queries for security against SQL injection attacks.
- Use of views for commonly requested queries, promoting code reusability and maintainability.
- Triggers for enforcing business policies within the schema.

### Limitations

### Limitations of the Design:

- Triggers might not be the most efficient way to handle certain business logic (e.g., updating Extension Column).
- Direct storage of genre names in the Book table could limit flexibility.
- Lack of support for hierarchical genres.
- Absence of a time-based reset system for member extensions.
- Simplified Book Recommendations View without considering borrowing history and ratings.

### Representation Limitations:

- Detailed user profiles and book reviews are not included.
- Financial transactions related to book sales are outside the scope.
- Inventory management of non-book items is not supported.

This design aims to provide a solid foundation for a library management system while acknowledging its limitations and areas for potential improvement.


### E R Diagram

[![](https://mermaid.ink/img/pako:eNptkctOwzAQRX_FmnVaNQ-SNDtKJcSiogIkJOSNmwyNlcQufkiUJP-OY1KEAM_Kc8-9Gs30UMoKoQBUW86OinVUEPeuramlIuOwWAw92UjZkII8K25QfwG-5eWB3KJQ6HQKG2ylOGryJCn85iTZYXdA5cGbGssGK3JvDdmc_8ID2dtDy3U985df9YOe4wbHy574xCluwnescYPO3Lcyj7FHwVrDUXv0TpRW6f8zKWy5NkyUSPa8bOyJgvc84JtFbbxrKgigQ9UxXrlN9lMSBVNjhxQmvGKqmdDRccwa-XgWJRRGWQzAnipmcN79pXliAooe3qG4SpfrJMrSNF7leRrnSQBnKBZJtszDLI6yKF4n-SocA_iQ0vnDZZhmSbqOnCFLszyKfNqLF19Zq106VtxItfu6uz__-AldaaJX?type=png)](https://mermaid.live/edit#pako:eNptkctOwzAQRX_FmnVaNQ-SNDtKJcSiogIkJOSNmwyNlcQufkiUJP-OY1KEAM_Kc8-9Gs30UMoKoQBUW86OinVUEPeuramlIuOwWAw92UjZkII8K25QfwG-5eWB3KJQ6HQKG2ylOGryJCn85iTZYXdA5cGbGssGK3JvDdmc_8ID2dtDy3U985df9YOe4wbHy574xCluwnescYPO3Lcyj7FHwVrDUXv0TpRW6f8zKWy5NkyUSPa8bOyJgvc84JtFbbxrKgigQ9UxXrlN9lMSBVNjhxQmvGKqmdDRccwa-XgWJRRGWQzAnipmcN79pXliAooe3qG4SpfrJMrSNF7leRrnSQBnKBZJtszDLI6yKF4n-SocA_iQ0vnDZZhmSbqOnCFLszyKfNqLF19Zq106VtxItfu6uz__-AldaaJX)