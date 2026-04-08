package com.badminton.service.impl;

import com.badminton.dao.AllusersDao;
import com.badminton.dao.impl.AllusersDaoImpl;
import com.badminton.entity.Allusers;
import com.badminton.service.AllusersService;
import com.badminton.util.PageBean;

import java.sql.SQLException;
import java.util.List;

public class AllusersServiceImpl implements AllusersService {

    private AllusersDao allusersDao = new AllusersDaoImpl();

    @Override
    public Allusers login(String username, String pwd, String cx) throws SQLException {
        return allusersDao.login(username, pwd, cx);
    }

    @Override
    public List<Allusers> list() throws SQLException {
        return allusersDao.list();
    }

    @Override
    public int add(Allusers allusers) throws SQLException {
        return allusersDao.add(allusers);
    }

    @Override
    public int update(Allusers allusers) throws SQLException {
        return allusersDao.update(allusers);
    }

    @Override
    public int delete(Integer id) throws SQLException {
        return allusersDao.delete(id);
    }

    @Override
    public Allusers getById(Integer id) throws SQLException {
        return allusersDao.getById(id);
    }

    @Override
    public PageBean<Allusers> listPage(int pageNo, int pageSize) throws SQLException {
        PageBean<Allusers> pageBean = new PageBean<>();
        int totalCount = allusersDao.getTotalCount();
        int start = (pageNo - 1) * pageSize;
        List<Allusers> list = allusersDao.listPage(start, pageSize);
        pageBean.setPageNo(pageNo);
        pageBean.setPageSize(pageSize);
        pageBean.setTotalCount(totalCount);
        pageBean.setList(list);
        return pageBean;
    }
}