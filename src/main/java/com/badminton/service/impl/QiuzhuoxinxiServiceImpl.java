package com.badminton.service.impl;

import com.badminton.dao.QiuzhuoxinxiDao;
import com.badminton.dao.impl.QiuzhuoxinxiDaoImpl;
import com.badminton.entity.Qiuzhuoxinxi;
import com.badminton.service.QiuzhuoxinxiService;

import java.sql.SQLException;
import java.util.List;

public class QiuzhuoxinxiServiceImpl implements QiuzhuoxinxiService {

    private QiuzhuoxinxiDao qiuzhuoxinxiDao = new QiuzhuoxinxiDaoImpl();

    @Override
    public List<Qiuzhuoxinxi> list() throws SQLException {
        return qiuzhuoxinxiDao.list();
    }

    @Override
    public int add(Qiuzhuoxinxi qiuzhuoxinxi) throws SQLException {
        return qiuzhuoxinxiDao.add(qiuzhuoxinxi);
    }

    @Override
    public int update(Qiuzhuoxinxi qiuzhuoxinxi) throws SQLException {
        return qiuzhuoxinxiDao.update(qiuzhuoxinxi);
    }

    @Override
    public int delete(Integer id) throws SQLException {
        return qiuzhuoxinxiDao.delete(id);
    }

    @Override
    public Qiuzhuoxinxi getById(Integer id) throws SQLException {
        return qiuzhuoxinxiDao.getById(id);
    }
}