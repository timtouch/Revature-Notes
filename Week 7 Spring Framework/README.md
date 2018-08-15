# Framework
- The skeleton or scaffolding of a structure
    - Feed me configuration, and I'll handle the hidden, boilerplate stuff
- Inversion of Control

# Spring
- The Framework of Frameworks
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
    - The goal is to completely decouple your source code.
- The Spring Container
    - It is tracking the connections, creating the objects, and managing the life cycle of those objects
- How does it do it?
    - It utilizes Reflection to handle the Core and AOP functionality
    - Security Concerns
        - You have to be careful on how you annotate as you can create security flaws
## Spring Frameworks
- Spring Cloud
- Spring AOP (Important)
    - Aspect Oriented Programming
    - Aspect Class
        - Has rules with a super try
        - You can define the overall rules of how to handle those exceptions
- Spring ORM
- Spring Data
- Spring REST
- Spring REST Data
- Spring Core (Important)
    - Handling Dependency Injection
- Spring MVC
- Spring Security
- Spring Beans (Important)
- etc...

## More on Spring
- Like the Session in Hibernate, it watches for changes of

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

## Configuration
- beans.xml or have a class annotated w/ @Configuration
- All about bean-wiring
    - <bean>
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

### Spring - AOP
- [Aspect](https://docs.jboss.org/aop/1.0/aspect-framework/userguide/en/html/what.html)
    - Code that is injected
    - Cross-cutting concern
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
