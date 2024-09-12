package com.ucb.skibidi.utils;

import com.ucb.skibidi.config.exceptions.InvalidInputException;

public class ValidationUtils {




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
        if (!isEmailValid(email)) {
            throw new InvalidInputException("Invalid email");
        }
    }

    private static boolean isNullOrEmpty(String str) {
        return str == null || str.isEmpty();
    }

    private static boolean isNameValid(String name) {
        return name.matches("^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
    }


    private static boolean isEmailValid(String email) {
        return email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");
    }





}
