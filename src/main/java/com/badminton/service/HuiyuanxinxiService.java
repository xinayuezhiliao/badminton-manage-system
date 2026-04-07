package com.badminton.service;

import com.badminton.entity.Huiyuanxinxi;
import java.sql.SQLException;
import java.util.List;

public interface HuiyuanxinxiService {
    List<Huiyuanxinxi> list() throws SQLException;
    int add(Huiyuanxinxi huiyuanxinxi) throws SQLException;
    int update(Huiyuanxinxi huiyuanxinxi) throws SQLException;
    int delete(Integer id) throws SQLException;
    Huiyuanxinxi getById(Integer id) throws SQLException;
    Huiyuanxinxi getByHuiyuanbianhao(String huiyuanbianhao) throws SQLException;
    Huiyuanxinxi login(String huiyuanbianhao, String mima) throws SQLException;
}