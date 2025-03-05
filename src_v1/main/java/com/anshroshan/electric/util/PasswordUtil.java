package com.anshroshan.electric.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordUtil {

    public static String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashedBytes = md.digest(password.getBytes());
        StringBuilder sb = new StringBuilder();
        for (byte b : hashedBytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }

    // Optional: For future password verification if needed
    public static boolean verifyPassword(String password, String hashedPassword) throws NoSuchAlgorithmException {
        return hashPassword(password).equals(hashedPassword);
    }
}