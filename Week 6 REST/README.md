# REST (REpresentational State Transfer)
- Web service
    - Allows multiple types of applications to access it
- You are *transferring* the *state* of some *representation* of **data**
- Created by Martin Bower
## RESTful
### Constraints
1. **Uniform Interface** (ex: GET /api/pokemon/1), (POST /users/3)
- Have endpoints that make sense to people
    - GET
        - Retrieve the data
    - POST
        - Add/Update the data
    - PUT
        - Update the data
    - DELETE
        - Delete the data
2. **Client-Server Separation**
- A REST service has all connections between a client and a server
3. **Stateless**
- It should not have something that care or maintains anything about the *client*. It just cares about getting the request and sending the proper response.
4. **Cacheable**
- Must assume that your data is going to be cached
- That way, if the client makes the same request again in a short time period, it shouldn't have to go all the way back to the server to get the info.
- Don't create a REST service in which data is known to be constantly changing (Within a reasonably short period of time). Otherwise, if it is cached, the client cannot trust the data.
5. **Layered**
- It may not be true that only one servlet handles the api request. There may be multiple layers of servlets across multiple machines that handles the request.
6. *Code on Demand* (Optional)
- In a REST service, it could give you code that you can run.

## SOAP (Simple Object Access Protocol)
- Get a decent understanding about it

### Terminology
- SoA (Service-Oriented Architecture)

### Jersey
<servlet-class>
    org.glassfish.jersey.servlet.ServletContainer
</>
<init-param>
<param-value>
    jersey.config.server.provider.packages
</>
</>
<load-on-startup>1</>
