package com.badminton.service.impl;

import com.badminton.dao.XinwentongzhiDao;
import com.badminton.dao.impl.XinwentongzhiDaoImpl;
import com.badminton.entity.Xinwentongzhi;
import com.badminton.service.XinwentongzhiService;

import java.sql.SQLException;
import java.util.List;

public class XinwentongzhiServiceImpl implements XinwentongzhiService {

    private XinwentongzhiDao xinwentongzhiDao = new XinwentongzhiDaoImpl();

    @Override
    public List<Xinwentongzhi> list() throws SQLException {
        return xinwentongzhiDao.list();
    }

    @Override
    public int add(Xinwentongzhi xinwentongzhi) throws SQLException {
        return xinwentongzhiDao.add(xinwentongzhi);
    }

    @Override
    public int update(Xinwentongzhi xinwentongzhi) throws SQLException {
        return xinwentongzhiDao.update(xinwentongzhi);
    }

    @Override
    public int delete(Integer id) throws SQLException {
        return xinwentongzhiDao.delete(id);
    }

    @Override
    public Xinwentongzhi getById(Integer id) throws SQLException {
        return xinwentongzhiDao.getById(id);
    }
}