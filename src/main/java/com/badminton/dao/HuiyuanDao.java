package com.badminton.dao;

import com.badminton.entity.Huiyuan;
import java.sql.SQLException;
import java.util.List;

public interface HuiyuanDao {
    List<Huiyuan> list() throws SQLException;
    int add(Huiyuan huiyuan) throws SQLException;
    int update(Huiyuan huiyuan) throws SQLException;
    int delete(Integer id) throws SQLException;
    Huiyuan getById(Integer id) throws SQLException;
}