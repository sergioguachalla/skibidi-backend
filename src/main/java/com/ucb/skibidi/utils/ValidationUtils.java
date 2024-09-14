package com.ucb.skibidi.utils;

import com.ucb.skibidi.config.exceptions.InvalidInputException;

import java.util.Date;

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

    public static void validateAddress(String address) {
        if (isNullOrEmpty(address)) {
            throw new InvalidInputException("Address is required");
        }
        if (!isAddressValid(address)) {
            throw new InvalidInputException("Invalid address");
        }
    }


    private static boolean isAddressValid(String address) {
        return address.length() < 500 && address.matches("^[a-zA-Z0-9# ]*$");
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



    // Book Validation
    public static void validateTitle(String title) {
        if (isNullOrEmpty(title)) {
            throw new InvalidInputException("Title is required");
        }
    }


    public static void validateISBN(String isbn) throws InvalidInputException {
        // Eliminar guiones y espacios
        isbn = isbn.replace("-", "").replace(" ", "");

        // Verificar si es ISBN-10 o ISBN-13
        if (isbn.length() == 10) {
            // Validar que contenga solo dígitos o 'X' en el último carácter
            for (int i = 0; i < 9; i++) {
                if (!Character.isDigit(isbn.charAt(i))) {
                    throw new InvalidInputException("Invalid character in ISBN-10: " + isbn.charAt(i));
                }
            }
            if (!(Character.isDigit(isbn.charAt(9)) || isbn.charAt(9) == 'X')) {
                throw new InvalidInputException("Invalid character in ISBN-10: " + isbn.charAt(9));
            }
        } else if (isbn.length() == 13) {
            // Validar que contenga solo dígitos
            for (int i = 0; i < 13; i++) {
                if (!Character.isDigit(isbn.charAt(i))) {
                    throw new InvalidInputException("Invalid character in ISBN-13: " + isbn.charAt(i));
                }
            }
        } else {
            throw new InvalidInputException("ISBN must have 10 or 13 digits.");
        }
    }

    public static void validateRegistrationDate(Date registrationDate) {
        if (registrationDate == null) {
            throw new InvalidInputException("Registration date is required");
        } else if (registrationDate.after(new Date())) {
            throw new InvalidInputException("Registration date cannot be in the future");
        }
    }

    //todo: validate status wether is any other type of field
    public static void validateStatus(Boolean status) {
        if (status == null) {
            throw new InvalidInputException("Status is required");
        }
    }


}
