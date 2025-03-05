package com.anshroshan.electric.servlet;

import com.anshroshan.electric.models.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Logger;

/**
 * Base servlet class that provides common functionality for all servlets.
 * Implements best practices for session handling, authentication, and error
 * handling.
 */
public abstract class BaseServlet extends HttpServlet {

    protected final Logger logger = Logger.getLogger(getClass().getName());

    /**
     * Checks if the user is authenticated and has a valid session.
     * 
     * @param request  The HTTP request
     * @param response The HTTP response
     * @return true if authenticated, false otherwise
     * @throws IOException      If an I/O error occurs
     * @throws ServletException If a servlet error occurs
     */
    protected boolean isAuthenticated(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession(false);

        if (session == null) {
            logger.warning("Session is null in " + getClass().getSimpleName());
            redirectToLogin(request, response);
            return false;
        }

        Customer customer = (Customer) session.getAttribute("customer");
        if (customer == null) {
            logger.warning("Customer not found in session in " + getClass().getSimpleName());
            redirectToLogin(request, response);
            return false;
        }

        return true;
    }

    /**
     * Redirects to the login page.
     * 
     * @param request  The HTTP request
     * @param response The HTTP response
     * @throws IOException      If an I/O error occurs
     * @throws ServletException If a servlet error occurs
     */
    protected void redirectToLogin(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.sendRedirect("login.jsp");
    }

    /**
     * Sets an error message and forwards to the specified page.
     * 
     * @param request      The HTTP request
     * @param response     The HTTP response
     * @param errorMessage The error message
     * @param forwardPage  The page to forward to
     * @throws IOException      If an I/O error occurs
     * @throws ServletException If a servlet error occurs
     */
    protected void setErrorAndForward(HttpServletRequest request, HttpServletResponse response,
            String errorMessage, String forwardPage)
            throws IOException, ServletException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher(forwardPage).forward(request, response);
    }


    /**
     * Stores an object in the session.
     * 
     * @param request        The HTTP request
     * @param attributeName  The attribute name
     * @param attributeValue The attribute value
     */
    protected void storeInSession(HttpServletRequest request, String attributeName, Object attributeValue) {
        HttpSession session = request.getSession();
        session.setAttribute(attributeName, attributeValue);
    }

    /**
     * Removes an attribute from the session.
     * 
     * @param request       The HTTP request
     * @param attributeName The attribute name
     */
    protected void removeFromSession(HttpServletRequest request, String attributeName) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(attributeName);
        }
    }

    /**
     * Logs an exception and sets an error message.
     * 
     * @param e            The exception
     * @param errorMessage The error message
     */
    protected void logException(Exception e, String errorMessage) {
        logger.severe(errorMessage + ": " + e.getMessage());
        e.printStackTrace();
    }


}