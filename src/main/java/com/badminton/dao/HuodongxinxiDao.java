package com.badminton.dao;

import com.badminton.entity.Huodongxinxi;
import java.sql.SQLException;
import java.util.List;

public interface HuodongxinxiDao {
    List<Huodongxinxi> list() throws SQLException;
    int add(Huodongxinxi huodongxinxi) throws SQLException;
    int update(Huodongxinxi huodongxinxi) throws SQLException;
    int delete(Integer id) throws SQLException;
    Huodongxinxi getById(Integer id) throws SQLException;
}