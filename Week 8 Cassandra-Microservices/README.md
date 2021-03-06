# Microservices
- Distributed Computing
- We can have an application distributed across multiple computers and communicate and coordinate to accomplish tasks

## SOA
- Service Oriented Architecture
- Corporations
    - Imagine if you have multiple services that utilize the same service.
    - Having that service as a standalone is great because it can be reuseable and using easily with new applications.
    - But it broke apart because everyone wants different versions of the service and the service got bigger and bigger to accommodate for every other service that uses it.

## Microservices
- Think of teams instead of the whole corporation
- Team
    - Before microservices is the monolith
        - Monolith
            - Resources
            - Servlets
            - Vertical Stack
                - Services
                - Beans
                - DAOs
    - What if we separate those vertical stacks into separate applications
- Why use microservices?
    - Netflix
        - Monolith
            - Netflix Monolith
            - Autoscaling
                - Run another instance of Netflix and both share half the load and so on.
        - But what if 80% of your users are only using one small part of your application?
            - Then you are wasting way more resources than what you'd actually need since you have to create an instance of the whole thing.
        - Microservices
            - User app
            - Employee app
            - Movie App
            - Front end
        - So now, with microservices, you only need to create more of the microservices instances that you need which is much smaller than if you had to build the whole monolith.
- Two type of services
    - MSA
        - business logic
        - infrastructure
        - MS don't realize about the outside surrounding.
            - It's like an island
- Gateway Service
    - What once was a monolith is now a distributed application that acts as a single application
    - Figures out where the request was coming from and send the request to the right service (i.e. to a TV front end )
- What about the database structure?
    - Databases *can* handle a lot of requests, but it can be too much
    - So what about splitting them to separate individual tables
        - No more foreign keys
        - Not ACID, use BASE (Really? They choose that name?)
            - BASE
                 - Eventual consistency
                     -You can't guarantee that your db is always consistent
                     - Real world example
                        - You deposit money, the bank won't update until a little later...eventually
- Agile allowed Microservices to become a thing

## MSA (Microservice Architecture)
- granular services
    - Want them to exist as small islands
        - Doesn't care nor have any idea about the rest of the system.
        - All it cares about is "Who do I register myself with"
- Microservices should have very small, simple components
- orchestrated by infrastructure services
    - **Registry service** (Eureka)
        - Know what and where all the services are in the ecosystem
        - Always changing as service location change as well
    - **Load balancer** (Ribbon)
        - Doesn't bombard a particular server with requests and spreads it out
    - **Gateway service** (Zuul)
        - The part that is exposed to the world that makes it seem like these interconnect services are actually one application
        - Good place to have filters and security
    - **Message brokers**
        - Message queues
        - You don't want MS to be tightly coupled as you can have cascading failures
        - Broker
            - The requester will publish a method to the broker
            - And there will be another service that can subscribe to the broker
                - This decouples the two services and any microservice that subscribed to the broker can handle the message
            - The broker is a database that stores these receipts
    - **Circuit breaker** (Hystrix)
        - Used to constantly check the failure rates of services and if something fails too much, stop it and kill it. The process will come back up again after awhile.
        - Handles how to fail gracefully, maybe give an object of id 0 with a null object
    - **Monitoring Service** (Hystrix/Eureka)
    - **Config Service**
### Spring Boot
#### Spring Cloud
- Gateway service (Zuul)
- Load balancer (Ribbon)
- Registry Service (Eureka)
#### MSA Benefits breaker
- Efficient Scaling
- No single point of failure
- Resilient
- Modular
- Quickly deployable (At least in parts)
## Spring Boot
- Have the Spring Boot Application class with the @SpringBootApplication annotation be on a higher package level than the rest of what you want to Component Scan

### [Eureka](https://github.com/Netflix/eureka/wiki)
- Our registry service
    - Store a registry of all the services that are
- Spring Eureka
- All it wants to know is when a new Eureka Client is added
- Health checks by sending heartbeats
    - To make sure the registered server is still
#### Setup
- Eureka Server from Spring Cloud
- @EnableEurekaServer on your SpringBootApplication class
- Property file to set options like renewal/ignore self-registry

