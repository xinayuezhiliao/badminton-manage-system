package com.badminton.dao.impl;

import com.badminton.dao.PinglunDao;
import com.badminton.entity.Pinglun;
import com.badminton.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class PinglunDaoImpl implements PinglunDao {
    @Override
    public List<Pinglun> list() throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM pinglun ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Pinglun> list = new ArrayList<>();
        while (rs.next()) {
            Pinglun p = new Pinglun();
            p.setId(rs.getInt("id"));
            p.setBiaoti(rs.getString("biaoti"));
            p.setNeirong(rs.getString("neirong"));
            p.setFaburen(rs.getString("faburen"));
            p.setFabushijian(rs.getString("fabushijian"));
            p.setAddtime(rs.getString("addtime"));
            list.add(p);
        }
        rs.close();
        pstmt.close();
        conn.close();
        return list;
    }

    @Override
    public int add(Pinglun pinglun) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO pinglun(biaoti,neirong,faburen,fabushijian,addtime) VALUES(?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, pinglun.getBiaoti());
        pstmt.setString(2, pinglun.getNeirong());
        pstmt.setString(3, pinglun.getFaburen());
        pstmt.setString(4, pinglun.getFabushijian());
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        pstmt.setString(5, now);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int update(Pinglun pinglun) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE pinglun SET biaoti=?,neirong=?,faburen=?,fabushijian=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, pinglun.getBiaoti());
        pstmt.setString(2, pinglun.getNeirong());
        pstmt.setString(3, pinglun.getFaburen());
        pstmt.setString(4, pinglun.getFabushijian());
        pstmt.setInt(5, pinglun.getId());
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "DELETE FROM pinglun WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public Pinglun getById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM pinglun WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        Pinglun p = null;
        if (rs.next()) {
            p = new Pinglun();
            p.setId(rs.getInt("id"));
            p.setBiaoti(rs.getString("biaoti"));
            p.setNeirong(rs.getString("neirong"));
            p.setFaburen(rs.getString("faburen"));
            p.setFabushijian(rs.getString("fabushijian"));
            p.setAddtime(rs.getString("addtime"));
        }
        rs.close();
        pstmt.close();
        conn.close();
        return p;
    }
}
