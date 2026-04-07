package com.badminton.service;

import com.badminton.entity.Fufei;
import java.sql.SQLException;
import java.util.List;

public interface FufeiService {
    List<Fufei> list() throws SQLException;
    List<Fufei> listByHuiyuanbianhao(String huiyuanbianhao) throws SQLException;
    int add(Fufei fufei) throws SQLException;
    int update(Fufei fufei) throws SQLException;
    int delete(Integer id) throws SQLException;
    Fufei getById(Integer id) throws SQLException;
}