package com.badminton.service.impl;

import com.badminton.dao.HuodongxinxiDao;
import com.badminton.dao.impl.HuodongxinxiDaoImpl;
import com.badminton.entity.Huodongxinxi;
import com.badminton.service.HuodongxinxiService;

import java.sql.SQLException;
import java.util.List;

public class HuodongxinxiServiceImpl implements HuodongxinxiService {

    private HuodongxinxiDao huodongxinxiDao = new HuodongxinxiDaoImpl();

    @Override
    public List<Huodongxinxi> list() throws SQLException {
        return huodongxinxiDao.list();
    }

    @Override
    public int add(Huodongxinxi huodongxinxi) throws SQLException {
        return huodongxinxiDao.add(huodongxinxi);
    }

    @Override
    public int update(Huodongxinxi huodongxinxi) throws SQLException {
        return huodongxinxiDao.update(huodongxinxi);
    }

    @Override
    public int delete(Integer id) throws SQLException {
        return huodongxinxiDao.delete(id);
    }

    @Override
    public Huodongxinxi getById(Integer id) throws SQLException {
        return huodongxinxiDao.getById(id);
    }
}