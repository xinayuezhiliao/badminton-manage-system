package com.badminton.service.impl;

import com.badminton.dao.ShoucangjiluDao;
import com.badminton.dao.impl.ShoucangjiluDaoImpl;
import com.badminton.entity.Shoucangjilu;
import com.badminton.service.ShoucangjiluService;

import java.sql.SQLException;
import java.util.List;

public class ShoucangjiluServiceImpl implements ShoucangjiluService {

    private ShoucangjiluDao shoucangjiluDao = new ShoucangjiluDaoImpl();

    @Override
    public List<Shoucangjilu> list() throws SQLException {
        return shoucangjiluDao.list();
    }

    @Override
    public int add(Shoucangjilu shoucangjilu) throws SQLException {
        return shoucangjiluDao.add(shoucangjilu);
    }

    @Override
    public int update(Shoucangjilu shoucangjilu) throws SQLException {
        return shoucangjiluDao.update(shoucangjilu);
    }

    @Override
    public int delete(Integer id) throws SQLException {
        return shoucangjiluDao.delete(id);
    }

    @Override
    public Shoucangjilu getById(Integer id) throws SQLException {
        return shoucangjiluDao.getById(id);
    }
}
