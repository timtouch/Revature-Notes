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
