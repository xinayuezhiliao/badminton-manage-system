package com.badminton.service;

import com.badminton.entity.User;

public interface UserService {
    User login(String username, String pwd, String cx);
}