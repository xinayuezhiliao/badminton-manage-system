package com.badminton.dao;

import com.badminton.entity.Allusers;
import java.sql.SQLException;
import java.util.List;

public interface AllusersDao {
    Allusers login(String username, String pwd, String cx) throws SQLException;
    List<Allusers> list() throws SQLException;
    List<Allusers> listPage(int start, int pageSize) throws SQLException;
    int getTotalCount() throws SQLException;
    int add(Allusers allusers) throws SQLException;
    int update(Allusers allusers) throws SQLException;
    int delete(Integer id) throws SQLException;
    Allusers getById(Integer id) throws SQLException;
}