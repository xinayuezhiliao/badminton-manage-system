package com.badminton.service.impl;

import com.badminton.dao.LiuyanbanDao;
import com.badminton.dao.impl.LiuyanbanDaoImpl;
import com.badminton.entity.Liuyanban;
import com.badminton.service.LiuyanbanService;

import java.sql.SQLException;
import java.util.List;

public class LiuyanbanServiceImpl implements LiuyanbanService {

    private LiuyanbanDao liuyanbanDao = new LiuyanbanDaoImpl();

    @Override
    public List<Liuyanban> list() throws SQLException {
        return liuyanbanDao.list();
    }

    @Override
    public int add(Liuyanban liuyanban) throws SQLException {
        return liuyanbanDao.add(liuyanban);
    }

    @Override
    public int update(Liuyanban liuyanban) throws SQLException {
        return liuyanbanDao.update(liuyanban);
    }

    @Override
    public int delete(Integer id) throws SQLException {
        return liuyanbanDao.delete(id);
    }

    @Override
    public Liuyanban getById(Integer id) throws SQLException {
        return liuyanbanDao.getById(id);
    }
}