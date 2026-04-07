package com.badminton.service.impl;

import com.badminton.dao.CourtDao;
import com.badminton.dao.impl.CourtDaoImpl;
import com.badminton.entity.Court;
import com.badminton.service.CourtService;

import java.sql.SQLException;
import java.util.List;

public class CourtServiceImpl implements CourtService {
    private final CourtDao dao = new CourtDaoImpl();

    @Override
    public List<Court> list() {
        try { return dao.list(); } catch (SQLException e) { e.printStackTrace(); return null; }
    }

    @Override
    public int add(Court court) {
        try { return dao.add(court); } catch (SQLException e) { e.printStackTrace(); return 0; }
    }

    @Override
    public int update(Court court) {
        try { return dao.update(court); } catch (SQLException e) { e.printStackTrace(); return 0; }
    }

    @Override
    public int delete(Integer id) {
        try { return dao.delete(id); } catch (SQLException e) { e.printStackTrace(); return 0; }
    }

    @Override
    public Court getById(Integer id) {
        try { return dao.getById(id); } catch (SQLException e) { e.printStackTrace(); return null; }
    }
}