package com.badminton.dao.impl;

import com.badminton.dao.LiuyanbanDao;
import com.badminton.entity.Liuyanban;
import com.badminton.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class LiuyanbanDaoImpl implements LiuyanbanDao {
    @Override
    public List<Liuyanban> list() throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM liuyanban ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Liuyanban> list = new ArrayList<>();
        while (rs.next()) {
            Liuyanban l = new Liuyanban();
            l.setId(rs.getInt("id"));
            l.setBiaoti(rs.getString("biaoti"));
            l.setNeirong(rs.getString("neirong"));
            l.setLianxifangshi(rs.getString("lianxifangshi"));
            l.setLiuyanshijian(rs.getString("liuyanshijian"));
            l.setHuifuneirong(rs.getString("huifuneirong"));
            l.setAddtime(rs.getString("addtime"));
            list.add(l);
        }
        rs.close();
        pstmt.close();
        conn.close();
        return list;
    }

    @Override
    public int add(Liuyanban liuyanban) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO liuyanban(biaoti,neirong,lianxifangshi,liuyanshijian,huifuneirong,addtime) VALUES(?,?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, liuyanban.getBiaoti());
        pstmt.setString(2, liuyanban.getNeirong());
        pstmt.setString(3, liuyanban.getLianxifangshi());
        pstmt.setString(4, liuyanban.getLiuyanshijian());
        pstmt.setString(5, liuyanban.getHuifuneirong());
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        pstmt.setString(6, now);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int update(Liuyanban liuyanban) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE liuyanban SET biaoti=?,neirong=?,lianxifangshi=?,liuyanshijian=?,huifuneirong=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, liuyanban.getBiaoti());
        pstmt.setString(2, liuyanban.getNeirong());
        pstmt.setString(3, liuyanban.getLianxifangshi());
        pstmt.setString(4, liuyanban.getLiuyanshijian());
        pstmt.setString(5, liuyanban.getHuifuneirong());
        pstmt.setInt(6, liuyanban.getId());
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "DELETE FROM liuyanban WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public Liuyanban getById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM liuyanban WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        Liuyanban l = null;
        if (rs.next()) {
            l = new Liuyanban();
            l.setId(rs.getInt("id"));
            l.setBiaoti(rs.getString("biaoti"));
            l.setNeirong(rs.getString("neirong"));
            l.setLianxifangshi(rs.getString("lianxifangshi"));
            l.setLiuyanshijian(rs.getString("liuyanshijian"));
            l.setHuifuneirong(rs.getString("huifuneirong"));
            l.setAddtime(rs.getString("addtime"));
        }
        rs.close();
        pstmt.close();
        conn.close();
        return l;
    }
}
