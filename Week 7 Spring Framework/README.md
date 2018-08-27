# Panel Stuff
- **Exception handling in Spring**
# What I Don't Know
- Spring Boot
    - Spring Boot is a project that is autoconfigured and has runs on it's own Tomcat Server
    - In other words, you only have to define the packages you want to use (Spring MVC, Spring REST, etc.) and Spring Boot handles configuring them for use
    - All in all, Spring Boot is a project built on the top of the Spring framework. It provides a simpler and faster way to set up, configure, and run both simple and web-based applications.
    - Notable features
        - **Auto-configuration**: It sets up your application based on the surrounding environment, as well as hints what the developers provide.
        - **Standalone**: Literally, it's completely standalone. Hence, you don’t need to deploy your application to a web server or any special environment. Your only task is to click on the button or give out the run command, and it will start.
        - **Opinionated**: This means that the framework chooses how to do things for itself.
- What are the different ways you can set an application context?
    - xml
    - annotation
    - pure java
- Bean Lifecycle
- Spring ORM
    - Used in conjunction with another ORM framework such as Hibernate to enable using AOP for sessions and transaction management
    -There are a lot of advantage of Spring framework in respect to ORM frameworks. There are as follows:
        1. **Less coding is required**: By the help of Spring framework, you don't need to write extra codes before and after the actual database logic such as getting the connection, starting transaction, commiting transaction, closing connection etc.
        2. **Easy to test**: Spring's IoC approach makes it easy to test the application.
        3. **Better exception handling**: Spring framework provides its own API for exception handling with ORM framework.
        4.**Integrated transaction management**: By the help of Spring framework, we can wrap our mapping code with an explicit template wrapper class or AOP style method interceptor.


# Framework
- The skeleton or scaffolding of a structure
    - Feed me configuration, and I'll handle the hidden, boilerplate stuff
- Inversion of Control

# Spring
- The Framework of Frameworks
- To back up its attack on Java complexity, Spring employs four key strategies:
    - Lightweight and minimally invasive development with POJOs
    - Loose coupling through DI and interface orientation
    - Declarative programming through aspects and common conventions
    - Eliminating boilerplate code with aspects and templates
- The Problem:
    - We waste time writing a lot of code fluff whenever we want to add some business logic
    - Imagine this:
    ``` Java
    RandomService {
        import Dao;
        Dao d;

        RandomService(Dao d){
            this.d = d;
            System.out(...);
        }


        thisOneMethod(){
            // Some code
            System.out(...);
            try {
                // Maybe some of the code in here is for business logic
            } catch (Exception e ){
                // Handling the exception
            }
        }
    }
    ```
- The Solution
    - Spring sets up all of the fluff for us so we don't have to write it ourselves and focus on the meat
- The Goal:
    - The goal is to completely decouple your source code. Let Spring handle the DI, itself
- The Spring Container
    - It is tracking the connections, creating the objects, and managing the life cycle of those objects
- How does it do it?
    - It utilizes Reflection to handle the Core and AOP functionality
    - Security Concerns
        - You have to be careful on how you annotate as you can create security flaws
## Spring Frameworks
- Spring Cloud
- Spring AOP (IMPORTANT)
    - Aspect Oriented Programming
    - Aspect Class
        - Has rules with a super try
        - You can define the overall rules of how to handle those exceptions
- Spring ORM (IMPORTANT)
- Spring Data
- Spring REST
- Spring REST Data
- Spring Core (IMPORTANT)
    - Handling Dependency Injection and IoC
- Spring MVC
- Spring Security
- Spring Context (IMPORTANT)
- Spring Beans (IMPORTANT)
- Spring Boot (IMPORTANT)
- etc...


## Spring Features
- It's lightweight
    - It's like under 1 MB
- Inversion of Control (IoC)
    - Having the programmer give up control over parts of their code.
    - By using Dependency Injection (DI)
        - Usually, you'd have to create the objects, then pass it to another object through their constructor or setter
        - *bean-wiring*
            - Constructor Injection
            - Setter Injection
            - Autowiring
                - Letting Spring take control and use the most conventional way for DI
                - You can wire it by:
                    - Type (default)
                    - Name
    - Changes to classes don't propagate further than the place that handles the DI
- Aspect Oriented Programming (AOP)
    - About taking secondary, tangential, created code that isn't directly related with the business logic and separating them.  In other words, it's about separating your business logic from your secondary code.
        - Secondary Code Includes:
            - Logging
            - Exception Handling
            - Security
- Bean Container
    - The Context object that registers and maintains all of your beans
    - In charge of your beans life-cycle
