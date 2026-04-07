package com.badminton.service.impl;

import com.badminton.dao.UserDao;
import com.badminton.dao.impl.UserDaoImpl;
import com.badminton.entity.User;
import com.badminton.service.UserService;

public class UserServiceImpl implements UserService {

    private final UserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String pwd, String cx) {
        try {
            return userDao.login(username, pwd, cx);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}