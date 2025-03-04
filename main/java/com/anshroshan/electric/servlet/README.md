# Servlet Best Practices

This document outlines the best practices for servlet development in the Electric Bill Payment System.

## Servlet Structure

All servlets should follow a standardized structure:

1. Extend `BaseServlet` to inherit common functionality
2. Use proper authentication checks
3. Follow consistent error handling
4. Use proper session management
5. Follow RESTful principles where appropriate

## BaseServlet

The `BaseServlet` class provides common functionality for all servlets:

- Authentication checks
- Session management
- Error handling
- Logging

## Authentication

Always check authentication at the beginning of each servlet method:

```java
if (!isAuthenticated(request, response)) {
    return;
}
```

## Session Management

Use the helper methods provided by `BaseServlet` for session management:

```java
// Store in session
storeInSession(request, "attributeName", attributeValue);

// Remove from session
removeFromSession(request, "attributeName");
```

## Error Handling

Use the helper methods provided by `BaseServlet` for error handling:

```java
// Set error and forward
setErrorAndForward(request, response, "Error message", "error.jsp");

// Log exception
logException(exception, "Error message");
```

## Data Flow Between Servlets

When passing data between servlets:

1. Use session attributes for data that needs to persist across multiple requests
2. Use request attributes for data that only needs to be available for the current request
3. Use request parameters for data submitted by forms

Example:

```java
// Store in session for persistence across requests
storeInSession(request, "payment", payment);

// Store in request for current request only
request.setAttribute("payment", payment);

// Forward to another servlet
request.getRequestDispatcher("anotherServlet").forward(request, response);
```

## Redirects vs Forwards

- Use `forward` when you want to pass control to another servlet/JSP without the client knowing
- Use `redirect` when you want the client to make a new request to another URL

Example:

```java
// Forward (server-side)
request.getRequestDispatcher("page.jsp").forward(request, response);

// Redirect (client-side)
response.sendRedirect("anotherPage.jsp");
```

## Servlet Lifecycle

Remember the servlet lifecycle:

1. `init()` - Called once when the servlet is first loaded
2. `service()` - Called for each request (usually not overridden directly)
3. `doGet()`, `doPost()`, etc. - Called based on the HTTP method
4. `destroy()` - Called when the servlet is unloaded

## Best Practices for Payment Processing

For payment processing specifically:

1. Always validate input data
2. Use transactions for database operations
3. Store payment information in both session and request for reliability
4. Clear sensitive payment data after processing
5. Provide clear feedback to users about payment status
6. Log all payment operations for audit purposes

## Logging

Use the logger provided by `BaseServlet` for consistent logging:

```java
logger.info("Informational message");
logger.warning("Warning message");
logger.severe("Error message");
``` 