package com.badminton.service;

import com.badminton.entity.Youqinglianjie;
import java.sql.SQLException;
import java.util.List;

public interface YouqinglianjieService {
    List<Youqinglianjie> list() throws SQLException;
    int add(Youqinglianjie youqinglianjie) throws SQLException;
    int update(Youqinglianjie youqinglianjie) throws SQLException;
    int delete(Integer id) throws SQLException;
    Youqinglianjie getById(Integer id) throws SQLException;
}