- Modular
    - All kinds of frameworks for it out there. [See Spring Frameworks](#spring-frameworks)

### Configuration
- By beans.xml or have a class annotated w/ @Configuration
    - Creating Contexts
        - ClassPathXmlApplicationContext
        - FileSystemXMLContext
        - XmlWebContext
- All about bean wiring
 -The request, session, and global session scopes are only available if you use a web-aware Spring ApplicationContext implementation (such as XmlWebApplicationContext). If you use these scopes with regular Spring IoC containers such as the ClassPathXmlApplicationContext, you get an IllegalStateException complaining about an unknown bean scope.
    - \<bean\>
    - component-scans
    - aop-scans
        - The scans are scanning for annotations
- Stereotypes
    - @Component
        - The most generic type
        - Specializations:
            - @Service
            - @Repository
        - The Specializations has a few additional features that come with it.
    - @Controller
    - @RESTController

# Spring - AOP
- [Aspect](https://docs.jboss.org/aop/1.0/aspect-framework/userguide/en/html/what.html)
    - Code that is injected
    - *Cross-cutting concern*
        - Something that cuts across your business logic code, but not necessarily related to the flow of that application
- AOP:
    - injecting aspects when needed
- JoinPoint:
    - The method where the aspect is injected
- Pointcut:
    - execution point
    - How you find that method
        - You can specify which method(s) to choose. By class, package, return type, arguments,partial method name matching
- Advice:
    - These are your annotations:
        - @Before
        - @After
        - @AfterReturning
        - @AfterThrowing
        - @Around - Most powerful
    - Generally want to use from order of least powerful to most powerful
- Configure:
    - `<aop:auto-proxy/>`
    - The last part we need before any of this stuff above, works
### Application Context vs BeanFactory
- Both manage the Bean Lifecycle
- An extension of the BeanFactory

| BeanFactory | ApplicationContext | WebAppContext |
| :------------- | :------------- | :------------- |
| Beans are singleton scope - one container with one bean | Prototype scope - You can have multiple different instances | Request scoped|
| Beans are lazy loaded - beans are null objects before they are called | Eager loaded - as soon as the application starts, all the beans are initialized and loaded | Application |
| | ClassPathXmlApplicationContext | Session |
| | FileSystemXMLApplicationContext | Global Session |
| | XmlWebApplicationContext | |

### General Lifecycle
- Setup
    - Object init
    - Handle Dependencies
        - Beans are handled
    - Custom Init
    - Bean is ready
- Teardown
    - when container shuts down
    - destroy object
    - custom destroy

### Bean Lifecycle *IMPORTANT*
- Give an overview and the specifics of the Bean Lifecycle
![Spring Bean Lifecycle](https://i.stack.imgur.com/kpcdR.png)
1. Initializing Bean
    - beans starts out as empty
2. "populate bean"
    - With their property values
3. "if BeanNameAware"
    - `setBeanName()`
    - This is how it knows what we set as bean names (maybe)
4. "if BeanFactoryAware"
    - `setBeanFactory()`
5. PreInitialization
    - If Spring has any other stuff for configuration
6. `afterPropertiesSet()`
        - You can override this method by implementing InitializingBean interface, and then override it
7. custom methods (optional)
    - Preferred way of doing this
8. BeanPostProcessor PostInitialization
    - The final clean up stage to finish up the whole process
    - The bean is finally ready
        - This is where you see the bean
9. DisposableBean's destroy() is called
10. call custom destroys

# Spring MVC
![Spring MVC](https://cdn-images-1.medium.com/max/629/1*YZ-MfuEX-GwjLjyv9CLDbg.jpeg)
- In the context of Web Applications
- request is sent to:
- The Request Dispatcher
    - The "master servlet" or "front controller"
    - DispatcherServlet
        - Runs a Web Application Context
- HandlerMapping
    - Figures out what this endpoint means to the application
    - Once figured out, passes through the RD to the...
- Controller
    - Basically your servlet with your doGet() and doPost()
    - The part we actually have to program
    - Talks to the Beans, Services, and Repositories
- View Resolver (Not Needed for a REST application since it only sends raw JSON data)
    - Translate the html string to the actual document and sends it back the to front controller and that sends back a response
    - Talks to your web app and html files

### JSR 303
- Java Specification Request 303
- A way of checking if a bean is valid

### 3 Major Beans for Hibernate ORM
- Data Source
- SessionFactory
- Transaction Manager

# [Spring ORM](https://docs.spring.io/spring/docs/3.0.x/reference/orm.html)
- A Spring framework that is a library of annotation that is used to setup with any ORM frameworks
- Easier Testing
- Common data access exceptions
- General resource management
- Integrated transaction management

# [Spring Boot](https://dzone.com/articles/what-is-spring-boot)
- What is a Spring Boot Project?

## Dealing with talking to Ember
- Map the key to the object in a
- Katharsis
    - Katharsis for Spring

## TOPICS FOR QC
- Talk about what is Spring?
- Know bean Lifecycle
    - The broad view, the specifics, and
- How you annotate a bean
- How you setup the bean application context
- How you inject dependecies
    - Bean wiring
- Autowiring
- Spring AOP
- Stereotypes
    - @Component..
- Cross-cutting concerns
- JoinPoint
- Spring MVC
    - The Control Flow
    - What are the different objects that Spring helps you go through
        - DispatcherServlet
- Creating a Controller in your head with annotations
    - Know about how to get path variable
    - ResponseBody class
- InternalView Resource Resolver
    - Talk about suffix and
    - How you'd implement REST pattern
- Spring Boot
    - Talk how it differs from not Boot
    - Talk about how it runs in it's own server
    - How it uses the application.properties
    - How it is waiting for changes and apply it  
- Spring data
    - Uses Spring Boot
- Spring ORM
    - The TransactionManager
        - How it works as the middle man bt Hibernate and Spring
-
