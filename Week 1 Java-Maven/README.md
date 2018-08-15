# Additional Things to Study
- [Range of Topics to study for Java](https://www.geeksforgeeks.org/java/)
- Know String methods
- Know Collection Interface and their methods and differences (Hashmap and Hashtable)
    - List
    - Queue
    - Set
- [JVM vs JRE vs JDK](https://www.geeksforgeeks.org/differences-jdk-jre-jvm/)
- Knowing about reading and writing files 
- Bonus:
    - Comparator vs Comparable
    - Collections Class vs Collection Interface
---
1. Can volunteer to give presentations of the technologies that we are learning
2. We have interviews every week
##### OCA - Java Programmer 1
- Try and get it as soon as possible.
- You will get reimbursed only IF you pass.
##### ENTHUWARE
- Use this to practice for the OCA.

# Java
- OOP
- Oracle
- WORA (Write Once, Run Anywhere) - Platform Independence
  - JVM (Java Virtual Machine)
    - Stack and Heap
      - Stack keeps track of function call chains and context values such as object references
      - Heap contains the actual object
    - Distributed across several systems
    - Virtual Machines
      - Taking bits and pieces of that hardware and combining it virtually for it's own use as it's own hardware
## Benefits of Java
- **Verbosity**
  - The way Java is written is very self descriptive
- **Garbage Collector**
  - As you create objects, they may no longer be referenced. They still take up space, so somehow you have to clear space in the memory before it causes a stack overflow.
- **Mature, Popular, Open**
  - That is to say that since many people use it, there is a lot of support and information for the language.
  - It's been used for a while so large companies know it as a trusted solution
- **Multi-threaded**
  - What's the big deal?
    - It scales way better than a single threaded application.
- **Multi-Paradigm**
  - Handles many different "styles" of programming
    - OOP, Functional programming, procedural
## OOP: object-oriented programming*
- **Abstraction**
  - We use abstraction to make our life easier
    - Java / OS -> ISA (Instruction Set) (x86) -> Functions -> NAND gates -> V = IR -> nature itself
  - Object Abstraction
    - Where you take the important details of the object to model it.
    - Where you conceptualize and try to represent the important details of that object, ignoring the irrelevant (to the user) details
- **Encapsulation**
  - Short Answer (Protecting Data)
  - Long Answer
    - The object wants to maintain its own state (the current values of the properties of the object). It is responsible for its own state. No other objects should be able to directly manipulating its state.
- **Inheritance**
  - Short Answer (Code Reuse)
  - Long Answer
    - Point of Inheritance is to use the same code again and extend it if you need it more specialized
- **Polymorphism**
  - Short Answer (Variable Class Reference)
    - Where classes can represent a parent class
    - In the JVM, the stack can contain a variable of type Child class but references the Heap's object of type Parent class

- JRE vs JDK
  - JRE can run the Java application
  - JDK can compile and run the Java application
- JDK has the Java Standard Library

## Java basics
- Java secretly imports a bunch of Standard Library stuff
- Packages are basically used as name-spaces so that classes with the same name can be differentiated
  - How to assign a package?
  - When assigning a class to a package, the compiled class must be in the defined package
- The compiler ignores anything after the "//" up until the end of line character
- JavaDocs are useful kinds of comments


### Primitive Data Types
- Data types that exists outside of an object
  - Integer types:
    - *byte* - 8 bits (-128 to 127)
    - *short* -16 bits (-2^15 to 2^15 - 1)
    - *int* - 32 bits (-2^31 to 2^31 - 1)
    - *long* - 64 bits (-2^63 to 2^63 - 1)
  - Floating point types:
    - *float* - 16 bits
    - *double* - 32 bits
  - Characters:
    - *char* - 16 bits
  - Booleans:
    - true/false

- When creating files in Windows, change the option to see hidden extensions

### Packages
- Structuring your project manually if you put your classes in packages. Basically, it determines the folder structure of how you store your classes.
  - `javac com.location.package.ClassName.java`
    - You have to be in the directory above the package to use this command.
    - Using `java` is very similar as well
  - If you want to save the compiled Java code to a different folder
    - `javac ClassName.java -d target/folder`
- Find a way to run the application from the root folder without going inside target folder.
- The `-cp` option sets the CLASSPATH.
  - `java -cp $SetBaseDirectory $ClassInPackage`

### Wrapper Classes for Primitives
- A class used to "wrap" around something.
- Integer, Double
- Why do this?
    - They can give you a lot of useful methods such as parseInt()
    - **Autoboxing**
        - Whenever Java can see an opportunity to convert something, it will wrap the primitives in their respective wrapper class
    - **Unboxing**
        -
#### Object-instance
- An object is some instance in memory of a data type with field/members/variables representing state and functions/methods to control it

#### Class
- Blueprint, prototype, type of an object

##### Constructor
- default/no args for free (If I don't write one, I'll get this one)(If I do write a constructor, Java doesn't create this freebee one)
  - Sometimes, the frameworks rely on having a no-args constructor so you should get into the habit of creating one for your classes.

##### Variable Scope
- **Declare**
  - Creating the reference
- **Define**
  - Setting the value

1. **static/class/"global"**
    - Shared values between all instances of a class
2. **instance/object**
    - The variable exists as long as the object exists
    - The variable is unique to each object
3. **method/local**
    - Lives and dies within the scope of that method
4. **block/loop**
    - Exists within the curly braces, `{}` such as when using for-loops

##### Access Modifiers
- You can control what other classes have access to this class's variables and methods
1. **Private**
    - Only other methods and variable within that class can access it, not even child classes.
2. **(default)**
    - Extends permission to classes within the same package
3. **Protected**
    - Further extends permission to child classes outside of the package
4. **Public**
    - Extends permission to everyone

#### Arrays
  - A sequential list of values in memory such that they can be access by incrementing from the 0th index by **index x sizeOfValue**

#### Static (keyword)
- **field** in a class exists for all instances

#### final (keyword)
- "constant"
  - a final variable cannot be changed
    - `final int PI = 3`
  - a final method cannot be overridden
    - `final void method()`
  - a final class cannot be extend
    - `final class DunderMiffPaper {}`

#### finally (try/catch)
- paired with a try and possibly a catch block

#### Thrown Exceptions
- doesn't have to have a try/catch block when it occurs, can use **throw** to pass the buck

#### finalize (method)
- method that is run when GC finds the object

#### Singleton (pattern)
- if you want only a single instance of a class at all times

## Git workflow
- When using `git init`, within your workspace folder, a .git folder is created
  - **.git**
    - *staging*
      - `git add`
        - adds the changes to staging
      - `git commit`
        - saves the staged changes as the new *HEAD*
    - local repo *HEAD*
      -  `git push`
        - pushes your local changes to the remote repo
      - `git diff HEAD`
        - find changes with tracked files
      - `git merge`
        - merging branches together
    - remote repo
      - `git pull`
        - pulls all the changed files and add it to your workspace (it integrates the changes directly to your workspace)
      - `git fetch`
        - like `git pull` but doesn't merge the changes
      - `git clone`
        - when you don't have
- *Pull before you push*


## Collections API
![Collections API](https://d1jnx9ba8s6j9r.cloudfront.net/blog/wp-content/uploads/2017/05/Collection-framework-hierarchy.png)

#### Multi-threading
- Why would you want multi-threading?
    - Computers have multiple processors. Single threaded applications only utilize one of them. But multi-thread applications can utilize all of them. This also makes the application much more scalable.

#### Unit Testing
- What is a unit? The smallest part that you can test.
- Why unit test?
    - To automate testing

#### Maven
- What is it?
    - A build tool
- How to build a Maven project from scratch (https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html)

    -`mvn archetype:generate -DgroupId=com.location.package -DartifactId=MavenDemo -DarchetypeArtifactId=maven-archetype-quickstart`
    - **NOTE** For *Windows*, surround values after "=" with quotes("");
- How to compile your project?
 - Where the pom.xml exists
    -`mvn package`
