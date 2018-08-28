### DAO
- Taking tables and columns and mapping it to Java objects and fields
- Two different paradigms
    - Table columns - relational paradigm
    - Java objects - object paradigm

### ORM - object-relational mapping
- Object
    - inheritance
    - Two types of equality
        - memory location (==) & state equality (.equals)
- relational table
    - no inheritance
    - if PK not the same, then both rows aren't the same

# Hibernate
- We are using Hibernate 4

## Using Hibernate
1. Configuration
    - connection
    - object mapping
2. SessionFactory
    - Creates sessions
        - handles transactions
            - `session.save()`
    - `sf.close()`
        - To close the connection to the DB
3. Caching
    - **Lvl 1 (default)**
        - Session
            - Every time you make a session from a SF, everything from that session is cached
                - So if you call something from that session, it will look at the cache first
        - More connections, less overhead
    - **Lvl 2**
        - SessionFactory level
            - Caches results between all sessions made by the session factory
        - Exists for the lifetime of the application
        - Less connections, more overhead
        - update our cfg.xml
        - Lvl 2 cache dependency
            - *Ehcache*
                1. Add the Ehcache dependency
                2. Add property to cfg.xml file for EhcacheProvider
                3. Add ehcache.xml file to configure it
- [EAGER vs LAZY fetching](https://howtoprogramwithjava.com/hibernate-eager-vs-lazy-fetch-type/)

| EAGER | LAZY |
| :------------- | :------------- |
| You get the related objects immediately from tables | Get Proxies (Stand-ins) to stand in for related objects **UNTIL** needed |
| **get** - hits the DB and returns null if no row found | **load** - Always returns a *proxy* without hitting the DB. |
| **save** - returns the *Serializable* value of this identifier. Calling again with the same passed object is detached results in duplicate rows.  | **persist** - `void` return type. INSERT generation occurs only upon committing the transaction, flushing, or closing the session. Passed object is now in persistent state. |
| **update** - `void` return type, acts upon the passed object | **merge** - returns newly updated instance, the passed in object should be discarded |

[More on save, persist, update, and merge](http://www.baeldung.com/hibernate-save-persist-update-merge-saveorupdate)

## Getting started
1. Add hibernate-core to maven dependencies
2. Create class that creates a SessionFactory which in of itself creates a Session
3. Create the hibernate.cfg.xml file which is used to configure not just the connection to the database, but also what dialect it uses and what mappings it uses
4. Create a mapping for each table/object in the \*.hbm.xml file with their mapped properties
5. You can use the Session object to manage transactions

###  [Hibernate object states](https://docs.jboss.org/hibernate/orm/3.3/reference/en-US/html/objectstate.html)
Hibernate is always listening for changes to the objects persisted:
![Hibernate Object States](https://www.baeldung.com/wp-content/uploads/2016/07/2016-07-11_13-38-11-1024x551.png)
- Transient
    - The object has just been instantiated using the `new` operator and not associated with a Hibernate `Session`
    - Not "attached" to a row in the database
    - It has no persistent representation in the database and no identifier value has been assigned.
    - Use the Hibernate `Session` to make an object persistent
- Persisted
    - Connected/synced to database
        - Can manage it using things like `Transactions`
    - Has a representation in the database and an identifier value.
    - It might have just been saved or loaded, however, it is by definition in the scope of a `Session`
    - Hibernate will detect any changes made to an object in persistent state and synchronize the state with the database when the unit of work completes
    - Developers do not execute manual `UPDATE`, or `DELETE` statements when an object should be made transient
- Detached
    - No longer synced
    - An object that has been persistent, but its `Session` has been closed.
    - The reference to the object is still valid, of course, and the detached instance might even be modified in this state.
    - A detached instance can be reattached to a new `Session` at a later point in time, making it (and all the modifications) persistent again.
    - This feature enables a programming model for long running units of work that require user think-time. We call them *application transactions*, i.e. a unit of work from the point of view of the user
- The ID field is what actually links your object to a row in the database
    - So you can check if the object is persisted by observing its ID field

### Cascade Types
- ALL
- PERSIST
- MERGE
### Update
- To persist changes on an object, it must be between a session.beginTransaction() and session.getTransaction() and then commit() the transaction.

### [Core Hibernate Interfaces](https://www.javavillage.in/hibernate-core-interfaces.php)
| JDBC | Hibernate |
| :------------- | :------------- |
| Connection | Configuration       |
| ResultSet | Session Factory |
| Statement | Session |
| SQLException | Transaction |
|  | Query |
| | Criteria |

## Hibernate
- **Configuration**
    - Used to configure Hibernate (Duh). The application uses a Configuration instance to specify the location of mapping documents and Hibernate-specific properties and then create the SessionFactory.
- **Session Factory (Factory Design Pattern)**
    - The beating heart of all this
    - Creates/builds properly configured session objects so you don't have to do it yourself
- **Session**
    - Java object used for any DB operations
- **Transaction**
    - Represents a unit of work.
    - Within one transaction, you can do several operations and can commit transaction once after successfully completed all operations.
    - The advantage here  is you can rollback all previous operations if one operation is fail in your operation batch
- **Query (For more advanced DML statements)**
    - HQL (Hibernate Query Language) for advanced queries
- **Criteria (For selects)**
    - programmatic select
        - Taking a query and then using Java to slice up a query into whatever you want
    - object-oriented criteria queries

### Hibernate Annotations
- `@Entity`

- `@Table(name ="TABLE_NAME")`
- `@Id`
- `@GeneratedValue(strategy =  GenerationType.SEQUENCE, generator = "nameOfSeq")`
- `@SequenceGenerator(allocationSize = 1, name = "nameOfSeq", sequenceName = "NAME_OF_SEQ_IN_TABLE_SEQ")`
- `@Column(name = "COLUMN_NAME)`
- `@Enumerated(EnumType.STRING)`
- `@ManyToOne, @ManyToMany, @OneToOne, @OneToMany`
- `@JoinColumn(name = "FK_NAME")`
- `@AttributeOverrides`
    - `@AttributeOverride(name="nameOfProperty", column=@Column(name = "NEW_NAME"))`
- `@NamedQueries`
    - `@NamedQuery`

### hibernate.cfg.xml file
``` XML
<hibernate-configuration>
    <session-factory>
        <!--url, username, password, driver_class-->
        <property name="">
        </>
        <!-- "resource" maps to *.hbm.xml file-->
        <mapping resource="*.hbm.xml"/>
        <!-- "class" maps to properly annotated Entity class -->
        <mapping class="com.revature.domain.Bear"/>
    </>
</>
```

### \*.hbm.xml file
``` XML
<hibernate-mapping>
    <class name="name.of.Class" table="TABLE_NAME">
        <id name="idNameInClass" column="COLUMN_NAME_IN_TABLE">
            <generator class="increment"/>
        </>
    </>
    <property name="nameInClass" column="COLUMN_NAME_IN_TABLE"/>
</>
```
##### Convention over configuration
- Because there are certain conventions for writing code or databases, we don't have to worry about configuration

# SPA
- Instead of using links, use routing
