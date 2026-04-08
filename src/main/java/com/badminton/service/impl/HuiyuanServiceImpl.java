package com.badminton.service.impl;

import com.badminton.dao.HuiyuanDao;
import com.badminton.dao.impl.HuiyuanDaoImpl;
import com.badminton.entity.Huiyuan;
import com.badminton.service.HuiyuanService;

import java.sql.SQLException;
import java.util.List;

public class HuiyuanServiceImpl implements HuiyuanService {

    private final HuiyuanDao dao = new HuiyuanDaoImpl();

    @Override
    public List<Huiyuan> list() {
        try {
            return dao.list();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public int add(Huiyuan huiyuan) {
        try {
            return dao.add(huiyuan);
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int update(Huiyuan huiyuan) {
        try {
            return dao.update(huiyuan);
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int delete(Integer id) {
        try {
            return dao.delete(id);
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public Huiyuan getById(Integer id) {
        try {
            return dao.getById(id);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}