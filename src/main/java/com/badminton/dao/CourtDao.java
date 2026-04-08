package com.badminton.dao;

import com.badminton.entity.Court;
import java.sql.SQLException;
import java.util.List;

public interface CourtDao {
    List<Court> list() throws SQLException;
    int add(Court court) throws SQLException;
    int update(Court court) throws SQLException;
    int delete(Integer id) throws SQLException;
    Court getById(Integer id) throws SQLException;
}