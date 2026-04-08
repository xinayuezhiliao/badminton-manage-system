package com.badminton.util;

public class StrUtil {
    public static boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }

    public static String trim(String str) {
        return str == null ? "" : str.trim();
    }
}