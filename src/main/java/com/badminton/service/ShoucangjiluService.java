package com.badminton.service;

import com.badminton.entity.Shoucangjilu;
import java.sql.SQLException;
import java.util.List;

public interface ShoucangjiluService {
    List<Shoucangjilu> list() throws SQLException;
    int add(Shoucangjilu shoucangjilu) throws SQLException;
    int update(Shoucangjilu shoucangjilu) throws SQLException;
    int delete(Integer id) throws SQLException;
    Shoucangjilu getById(Integer id) throws SQLException;
}
