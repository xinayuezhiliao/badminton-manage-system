package com.badminton.service;

import com.badminton.entity.Xinwentongzhi;
import java.sql.SQLException;
import java.util.List;

public interface XinwentongzhiService {
    List<Xinwentongzhi> list() throws SQLException;
    int add(Xinwentongzhi xinwentongzhi) throws SQLException;
    int update(Xinwentongzhi xinwentongzhi) throws SQLException;
    int delete(Integer id) throws SQLException;
    Xinwentongzhi getById(Integer id) throws SQLException;
}