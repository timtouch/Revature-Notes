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
- Spring ORM
- Spring Data
- Spring REST
- Spring REST Data
- Spring Core (IMPORTANT)
    - Handling Dependency Injection
- Spring MVC
- Spring Security
- Spring Context (IMPORTANT)
- Spring Beans (IMPORTANT)
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

### Configuration
- By beans.xml or have a class annotated w/ @Configuration
    - Creating Contexts
        - ClassPathXmlApplicationContext
        - FileSystemXMLContext
        - XmlWebContext
- All about bean-wiring
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

## Spring - AOP
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
- An extension of the BeanFactory

| BeanFactory | ApplicationContext | WebAppContext |
| :------------- | :------------- | :------------- |
| Beans are singletons | Prototype scope - You can have multiple different instances | Request scoped|
| Beans are lazy loaded - beans are null objects before they are called | Eager loaded - as soon as the application starts, all the beans are initialized and loaded | Application |
| | ClassPathXmlApplicationContext | Session |
| | FileSystemXMLContext | Global Session |
| | XmlWebContext | |

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
5. BeanPostProcessorPreInitialization
    - If Spring has any other stuff for configuration
    - `afterPropertiesSet()`
        - You can override this method
            - Implement one of the interfaces, and then override it
        - custom methods (optional)
            - Preferred way of doing this
6. BeanPostProcessorPostInitialization
    - The final clean up stage to finish up the whole process
    - The bean is finally ready
        - This is where you see the bean
7. destroy() is called
8. call custom destroys

## Spring MVC
![Spring MVC](https://terasolunaorg.github.io/guideline/1.0.1.RELEASE/en/_images/RequestLifecycle.png)
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

### 3 Major Beans for Hibernate ORM
- Data Source
- SessionFactory
- Transaction Manager
