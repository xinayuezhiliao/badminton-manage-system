package com.badminton.service.impl;

import com.badminton.dao.YouqinglianjieDao;
import com.badminton.dao.impl.YouqinglianjieDaoImpl;
import com.badminton.entity.Youqinglianjie;
import com.badminton.service.YouqinglianjieService;

import java.sql.SQLException;
import java.util.List;

public class YouqinglianjieServiceImpl implements YouqinglianjieService {

    private YouqinglianjieDao youqinglianjieDao = new YouqinglianjieDaoImpl();

    @Override
    public List<Youqinglianjie> list() throws SQLException {
        return youqinglianjieDao.list();
    }

    @Override
    public int add(Youqinglianjie youqinglianjie) throws SQLException {
        return youqinglianjieDao.add(youqinglianjie);
    }

    @Override
    public int update(Youqinglianjie youqinglianjie) throws SQLException {
        return youqinglianjieDao.update(youqinglianjie);
    }

    @Override
    public int delete(Integer id) throws SQLException {
        return youqinglianjieDao.delete(id);
    }

    @Override
    public Youqinglianjie getById(Integer id) throws SQLException {
        return youqinglianjieDao.getById(id);
    }
}