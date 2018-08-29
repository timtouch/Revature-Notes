# Panel Stuff
- **Exception handling in Ember???**

### JRE
- JVM + javalibs

### NodeJS
- JS RuntimeEnvironment
    - JS Interpreter + libs

-> for servers or for development frameworks
    - Frameworks that frontend developers can use as tools to make things easier

- npm: node package management
    - package management
        - a centralized way of having repositories and managing them
        - we can install the packages with `npm install {package}`
    - install ember-cli
        - Used to build a project in Ember.js
    - you can bundle your project to make it more portable
---
# Ember.js
- framework for building "Ambitious" web apps.
- Old way
    - Client <--> Server
        - Constant exchange for new resources
- New way
    - Server gives client all that they need to run the app
    - If the client needs to update something, they can occasional talk to the server
    - Seems like a lot of data to load each time, but we cache it so every time we visit, it loads faster
## MVC (Model-View-Controller)
- About separation of concerns
    - Model
        - Stores the data and maintains the state of the object
    - View
        - In charge of how to display the data in the model
    - Controller
        - The "glue" that pulls the Model and View together
            - If the model changes, so does the view and vice versa
        - It is your business logic/service layer

## Ember objects
### Router
- It maps the URL in your application to the routes that you've defined.
- Has multiple routes
    - **Route**
        - The individual view or section that you define
        - A particular view that you want to present to the user
        - route properties
            - **model** *
            - **controller** *
                - Handling things like event handling
            - helper
                - Kind of like a controller but for helper methods
            - service
                - Reuse logic in more that one route
            - **template** *
                - The equivalent to your view
                - A reusable section of code
## Routes
- It is responsible for displaying templates, loading data, and setting up application state
## Templates
-
## Controllers
- A routable object which receives a single property from the Route - `mode` - which is the return value of the Route's `model()` method.
## Models
- Objects that represent the underlying data that your application presents to the user.
## Components
- Used to encapsulate markup and style into reusable content.
- Consists of two parts: a JS component file that defines behavior, and its accompanying Handlebars template that defines the markup for the component's UI.
## Helpers
- Can develop helpers that make it simple to output variable into your brower's console, or activate the debugger from your templates.
## Adapters
- Determines how data is persisted to the backend data store. Things such as the backend host, URL format, and headers used to talk to a REST API can all be configured in an adapter.
## Serializers
- Format the data sent to and received from the backend store.


### Data-binding
#### Ember expressions
- `{{varName}}`
    - Handlebars.js

