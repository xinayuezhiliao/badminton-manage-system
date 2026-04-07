package com.badminton.service;

import com.badminton.entity.Liuyanban;
import java.sql.SQLException;
import java.util.List;

public interface LiuyanbanService {
    List<Liuyanban> list() throws SQLException;
    int add(Liuyanban liuyanban) throws SQLException;
    int update(Liuyanban liuyanban) throws SQLException;
    int delete(Integer id) throws SQLException;
    Liuyanban getById(Integer id) throws SQLException;
}