package com.badminton.service.impl;

import com.badminton.dao.YonghuzhuceDao;
import com.badminton.dao.impl.YonghuzhuceDaoImpl;
import com.badminton.entity.Yonghuzhuce;
import com.badminton.service.YonghuzhuceService;

import java.sql.SQLException;
import java.util.List;

public class YonghuzhuceServiceImpl implements YonghuzhuceService {

    private YonghuzhuceDao yonghuzhuceDao = new YonghuzhuceDaoImpl();

    @Override
    public List<Yonghuzhuce> list() throws SQLException {
        return yonghuzhuceDao.list();
    }

    @Override
    public int add(Yonghuzhuce yonghuzhuce) throws SQLException {
        return yonghuzhuceDao.add(yonghuzhuce);
    }

    @Override
    public int update(Yonghuzhuce yonghuzhuce) throws SQLException {
        return yonghuzhuceDao.update(yonghuzhuce);
    }

    @Override
    public int delete(Integer id) throws SQLException {
        return yonghuzhuceDao.delete(id);
    }

    @Override
    public Yonghuzhuce getById(Integer id) throws SQLException {
        return yonghuzhuceDao.getById(id);
    }
}