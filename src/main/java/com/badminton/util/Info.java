package com.badminton.util;

public class Info {
    private String msg;
    private String url;

    public Info(String msg, String url) {
        this.msg = msg;
        this.url = url;
    }

    public String getMsg() {
        return msg;
    }

    public String getUrl() {
        return url;
    }

    public synchronized static String subStr(String source,int length) {
        if(source.length()>length)
        {
            source=source.substring(0,length)+"...";
        }

        return source;
    }
}



