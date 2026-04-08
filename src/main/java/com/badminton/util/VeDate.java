package com.badminton.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class VeDate {
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private static final SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");

    public static String getNowTime() {
        return sdf.format(new Date());
    }

    public static String getNowDate() {
        return sdfDate.format(new Date());
    }

    public static Date strToDate(String str) throws ParseException {
        return sdf.parse(str);
    }

    public static String dateToStr(Date date) {
        return sdf.format(date);
    }
}