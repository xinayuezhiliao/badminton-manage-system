package com.badminton.service;

import com.badminton.entity.Yonghuzhuce;
import java.sql.SQLException;
import java.util.List;

public interface YonghuzhuceService {
    List<Yonghuzhuce> list() throws SQLException;
    int add(Yonghuzhuce yonghuzhuce) throws SQLException;
    int update(Yonghuzhuce yonghuzhuce) throws SQLException;
    int delete(Integer id) throws SQLException;
    Yonghuzhuce getById(Integer id) throws SQLException;
}