package com.badminton.service.impl;

import com.badminton.dao.PinglunDao;
import com.badminton.dao.impl.PinglunDaoImpl;
import com.badminton.entity.Pinglun;
import com.badminton.service.PinglunService;

import java.sql.SQLException;
import java.util.List;

public class PinglunServiceImpl implements PinglunService {

    private PinglunDao pinglunDao = new PinglunDaoImpl();

    @Override
    public List<Pinglun> list() throws SQLException {
        return pinglunDao.list();
    }

    @Override
    public int add(Pinglun pinglun) throws SQLException {
        return pinglunDao.add(pinglun);
    }

    @Override
    public int update(Pinglun pinglun) throws SQLException {
        return pinglunDao.update(pinglun);
    }

    @Override
    public int delete(Integer id) throws SQLException {
        return pinglunDao.delete(id);
    }

    @Override
    public Pinglun getById(Integer id) throws SQLException {
        return pinglunDao.getById(id);
    }
}
