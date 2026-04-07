package com.badminton.service;

import com.badminton.entity.Qiuzhuoxinxi;
import java.sql.SQLException;
import java.util.List;

public interface QiuzhuoxinxiService {
    List<Qiuzhuoxinxi> list() throws SQLException;
    int add(Qiuzhuoxinxi qiuzhuoxinxi) throws SQLException;
    int update(Qiuzhuoxinxi qiuzhuoxinxi) throws SQLException;
    int delete(Integer id) throws SQLException;
    Qiuzhuoxinxi getById(Integer id) throws SQLException;
}