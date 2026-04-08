package com.badminton.service.impl;

import com.badminton.dao.HuiyuanxinxiDao;
import com.badminton.dao.impl.HuiyuanxinxiDaoImpl;
import com.badminton.entity.Huiyuanxinxi;
import com.badminton.service.HuiyuanxinxiService;

import java.sql.SQLException;
import java.util.List;

public class HuiyuanxinxiServiceImpl implements HuiyuanxinxiService {

    private HuiyuanxinxiDao huiyuanxinxiDao = new HuiyuanxinxiDaoImpl();

    @Override
    public List<Huiyuanxinxi> list() throws SQLException {
        return huiyuanxinxiDao.list();
    }

    @Override
    public int add(Huiyuanxinxi huiyuanxinxi) throws SQLException {
        return huiyuanxinxiDao.add(huiyuanxinxi);
    }

    @Override
    public int update(Huiyuanxinxi huiyuanxinxi) throws SQLException {
        return huiyuanxinxiDao.update(huiyuanxinxi);
    }

    @Override
    public int delete(Integer id) throws SQLException {
        return huiyuanxinxiDao.delete(id);
    }

    @Override
    public Huiyuanxinxi getById(Integer id) throws SQLException {
        return huiyuanxinxiDao.getById(id);
    }

    @Override
    public Huiyuanxinxi getByHuiyuanbianhao(String huiyuanbianhao) throws SQLException {
        return huiyuanxinxiDao.getByHuiyuanbianhao(huiyuanbianhao);
    }

    @Override
    public Huiyuanxinxi login(String huiyuanbianhao, String mima) throws SQLException {
        return huiyuanxinxiDao.login(huiyuanbianhao, mima);
    }
}