## Little notes on working on a deadline (Development Life cycle)
- Spend ~90% of the time planning how you are going to accomplish the task, then spend the last 10% building the application.
- Using Interfaces to help build the skeleton of the project based on the UML diagram.
    - Have classes implement the Interfaces later on
- TDD (Test Driven Development)
    - Creating test files for each implementation
    - Take an implementation object and write code until the tests associated goes green
        - If a previously passing test fails, go back and fix it
    - This shows how much progress is done.
    - Methods should be fairly easy to test
- You want user stories to create a product backlog
    - Prioritizing tasks and estimating difficulty
- You can show your progress as a Burn-down Chart
    - Basically showing how much work is left


# SQL
- What is SQL really?
- You want to persist the data permanently.

### How would you build your own RDBMS?
- It's gotta be persisted
- It's gotta be accessible by more than one machine
- Make sure that changes to files are not completely overridden by someone else



### RDBMS (Relational Database Management System)
- User (SQL Commands)--> Oracle Database(Gatekeeper to files) --> Files   
    - We will be using **11g**
- Different sub-languages for Oracle
    - **Queries/DQL (DML for normies)** : *Select*
    - **DML/Data Manipulation Language**: *Update*, *Insert*, *Delete*
        - Manipulating the Rows
    - **DDL/Data Definition Language**: *Create*, *Alter*, *Drop*, *Truncate*
        - Manipulating the Tables
    - **TCL/"Transaction Control"**: *Commit*, *Rollback*, *SavePoint*
        - Use this to control the when, why, and how of transactions
    - **DCL/ Data Control Language**: *Grant*, *Revoke*,
        - Controls the access of the data (users have different access to different databases)

## Relational DB
### Schemas
- A way of organizing tables and avoiding naming conflicts for tables
### Users
- Can be similar or interchangeable with schemas
- Who connects and what are they allowed to connect to? What are they allowed to do?
#### Tables
- Collection of columns with restraints (What type of information can it take? etc.)
##### Keys
###### Primary Key
- **Candidate Key**
    - Any key that can serve as a primary key
- **Composite Key**
    - A key defined by a combination of more than one column
- **Foreign Key**
    - A primary key that comes from a row in another table
- A combination of column restraints and foreign keys helps enforce **domain integrity** and **referential integrity**
    - Domain integrity specifies that all columns in a relational database must be declared upon a defined domain.
    - Referential integrity asks whether the database is in a valid state
        - If a row points to a foreign key that doesn't exist anymore, you get something called an **orphan**.
            - Therefore you have to delete all rows that points to the row you are deleting *before* deleting that row.

## Normalization
- You want to reduce redundancy.

### TV Shows
| ID     | Name     | Directors | Cast | Episodes |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| 1 | The Show | A.b. White, D.C. Brown | A,B,C | 34 |
| 2 | The O Show| D.C. Brown | C,D | 28 |

> If you were to delete "The O Show", you delete Actor D as well, D is tied to the show

## 1st Normal Form (1NF)
- Atomic fields
    - One value per field

| TV Shows |
| :------------- |
| ID  (PK)|
| Name |
| Episodes |

| TV_SHOWS_DIRECTOR |
| :------------- |
| TV_ID  (FK)|
| D_ID (FK)|


| Directors |
| :------------- |
| ID  (PK)|
| Name |

| Cast |
| :------------- |
| ID  (PK)|
| Name |

| CAST_TV_SHOWS |
| :------------- |
| TV_ID  (FK)|
| C_ID (FK)|


### Multiplicity
- One to One
- One to Many
- Many to Many

### 2nd Normal Form (2NF)
- No Partial Dependencies
    - Has to depend on the whole primary key, not a part of it

### 3rd Normal Form (3NF)
- No Transitive Dependencies
    - Column can't depend on another column other than the primary key

### DML
- DELETE
    - Deleting rows in a table
    - When deleting a whole table, you delete row by row so it has overhead
    - If set up correctly, you can rollback the DELETE changes
### DDL
- DROP
    - Deleting the table itself along with all the data in it all at once
- TRUNCATE
    - The contents of all data in the table will be dropped, no affect on the table structure
- Both of the actions above are permanent

