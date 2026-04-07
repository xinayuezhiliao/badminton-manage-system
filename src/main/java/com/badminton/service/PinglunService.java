package com.badminton.service;

import com.badminton.entity.Pinglun;
import java.sql.SQLException;
import java.util.List;

public interface PinglunService {
    List<Pinglun> list() throws SQLException;
    int add(Pinglun pinglun) throws SQLException;
    int update(Pinglun pinglun) throws SQLException;
    int delete(Integer id) throws SQLException;
    Pinglun getById(Integer id) throws SQLException;
}
