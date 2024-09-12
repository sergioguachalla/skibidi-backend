package com.ucb.skibidi.utils;

import com.ucb.skibidi.config.exceptions.InvalidInputException;

public class ValidationUtils {

    /*
     * Validates if a string is null or empty
     * @param str the string to validate
     * @return true if the string is null or empty, false otherwise
     */
    private static boolean isNullOrEmpty(String str) {
        return str == null || str.isEmpty();
    }


    /*
        * Validates if a name is valid
        * @param name the name to validate
        * @return true if the name is valid, false otherwise
     */
    private static boolean isNameValid(String name) {
        return name.matches("^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
    }


    public static void validateName(String name) {
        if (isNullOrEmpty(name)) {
            throw new InvalidInputException("Name is required");
        }
        if (!isNameValid(name)) {
            throw new InvalidInputException("Invalid name");
        }
    }

    public static void validateEmail(String email) {
        if (isNullOrEmpty(email)) {
            throw new InvalidInputException("Email is required");
        }
    }





}
