package com.badminton.dao.impl;

import com.badminton.dao.YouqinglianjieDao;
import com.badminton.entity.Youqinglianjie;
import com.badminton.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class YouqinglianjieDaoImpl implements YouqinglianjieDao {
    @Override
    public List<Youqinglianjie> list() throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM youqinglianjie ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Youqinglianjie> list = new ArrayList<>();
        while (rs.next()) {
            Youqinglianjie y = new Youqinglianjie();
            y.setId(rs.getInt("id"));
            y.setMingcheng(rs.getString("mingcheng"));
            y.setUrl(rs.getString("url"));
            y.setShijian(rs.getString("shijian"));
            y.setAddtime(rs.getString("addtime"));
            list.add(y);
        }
        rs.close();
        pstmt.close();
        conn.close();
        return list;
    }

    @Override
    public int add(Youqinglianjie youqinglianjie) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO youqinglianjie(mingcheng,url,shijian,addtime) VALUES(?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, youqinglianjie.getMingcheng());
        pstmt.setString(2, youqinglianjie.getUrl());
        pstmt.setString(3, youqinglianjie.getShijian());
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        pstmt.setString(4, now);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int update(Youqinglianjie youqinglianjie) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE youqinglianjie SET mingcheng=?,url=?,shijian=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, youqinglianjie.getMingcheng());
        pstmt.setString(2, youqinglianjie.getUrl());
        pstmt.setString(3, youqinglianjie.getShijian());
        pstmt.setInt(4, youqinglianjie.getId());
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "DELETE FROM youqinglianjie WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public Youqinglianjie getById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM youqinglianjie WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        Youqinglianjie y = null;
        if (rs.next()) {
            y = new Youqinglianjie();
            y.setId(rs.getInt("id"));
            y.setMingcheng(rs.getString("mingcheng"));
            y.setUrl(rs.getString("url"));
            y.setShijian(rs.getString("shijian"));
            y.setAddtime(rs.getString("addtime"));
        }
        rs.close();
        pstmt.close();
        conn.close();
        return y;
    }
}