## JOINS
- A way of putting relating tables back together in a way that makes sense to humans based on their relationships
### INNER
- A JOIN B => similar rows from B to A
### LEFT OUTER
- A LEFT OUTER JOIN B => All A + similar rows of B (Null value if no match for A row)
### RIGHT OUTER
- A RIGHT OUTER JOIN B => All of B + similar rows of A (Null value is no match for B row)
### FULL OUTER
### CROSS JOIN
#### CARTESIAN JOIN
- rows of A * rows of B = lots of rows


## UNIONS
- Fusing rows (fusing Select statements (Views))
- Tables in the Union **has to have the same columns in order to union**
### UNION
- All distinct rows from A and B
    - ex:
        ``` SQL
        select * from car where make = 'Honda'
        union
        select * from car where year < 2015;
        ```
### UNION ALL
- All rows, including duplicates
### INTERSECT
- Only matching rows
### MINUS
- A MINUS B => Everything in A but not anything from B

## PL/SQL
- **View**
    - A virtualized table that represents the result set
- **Sequence**
    - Counter (Mostly use for creating and keeping track of PK_ID)
    - How to use a Sequence? With a Trigger.
- **Triggers**
    - Triggered by some event (Usually, for us, a DML (INSERT, UPDATE, DELETE))


## Indexes
- Used to speed up searching for a row (Use it for tables that aren't going to change often)
- More of a memory location or address
    - As opposed to a primary key whose only job is to identify if a row is unique to a table


### TCL
- SavePoint
    - We can have many SavePoints
    - ex:
    ``` SQL
    SavePoint mySP;
    INSERT ...;

    SavePoint myOtherSP;
    DELETE ...;

    Rollback to SavePoint mySP;

    COMMIT;
    ```
- Rollback
    - Rollsback reverts changes back to the specified SavePoint
- Commit
    - Commits the changes which means that they cannot be reverted by rollback or by any other means
## ACID Principles for Transactions (IMPORTANT)
### Atomicity
- Either everything succeeds or nothing succeeds
### Consistency
- Everything is in a legal state
- You should start with a consistent state and end with a consistent state
- EX: If you delete a parent that has child
### Isolation
- Transactions are independent of one another
- You need to make sure that transactions cannot affect each other when running in parallel
-  Isolation ensures that concurrent execution of transactions leaves the database in the same state that would've been obtained if the transactions were executed sequentially.
#### [Transaction Isolation Levels (IMPORTANT)](https://en.wikipedia.org/wiki/Isolation_(database_systems)#Isolation_levels)

- Defined by the following phenomena
    - **Dirty Read**
        - Transaction reads data that's not yet committed.
    - **Non Repeatable read**
        - A transaction reads the same row twice and gets a different value each time
    - **Phantom Read**
        - Occurs when two same queries are executed, but rows retrieved by the two are different.

##### Serializable
-  This is the Highest isolation level. A serializable execution is guaranteed to be serializable. Serializable execution is defined to be an execution of operations in which concurrently executing transactions appears to be serially executing.
##### Repeatable reads
- This is the most restrictive isolation level. The transaction holds read locks on all rows it references and write locks on all rows it inserts, updates, or deletes. Since other transaction cannot read, update or delete
##### Read Committed
- This isolation level guarantees that any data read is committed at the moment it is read. Thus it does not allows dirty read. The transaction hold a read or write lock on the current row, and thus prevent other rows from reading, updating or deleting it.
##### Read Uncommitted
- Read Uncommitted is the lowest isolation level. In this level, one transaction may read not yet committed changes made by other transaction, thereby allowing dirty reads. In this level, transactions are not isolated from each other.

![Isolation Levels Table](https://www.geeksforgeeks.org/wp-content/uploads/transactnLevel.png)

### Durability
- There should be no way that you can rollback once a transaction is done.
- Transactions should be permanent

## Java Database Connectivity (JDBC)
- From java.sql --> Connection Interface --> Instance w/ Driver + url/port/SID/username/password
- ojdbc7.jar
    - This is the driver for allowing Java to talk through their **thin client** this driver to the Oracle DB
        - **thin client** - Instance w/ Driver + url/port/SID/username/password

### DAO - Data Access Object
- Objects that act as the in between between the actually object and the database itself
