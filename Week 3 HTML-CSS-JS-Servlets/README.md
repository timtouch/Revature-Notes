# Gaps in knowledge
- Bubbling vs Capturing
    - What is the default?
    - How do you change to capturing?
    - How do you stop event propagation?
- Prototype inheritance
- Servlet Mapping in web.xml
---
- Why have we switched from Desktop applications to web services?
    - For the end user, it's easier to use and less likely for them to screw something up.

- *Browser*
    - Browsing the web with HTML
- Sends an HTTP request to...
- *Domain*
    - Takes the request and figures out what is being requested and sends an HTTP response bank to the browser.
    - Attached to the Domain may be a *Java* web server.

- HTML (Hypertext Markup Language)
    - Hypertext
    - Markup
        - Marks text to define how to read or parse it.
- HTML Document basic

``` HTML
<!DOCTYPE html/> <!-- Signifies the HTML standard used is HTML5-->
<html>
    <head>

    </head>
    <body>
        <element attributeName="attributeValue"></element>
    </body>
</html>
```

- **Responsiveness**
    - How a website reformats itself on different platforms in different sizes

- CSS (Cascading Style Sheets)
    - 3 ways to apply it to HTML
        - Inline
            -`<div style="color:blue">`
            - Not maintainable
        - Internal Stylesheet
            -
            ``` HTML
            <head>
                <style>
                    p {
                        color:blueviolet;
                    }
                </style>
            </head>
            ```
            - Better, but still difficult to maintain
        - External Stylesheets
            - has a separate CSS file


# JavaScript
- Where did it come from...
    - Filled the gap made from Java Applets
- What's it used for?
    - Interactive web pages
    - Talking to a web server from a browser
- Problems with JavaScript
    - You pass your JavaScript to the user who can change what the scripts do
- Every browser uses it's own engine for running JS

## Java vs JavaScript
### Java
- compiled
- strictly typed
- OOP w/ classes

### JavaScript
- interpreted
- loosely typed
    - Because of that, JS can't know how much space to allocate memory so it does it on the fly creating overhead
- OOP w/ prototypes

#### Node.js
- A runtime environment for JS
- Opens up JS to be used outside the browser

#### Just in time (JIT) compiler
- At runtime, the engine sees your code run and sees repetitive instructions running and saves these as assembly language so that if you call it again, it can recognize that and recall the saved instructions making it much faster.

#### JavaScript Datatypes
- Boolean
- Null
- Undefined
- Number
- String
- Symbol (new in ECMAScript  2015)
- Object

#### `var` keyword
``` JavaScript
var =   arrays
        objects
        primitives
        functions
```

#### Scopes
- global
    - seen by anything below it
- function
    - seen within the function

#### Hoisting
You can access a variable before it was declared
``` JavaScript
x = "hello";
var x = 5;
```

#### Truthy and Falsey values
- There's some weird things where certain values are coerced into boolean values
- **Falsy**
    - `false`
    - `null`
    - `undefined`
    - `0`
    - `NaN`
    - `''`
    - `""`
- **Truthy**
    - Everything else not *falsy*
    - `true`
    - `{}`
    - `[]`
    - `Infinity`
    - `-Infinity`
#### == vs ===
- == has type conversion
- === strictly compares values

### HTTP - Hypertext Transfer Protocol
- Protocol
    - a set of rules for sending and receiving messages

## Ajax - asynchronous JS and XML
- More of a standard than a library or framework
- sending/retrieving data without page reloads
- XMLHttpRequest object
    - send(): sends an http message (Call this last, it sends the request)
    - open(httpVerb, uri) (Call this to configure a request)
        - httpVerb
            - GET, PUT, POST, DELETEf
        - uri
            - uniform resource identifier
    - onreadystatechage
        - event handler that listens for ready state change
    - onsuccess (may not exist)- shortcut for doing something on a successful request
    - onfailure (may not exist)
    - status
        - 100, 200, 300, 400, 500, ...status codes like that
    - response
    - ready states
```
        0: unsent
        1: opened - calling the open()
        2: headers received - made contact with the server you want the info from
        3: loading - almost done, partial complete request
        4: done
```

# Java Servlet
- Nothing more than a Java object that handles protocols, mainly http protocol requests.
- A middleman of sorts so clients can't have direct access to the database for security purposes

### Containers
- The Java Web App will be run in a web container (Servlet Container)
    - We will use TomCat that contains containers
- Built off a particular standard
    - J2EE (How did I not know that)
- We *could* use J2EE, but in this case, we will use Maven to bring in any dependencies we'd need because otherwise, we'd need to make sure every computer that runs the application server to have J2EE.

## Miniproject
- try and create a front end for a bank app while pulling dummy info from a local file using ajax...maybe in JSON


## Servlet - Java class
- Each servlet handles certain requests
- Java Servlet apps packaged as .war
    - Web archive file
- Put the WAR file into the  /webapps of Tomcat (Servlet Container)
- configuration: Deployment Descriptor
    - WEB-INF folder
        - Only Tomcat will read it. Can't be navigated to.
        - web.xml
            - defines context path, parameters, servlet mapping
### Lifecycle
- user
    - Makes an http request to server(Tomcat)
- Tomcat
    - Takes the request and depending on the request path, sends it to the right Servlet
    - Creates an HTTPRequest and HTTPResponse objects
        - Servlet handles these objects
- javax.servlet/javax.http
    - servlet interface -> generic servlet (abstract) -> httpservlet  (abstract)-> yourservlet (extends) (override: doGet, doPost)

#### IMPORTANT
1. init() - initialize the servlet x1
2. service() - calls a series of other servlets x(infinity)
3. destroy() - destroys the servlet x1

### Load on startup

```XML
<web-app>
    <servlet>
        <servlet-name></>
        <servlet-class></>
        <!--The lowest positive number starts first (positive includes 0)-->
        <load-on-startup>{some number}</>
    </>
</web-app>
```

### Filter Servlet
- A filter is an object that performs filtering tasks on eitherr the request to a resource (a servlet or static content), or on the response from a resource, or both
#### Filter Interface methods
- `init(FilterConfig filterConfig)`
- `doFilter(ServletRequest request, ServletResponse response, FilterChain chain)`
- `destroy()`
### GET vs POST
- GET used for getting content
- POST is used for delivering content to and from the server

#### HTTP Codes
- 100s: info
- 200s: success
- 300s: redirects
- 400s: client error
- 500s: server error

#### web.xml
- servlet context
    - global to all servlets
- servlet config
    - for an individual servlet
    ``` xml
    <web-app>
        <!--servlet context - global to all servlets-->
        <context-param>
            <param-name></>
            <param-value></>
        </context-param>
    <!--servlet config - Individual servlet-->
        <servlet>
            <init-param>
                <param-name></>
                <param-value></>
            </init-param>
        </servlet>
    </web-app>
    ```

#### Forward vs Redirect (IMPORTANT)
##### Forward
- Reuses the existing request/response
    - Doesn't change the browser url
    - Passes on from one servlet to another servlet (or page)
    - Used mainly with GET requests or SELECT operation
##### Redirect
- Discards current requests/response, client gets a new pair (of req/res)
    - Does change the browser url
    - For leaving a domain
    - Used mainly with POST requests or database modify operations: INSERT, UPDATE, DELETE

### Front Controller Servlet
- Takes the url and parse it
    - "If the url has /home, send to the home servlet"
- A super servlet that *forwards* a request to another servlet


### Project 1 ideas
- ERS (Expense Reimbursement System)
- Message Board
- Hotel Reservation system
