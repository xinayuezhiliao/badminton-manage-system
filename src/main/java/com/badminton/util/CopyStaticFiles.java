package com.badminton.util;

import java.io.*;
import java.nio.file.*;

public class CopyStaticFiles {
    public static void main(String[] args) {
        String basePath = "D:\\java吧\\badminton\\src\\main\\webapp\\";
        
        // Copy images
        copyDirectory(basePath + "static\\images", basePath + "images");
        
        // Copy js
        copyDirectory(basePath + "static\\js", basePath + "js");
        
        System.out.println("Files copied successfully!");
    }
    
    public static void copyDirectory(String sourceDir, String targetDir) {
        File source = new File(sourceDir);
        File target = new File(targetDir);
        
        if (!target.exists()) {
            target.mkdirs();
        }
        
        File[] files = source.listFiles();
        if (files != null) {
            for (File file : files) {
                try {
                    if (file.isDirectory()) {
                        copyDirectory(file.getAbsolutePath(), targetDir + "\\" + file.getName());
                    } else {
                        Files.copy(file.toPath(), new File(targetDir + "\\" + file.getName()).toPath(), StandardCopyOption.REPLACE_EXISTING);
                        System.out.println("Copied: " + file.getName());
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
