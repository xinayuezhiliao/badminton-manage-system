package com.badminton.service.impl;

import com.badminton.dao.DingzhuoxinxiDao;
import com.badminton.dao.impl.DingzhuoxinxiDaoImpl;
import com.badminton.entity.Dingzhuoxinxi;
import com.badminton.service.DingzhuoxinxiService;

import java.sql.SQLException;
import java.util.List;

public class DingzhuoxinxiServiceImpl implements DingzhuoxinxiService {

    private DingzhuoxinxiDao dingzhuoxinxiDao = new DingzhuoxinxiDaoImpl();

    @Override
    public List<Dingzhuoxinxi> list(String qiuzhuohao, String meixiaoshijifei, String huiyuanbianhao, String xingming, String huiyuandengji, String zhekou) throws SQLException {
        return dingzhuoxinxiDao.list(qiuzhuohao, meixiaoshijifei, huiyuanbianhao, xingming, huiyuandengji, zhekou);
    }

    @Override
    public int add(Dingzhuoxinxi dingzhuoxinxi) throws SQLException {
        return dingzhuoxinxiDao.add(dingzhuoxinxi);
    }

    @Override
    public int update(Dingzhuoxinxi dingzhuoxinxi) throws SQLException {
        return dingzhuoxinxiDao.update(dingzhuoxinxi);
    }

    @Override
    public int delete(Integer id) throws SQLException {
        return dingzhuoxinxiDao.delete(id);
    }

    @Override
    public Dingzhuoxinxi getById(Integer id) throws SQLException {
        return dingzhuoxinxiDao.getById(id);
    }
}