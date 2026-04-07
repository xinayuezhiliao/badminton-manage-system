package com.badminton.service.impl;

import com.badminton.dao.FufeiDao;
import com.badminton.dao.impl.FufeiDaoImpl;
import com.badminton.entity.Fufei;
import com.badminton.service.FufeiService;

import java.sql.SQLException;
import java.util.List;

public class FufeiServiceImpl implements FufeiService {

    private FufeiDao fufeiDao = new FufeiDaoImpl();

    @Override
    public List<Fufei> list() throws SQLException {
        return fufeiDao.list();
    }

    @Override
    public List<Fufei> listByHuiyuanbianhao(String huiyuanbianhao) throws SQLException {
        return fufeiDao.listByHuiyuanbianhao(huiyuanbianhao);
    }

    @Override
    public int add(Fufei fufei) throws SQLException {
        return fufeiDao.add(fufei);
    }

    @Override
    public int update(Fufei fufei) throws SQLException {
        return fufeiDao.update(fufei);
    }

    @Override
    public int delete(Integer id) throws SQLException {
        return fufeiDao.delete(id);
    }

    @Override
    public Fufei getById(Integer id) throws SQLException {
        return fufeiDao.getById(id);
    }
}