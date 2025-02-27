package com.anshroshan.electric.service;

import com.anshroshan.electric.dao.UserDAO;
import com.anshroshan.electric.model.User;

public class UserService {

    private UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    // Add a new user (future admin or extended functionality)
    public void addUser(User user) throws Exception {
        userDAO.addUser(user);
    }

    // Get user by ID (for login or authentication)
    public User getUserById(String userId) throws Exception {
        return userDAO.getUserById(userId);
    }
}