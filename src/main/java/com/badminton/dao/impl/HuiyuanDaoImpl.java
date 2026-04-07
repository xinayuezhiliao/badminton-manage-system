package com.badminton.dao.impl;

import com.badminton.dao.HuiyuanDao;
import com.badminton.entity.Huiyuan;
import com.badminton.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class HuiyuanDaoImpl implements HuiyuanDao {

    @Override
    public List<Huiyuan> list() throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM huiyuan ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        List<Huiyuan> list = new ArrayList<>();
        while (rs.next()) {
            Huiyuan h = new Huiyuan();
            h.setId(rs.getInt("id"));
            h.setBianhao(rs.getString("bianhao"));
            h.setName(rs.getString("name"));
            h.setPhone(rs.getString("phone"));
            h.setType(rs.getString("type"));
            h.setZhuangtai(rs.getString("zhuangtai"));
            h.setAddtime(rs.getString("addtime"));
            list.add(h);
        }
        rs.close(); pstmt.close(); conn.close();
        return list;
    }

    @Override
    public int add(Huiyuan huiyuan) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO huiyuan(bianhao,name,phone,type,zhuangtai,addtime) VALUES(?,?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, huiyuan.getBianhao());
        pstmt.setString(2, huiyuan.getName());
        pstmt.setString(3, huiyuan.getPhone());
        pstmt.setString(4, huiyuan.getType());
        pstmt.setString(5, huiyuan.getZhuangtai());
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        pstmt.setString(6, now);
        int rows = pstmt.executeUpdate();
        pstmt.close(); conn.close();
        return rows;
    }

    @Override
    public int update(Huiyuan huiyuan) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE huiyuan SET bianhao=?,name=?,phone=?,type=?,zhuangtai=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, huiyuan.getBianhao());
        pstmt.setString(2, huiyuan.getName());
        pstmt.setString(3, huiyuan.getPhone());
        pstmt.setString(4, huiyuan.getType());
        pstmt.setString(5, huiyuan.getZhuangtai());
        pstmt.setInt(6, huiyuan.getId());
        int rows = pstmt.executeUpdate();
        pstmt.close(); conn.close();
        return rows;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "DELETE FROM huiyuan WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        int rows = pstmt.executeUpdate();
        pstmt.close(); conn.close();
        return rows;
    }

    @Override
    public Huiyuan getById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM huiyuan WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        Huiyuan h = null;
        if (rs.next()) {
            h = new Huiyuan();
            h.setId(rs.getInt("id"));
            h.setBianhao(rs.getString("bianhao"));
            h.setName(rs.getString("name"));
            h.setPhone(rs.getString("phone"));
            h.setType(rs.getString("type"));
            h.setZhuangtai(rs.getString("zhuangtai"));
            h.setAddtime(rs.getString("addtime"));
        }
        rs.close(); pstmt.close(); conn.close();
        return h;
    }
}