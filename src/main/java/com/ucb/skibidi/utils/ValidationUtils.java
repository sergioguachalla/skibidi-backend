package com.ucb.skibidi.utils;

public class ValidationUtils {

    /*
     * Validates if a string is null or empty
     * @param str the string to validate
     * @return true if the string is null or empty, false otherwise
     */
    public static boolean isNullOrEmpty(String str) {
        return str == null || str.isEmpty();
    }
}
