package com.badminton.dao;

import com.badminton.entity.User;
import java.sql.SQLException;

public interface UserDao {
    User login(String username, String pwd, String cx) throws SQLException;
}