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

    public static void validateIdNumber(int idNumber) {
        if (idNumber == 0) {
            throw new InvalidInputException("Id number is required");
        }
        if (!isIdNumberValid(idNumber)) {
            throw new InvalidInputException("Invalid must be between 5 and 9 digits");
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
    private static boolean isIdNumberValid(int idNumber) {
        return String.valueOf(idNumber).length() > 4 && String.valueOf(idNumber).length() < 10
                && String.valueOf(idNumber).matches("[0-9]+");
    }





}
