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
    - **Gateway service**
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

### Hystrix
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
