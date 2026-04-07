package com.badminton.service;

import com.badminton.entity.Allusers;
import com.badminton.util.PageBean;
import java.sql.SQLException;
import java.util.List;

public interface AllusersService {
    Allusers login(String username, String pwd, String cx) throws SQLException;
    List<Allusers> list() throws SQLException;
    PageBean<Allusers> listPage(int pageNo, int pageSize) throws SQLException;
    int add(Allusers allusers) throws SQLException;
    int update(Allusers allusers) throws SQLException;
    int delete(Integer id) throws SQLException;
    Allusers getById(Integer id) throws SQLException;
}