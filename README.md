# Library Database Design Documentation
The following documentation details the design of a library database system, for possible future implementation in a Fullstack project. It is a group project in Integrify’s Fullstack Academy course, and the group roles are as follows:

Jeremias Ryttäri [JeremiasRy](https://github.com/JeremiasRy) - Lead Developer

Luan (Nguyen Thanh) Le [ELNAUL99](https://github.com/ELNAUL99) - Endpoint Designer

Kimberly Ruohio [kimintime](https://github.com/kimintime) - Architect and Documentation

Github link to the project: <TBA>

## Introduction
In this documentation we will describe the library database model, and post example queries, which detail finding all books in the database, finding a single book, as well as demonstrating how reserving a book works, looking at cart information, and book inventory after a reservation is made.

### Features
The library database features:

- User login and user roles (customer or admin)
- CRUD functionality with the appropriate authorizations
- Book reservation system that tracks the number of books available, checkout and due dates, and which users have loans.
- Book reviews


## Database Model
The ERD for our library database is shown below. Breaking it down into plain English, many users can have one role, admin (or librarian), or customer. The database allows one user to have many cart items, and those cart items are copies of specific books. It is those specific copies that can be lent out to become reservations.

![backend_project](https://user-images.githubusercontent.com/40215472/219979882-b295c08d-2ac5-4a7f-b05f-ceb173f48d28.png)

One book may have many reviews, many authors, many categories, and many publishers. There are individual mapping tables between the book and authors, categories, and publishers, because while one book can have many reviews, those reviews are specific to that book. Many books can have the same authors, and same categories.

## Queries
The queries for the the database are separated by type. [Create_db_and_tables.sql](../main/queries/Create_db_and_tables.sql) creates the database and its tables, as the name suggests. Run that first if testing this out for yourself. After which, it’s time to stock the library with users and books, with [Insert_dummy_data.sql](../main/queries/Insert_dummy_data.sql).

### CRUD operations
CRUD operations are included in [Basic CRUD.sql](../main/queries/Basic%20CRUD.sql), but the emphasis is on basic. Ids need to be checked to be unique, but it should be clear within the file where to put these ids. 

### Example Usage
Examples of how the system loans out books, and how searching for all books or specific books works, have a look at [Example_usage.sql](../main/queries/Example_usage.sql).

## Library Database in Action

### Information for all Books
First, let’s have a look at the books in the library, and how many are available. As you can see, some books are not suitable for just one category, which the individual mapping tables allow for a clean display. Also note the number of copies for each book.
    

![All books](../main/demo_pics/get_all_books_with_info.png)

    
### Information for one Book
Next, let’s try looking up one book, **Steppenwolf**. It is listed as fiction, romance, and there are three copies available.


![One book](../main/demo_pics/get_single_book_with_info.png)


### Adding Items to Cart
Before having a look at the cart system, we must first add items to the cart. The screenshot below shows the users in the database, where we see Jeremias is adding three books to his cart: **Steppenwolf**, **Brave New World**, and the **Hitchhiker’s Guide to the Galaxy**. 

   
![Adding items to cart](../main/demo_pics/add_items_to_cart.png)
    
![Cart info](../main/demo_pics/get_cart_info.png)

    
### Reservation and Result
Having completed the checkout process, Jeremias has made the following reservation, and we can see the checkout date and due date.
    
    
![Reservation](../main/demo_pics/making_reservations.png)
    

Now if we have another look at the information for all books in the database, we that the quantity for each book has been updated.
    
    
![Result](../main/demo_pics/get_all_books_after_reservations.png)
    

## Endpoints
The endpoints are detailed in [API endpoints.txt](../main/API%20endpoints.txt). 
