package com.badminton.dao.impl;

import com.badminton.dao.HuodongxinxiDao;
import com.badminton.entity.Huodongxinxi;
import com.badminton.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class HuodongxinxiDaoImpl implements HuodongxinxiDao {
    @Override
    public List<Huodongxinxi> list() throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM huodongxinxi ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Huodongxinxi> list = new ArrayList<>();
        while (rs.next()) {
            Huodongxinxi h = new Huodongxinxi();
            h.setId(rs.getInt("id"));
            h.setBiaoti(rs.getString("biaoti"));
            h.setNeirong(rs.getString("neirong"));
            h.setFabushijian(rs.getString("fabushijian"));
            h.setAddtime(rs.getString("addtime"));
            list.add(h);
        }
        rs.close();
        pstmt.close();
        conn.close();
        return list;
    }

    @Override
    public int add(Huodongxinxi huodongxinxi) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO huodongxinxi(biaoti,neirong,fabushijian,addtime) VALUES(?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, huodongxinxi.getBiaoti());
        pstmt.setString(2, huodongxinxi.getNeirong());
        pstmt.setString(3, huodongxinxi.getFabushijian());
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        pstmt.setString(4, now);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int update(Huodongxinxi huodongxinxi) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE huodongxinxi SET biaoti=?,neirong=?,fabushijian=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, huodongxinxi.getBiaoti());
        pstmt.setString(2, huodongxinxi.getNeirong());
        pstmt.setString(3, huodongxinxi.getFabushijian());
        pstmt.setInt(4, huodongxinxi.getId());
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "DELETE FROM huodongxinxi WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public Huodongxinxi getById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM huodongxinxi WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        Huodongxinxi h = null;
        if (rs.next()) {
            h = new Huodongxinxi();
            h.setId(rs.getInt("id"));
            h.setBiaoti(rs.getString("biaoti"));
            h.setNeirong(rs.getString("neirong"));
            h.setFabushijian(rs.getString("fabushijian"));
            h.setAddtime(rs.getString("addtime"));
        }
        rs.close();
        pstmt.close();
        conn.close();
        return h;
    }
}
