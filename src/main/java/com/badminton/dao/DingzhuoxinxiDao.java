package com.badminton.dao;

import com.badminton.entity.Dingzhuoxinxi;
import java.sql.SQLException;
import java.util.List;

public interface DingzhuoxinxiDao {
    List<Dingzhuoxinxi> list(String qiuzhuohao, String meixiaoshijifei, String huiyuanbianhao, String xingming, String huiyuandengji, String zhekou) throws SQLException;
    int add(Dingzhuoxinxi dingzhuoxinxi) throws SQLException;
    int update(Dingzhuoxinxi dingzhuoxinxi) throws SQLException;
    int delete(Integer id) throws SQLException;
    Dingzhuoxinxi getById(Integer id) throws SQLException;
}