### [Zuul](https://github.com/Netflix/zuul)
- Doesn't need to hard code the route to a service, let eureka handle it.
- Spring Eureka client
- Zuul - Gateway
- You ask Zuul for the correct location and it will lead you to that location
- The client shouldn't be directly talking to the microservices
#### Setup
- Zuul gateway
- @EnableZuulProxy
- prop file to set paths
- [can set pre, route, post filters](https://github.com/Netflix/zuul/wiki/How-it-Works)
### Microservices
- Spring web
- Eureka for client
- REST API
#### Setup
- Eureka Discovery Dependency
    - @EnableEurekaClient
- prop file to point to Eureka Server
- White Box
    - You know what goes in and what comes out, but you don't care about what happens inside the box and how it does it.
    - You can also look at metrics and exceptions of the microservice
        - All for your infrastructure to use
            - Monitoring Service
            - Circuit Breaker
            - Config Server
### Cross-Cutting Concerns
- The properties files are in all of these parts.
    - It can be a handful to keep track of and manage all those property files
- How can we manage this? With a configuration service.

## Spring Cloud Config
- Contains all of your properties files
- One can request for them
- Why?
    - You can have many different properties file for each environment (testing, development, production) and this can make it easier to switch them out
- Imagine having a private repo containing all your sensitive username/password information and having the Config Service grab that information for you

### [Hystrix](https://github.com/Netflix/Hystrix/wiki)
- Latency + Fault Tolerance (Exceptions) (Circuit Breaker)
    - Latency
        - Handling what happens when something is taking too long
    - Fault Tolerance
        - What happens in the event that it's just not working?
            - Packets are lost, some service is not found, an error pops up
- In the event of the above ^, Hystrix has:
    - Placeholder methods
        - Instead of calling the nonworking method over and over, it will call a placeholder method that returns dummy data until the method starts working again and then it switches back.
- Dashboard for monitoring (Metrics) (Monitoring service)
    - It also collects metrics and presents them to you in a graph
    - These failing events happen much faster than what we can normally observe in real time. But Hystrix tracks these things and displays it in a human readable manner.
- Actuator? What is that?

### Cassandra
- Databases can get hit hard with requests
- But reads are pretty simple and straight forward
- You want to scale this up
    - You have a queue that stores incoming requests
    - The requests are handled in the order that they are queued
    - That way, the request doesn't have to immediately be executed
    - Allows us to decouple the request handler and the database, all
- BASE transactions
    - Basic Availability
        - Your database is generally available
    - Soft State
        - You database in not in a truly consistent state
        - You may have foreign keys that don't actually exist in the same DB, but it will eventually be "joined" with another table
    - Eventual consistency
        - Eventually, your database will be consistent
- During the sending of data, for whatever reason, a bank or microservice or queue goes down, they are persistently stored so they can bounce back
- So what are we using for the queue?
- JMS (Java messaging service)
- Advanced Messaging Queue Protocol (AMQP)
    - A protocol is a standardized set of rules for communication
    - A standardized way of creating a binary stream of data
    - A stream is different from sending requests back and forth
    - Turns all this information into a data stream
    - And sends it to a message broker that determines what to do with the data
    - Rabbit MQ
        - Has a guarantee that each message may be read at least once
            - Or at most once. Your choice
    - Qpid
        - Used in JPMC
        - Runs on Erlang
        - Has a web app to manager the controller
- Apache Kafka
    - Another messaging queue but doesn't use AMQP
- Main parts of Messaging Queues (Publisher/Subscriber method)
    - Exchange (One) (The message broker)
        - Manages the queues
        - Rabbit will send requests to the Exchange
        - Exchange will send it to a Queue
    - Queue (Many)
        - Handles the request in the order they arrived
        - Multiple copies of Microservices will read the same queue (The subscribers)
        - Generally keep each queue to a specific microservice type
- NoSQL
    - Non-relational databases (There are many kinds)
    - Sometimes, relational databases are not what you want
    - Different kinds:
        - Forms:
            - MongoDB
            - Good for things like news sites and blogs
            - No concerns for restrictions and empty fields
        - columnar:
            - Cassandra
            - What looks like a row table, but of varying column lengths
                - These columns have their own rows of information
            - CQL
                - Very similar to SQL but be aware that it is not SQL
            - Distributed among many nodes
                - It's not just one silo of data, there are many different nodes
                - Using a hash function to determine which silo the data may be in
                - Or replicating data among themselves
            - **CAP Theorem**
                - [Link 1](http://robertgreiner.com/2014/08/cap-theorem-revisited/)
                - [Link 2](https://towardsdatascience.com/cap-theorem-and-distributed-database-management-systems-5c2be977950e)
                - Consistent
                    - Giving up Consistency for Availability
                    - Replication Factor
                        - When changes are made to one silo, it talks to N other silos and copy that information to other nodes(silos)
                        - In Cassandra, you can choose the replication factor for each transaction
                - Availability
                    - Available for read/writes in
                - Partitioned
                    - Database is split
                - The theorem says: "Pick two"
                    - Cassandra and many other similar databases choose Availability and Partition
                    - But the application can wander around, and change which 2
                - Protecting against fraud
                    - Cassandra can stream information quickly, so they can do fraud detection in real time
                    - If you make a change in one place and it sees that someone made a charge on the same card in a different state, it can real time, calculate the velocity that is needed for the person to travel to make it and if it is implausible, then the alarms start ringing