## npm
- [npm repository](https://www.npmjs.com/)
- `npm install -g packagename@versionnumber`
    - -g option to install globally
    - version number after @ symbol
- Packages we need:
    - bower
    - ember-cli
- `bower install packageName -sa`
    -whats -sa?

## Ember Project
- Create new project
    - `ember new project-name`
- Start project command
    - `ember serve`
        - `ember s` as a short hand
- package.json
    - contains dependencies
- `/dist` folder is like our target folder for java
- Environment Variable
     - In `environment.js`
- \*.hbs (handlebars)
    - Where we can have some html content
- `app.js`
    - The heart of our project
    - Handles everything but we shouldn't need to touch on this
### Useful Commands
- **Generate Route**
    - `ember generate route routeName`
    - Generates the template.hbs and the route.js files
- **Generate Model**
    - `ember g model modelname`
- **Generate Component**    
    - `ember g component component-name`
- **Generate Controller**
    - `ember g controller controller-name`
### Routes
- The Ember router maps the current URL to one or more route handlers. A route can do several things:
    - It can render a template
    - It can load a model that is then available to the template
    - It can redirect to a new route, such as if the user isn't allowed to visit that part of the app.
    - It can handle actions that involve changing a model or transitioning to a new route
### Templates
- Ember uses the [Handlebars templating library](http://www.handlebarsjs.com/) to power our app's user interface
    - `{{data-bound-value}}`
- Dynamic content inside a Handlebars expression is rendered with data-binding.
    - This means if you update a property, your usage of that property in a template will be automatically updated to the latest value.

### Components
- Ember components are used to encapsulate markup and style into reusable content.
- Components consist of two parts: a JavaScript component file that defines behavior, and its accompanying Handlebars template that defines the markup for the component's UI.
- Components must have at least one dash (`-`) in their name. This prevents clashes with current or future HTML element names, aligns Ember components with the W3C Custom elements spec, and ensures Ember detects the components automatically
    - EX: `blog-post` OK
    - EX: `post` WRONG

### Controllers
- A routable object which receives a single property from the Route - `model` - which is the return value of the Route's `model()` method.
- The model is passed from the Route to the Controller by default using the `setupController()` function. The Controller is then often used to decorate the model with display properties such as retrieving the full name from a name model.
- A Controller is usually paired with an individual Route of the same name.
### Models
- Models are objects that represent the underlying data that your application presents to the user. Different apps will have very different models, depending on what problems they're trying to solve.
### Adapter
- Has the endpoints to connect to an API (REST/JSON/Other)
- RESTAdapter
    - JSONAdapter
        - Much more strict
### Serializer
- Serializes and deserializes data retrieved through the adapter
### .hbs
- `{{outlet}}`
- `{{input value}}`
### ember-cli-build
- can add things like bootstrap

### Useful Ember js resources
- [Ember](https://www.emberjs.com/)
- [Ember Twiddle](ember-twiddle.com)

### Possible Question for 1-on-1
- What would you do to migrate your project to Ember.js?
---
# DevOps

> DevOps integrates developers and operations teams in order to improve collaboration and productivity by automating infrastructure , automating workflows and continuously measuring application performance

- A combination of Developer and Operator roles
    - Sharing responsibilities between the Developers and Operators
- It's a culture, a mindset, a meme
- You want to deploy production code ASAP.
- By writing small chunks of code, it allows one to increase the frequency of deployments
- Improves ability to adapt to changing demands or occurring bugs
- Need a Source Control System to help manage, track and document all of the changes to both the application code and configuration management code.
## Benefits of DevOps
- Faster time to market
    - Adds a competitive advantage
- More focus on improving the business

## In the End
- Innovate faster
- More responsive to business needs
- Better collaboration
- Better quality
- More frequent releases

## Automation
- Automate Code Testing
- Automate Workflows
- Automate Infrastructure
- Automate Everything

## Continuous Integration
- How would you coordinate with other project members?
    - You'd have a central git repository
    - Sometimes, code may only work on your machine, but not your other teammates
        - Have a **build server** that will build the actually project and then deploy it. It is the arbiter to make sure that a developer's environment doesn't affect the building of the code.
    - If you rebuild after every commit, you can find exactly when it broke, what broke, and who broke it.
- By always pushing new builds and testing after each build, we can make sure that our code is always...{Fill this in}
- You can have a separate server to make sure the coding styles are consistent between developers

## Continuous Delivery
- Not enough to build a properly working .jar file, assure that it is always in a deployable state
- Testing server
    - for different environments
- QA server
    - dummy version
    - What do they think of how it looks?
- Staging
    - Production

## DevOps history
- Old way of software development
    1. Have a client who talks with the project manager to give their requirements
    2. Project manager passes these requirements to the programmers
    3. Programmers will take time to build the software and once it's complete, show it to the client.
    4. The client may be unhappy about the result or the result is buggy so back to step 3.
    5. Operations - has to handle the setup of the product and make sure that the business won't be down because of the new product.
        - system admins
        - infrastructure
        - delivery
- **Agile**
    - 2 wk sprints
    - constant contact w/ client
    - rapid turnaround


## Linux
- You want a stable place that doesn't take a ton of resources to run your application.
- fork on UNIX
- kernel developed by Linus Torvalds
    - What is a kernel?
        - Takes commands of software to commands of hardware.
- GNU project
    - The university had tools and libraries but no kernel.
    + so they combines the GNU library with the Linux kernel which becomes the Linux OS

### Distros (Distributions)
- Ubuntu
- Red Hat Enterprise Linux
    - Big is US
    - Enterprise servers is not free since companies have to pay for support
- OpenSuse
    - Big in Europe
- What do the Enterprise versions have that the normal ones don't?
    - All their software packages are in the old but stable versions.
    - Has a certain setup for network configurations

#### Why host on Linux?
- It's free
- stable
- low resource usage
- easy/versatile configuration
- package management
    - You can batch install or batch update software

#### Everything is a file in Linux
- folder is a text file that lists/links other folders/files
- application configurations are in text files
- every file is either *plain text* or *binary code*

### How to get into a Headless Linux Server
- Headless server
    - There is no direct way of interacting with the server.
        - It's just a box, sitting in a warehouse.
    - Simply a server that is hosted somewhere that you remotely connect to.
        - Usually without a desktop environment
        - Usually with only a terminal
    - ssh (secure shell)
        - secure connection to another computer
        - shell: a virtual interpreter/terminal emulator
            - A program that interprets your commands...and more. I should add more
    - bash: borne again shell
### Linux Commands
- `pwd`
- `cd [directory]`
    -  `~`
    - `/`
- `ls -la`
    - `-a`
        - Shows all hidden files and directories as well
- `ssh`
- `scp`
    - For transferring files from
    - `scp -i location/of/pem/file /location/of/webapp/target/webapp.war ec2-user@ip.address:/home/ec2-user/apache-tomee-plume-7.0.4/webapps`
#### Bash stuff
- `#!/bin/bash[sh]`
- `echo "I'm in $PWD"`
    - This $PWD is a variable
- `echo "I'm in $(pwd)"`
    - This $(pwd) is a sub-shell that runs and returns a value
- `>`
    - Output
- `<< EOF`
    - Input until EOF
- `2` is the error channel, system err out
- `rm` or `rmdir` to remove files or directories
    - `-r` to remove recursively, `-f` to forcibly remove
- Bash Functions
    - `hello () {echo "Hello",  $1;}`
    - `mkcd() { mkdir -p "$1" && cd "$1"; }`
    - Beware of spaces
- `less`
- `tail`
    - `-n` number of lines
- `head`
- .bash_profile has the setup for configuration
- .bashrc
- .bash_history has the history of commands of the last session
- `sudo yum install -y`
- `curl`
- `wget`
    - For downloading

### Folders
- `/bin`, `/user`, `/var` are for scripts

### Terminal shortcuts
- `Ctrl + l` clears the screen
- `Ctrl + a` brings cursor to the start of the string

### EC2
- They are just virtual machines
- But they have these cool features:
    - **Elastic Block Store**
        - A hard drive that is readable by any computer
        - Kind of like an external hard drive
    - **Security Groups**
        - Manage your inbound and outbound rules
    - **Elastic Load Balancer (ELB)**
        - Balance the load of the network between servers evenly
        - Stands between the client and the EC2 instances
    - **Auto Scaling Groups**
        - You want to scale your resources dynamically such that you use only as much as you need to.
            - Scales turning on/off servers as demand changes
## Ubuntu things
- There are many ways to download and install Java and other things to our
    - Manually
    - Adding a repository for our software package manager
- `/opt/` is where you want to store your installation files
- `etc/environment` is where you want to add global environment variables
- `CATALINA_HOME`
- `JAVA_HOME`
- `M2_HOME`
- `M2=$M2_HOME/bin`
### Deploying to AWS
- Make sure your security group
- `chromd` -timed execution of scripts

## Jenkins
- A CI Automation tool
- We can have a dedicated server for Jenkins or have it on the same server
- Access Token for Github:  9a87dc1c18f4f4c7847b9b0e0d03f4a14d83d5fb
- Install the maven to where Jenkins can see it
    - *If it doesn't work, sudo it*
    - `sudo /opt/apache-maven-3.5.4/bin/mvn install:install-file -Dfile=ojdbc8-12.0.1.jar -DgroupId="com.oracle.jdbc" -DartifactId="ojdbc8" -Dversion=12.0.1 -Dpackaging=jar
    `
-  Other access token: 6a480fe6c39eb2ee62fb7def96b14ced8392b73c
### Plugins
- Deploy to Container
- Maven Integration

### Jenkins
- Global Tools Configuration
    - To setup what env var you need
- Problem with wifi, mess with Global Security, crumbs, proxy (CSRF Protection)
