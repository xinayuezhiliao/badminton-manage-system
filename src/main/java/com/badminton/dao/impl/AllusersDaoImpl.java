package com.badminton.dao.impl;

import com.badminton.dao.AllusersDao;
import com.badminton.entity.Allusers;
import com.badminton.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class AllusersDaoImpl implements AllusersDao {

    @Override
    public Allusers login(String username, String pwd, String cx) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM allusers WHERE username=? AND pwd=? AND cx=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, pwd);
        pstmt.setString(3, cx);
        ResultSet rs = pstmt.executeQuery();
        Allusers u = null;
        if (rs.next()) {
            u = new Allusers();
            u.setId(rs.getInt("id"));
            u.setUsername(rs.getString("username"));
            u.setPwd(rs.getString("pwd"));
            u.setCx(rs.getString("cx"));
            u.setAddtime(rs.getString("addtime"));
        }
        rs.close();
        pstmt.close();
        conn.close();
        return u;
    }

    @Override
    public List<Allusers> list() throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM allusers ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Allusers> list = new ArrayList<>();
        while (rs.next()) {
            Allusers u = new Allusers();
            u.setId(rs.getInt("id"));
            u.setUsername(rs.getString("username"));
            u.setPwd(rs.getString("pwd"));
            u.setCx(rs.getString("cx"));
            u.setAddtime(rs.getString("addtime"));
            list.add(u);
        }
        rs.close();
        pstmt.close();
        conn.close();
        return list;
    }

    @Override
    public List<Allusers> listPage(int start, int pageSize) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM allusers ORDER BY id DESC LIMIT ?,?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, start);
        pstmt.setInt(2, pageSize);
        ResultSet rs = pstmt.executeQuery();
        List<Allusers> list = new ArrayList<>();
        while (rs.next()) {
            Allusers u = new Allusers();
            u.setId(rs.getInt("id"));
            u.setUsername(rs.getString("username"));
            u.setPwd(rs.getString("pwd"));
            u.setCx(rs.getString("cx"));
            u.setAddtime(rs.getString("addtime"));
            list.add(u);
        }
        rs.close();
        pstmt.close();
        conn.close();
        return list;
    }

    @Override
    public int getTotalCount() throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT COUNT(*) FROM allusers";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1);
        }
        rs.close();
        pstmt.close();
        conn.close();
        return count;
    }

    @Override
    public int add(Allusers allusers) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO allusers(username,pwd,cx,addtime) VALUES(?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, allusers.getUsername());
        pstmt.setString(2, allusers.getPwd());
        pstmt.setString(3, allusers.getCx());
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        pstmt.setString(4, now);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int update(Allusers allusers) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE allusers SET username=?,pwd=?,cx=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, allusers.getUsername());
        pstmt.setString(2, allusers.getPwd());
        pstmt.setString(3, allusers.getCx());
        pstmt.setInt(4, allusers.getId());
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "DELETE FROM allusers WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public Allusers getById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM allusers WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        Allusers u = null;
        if (rs.next()) {
            u = new Allusers();
            u.setId(rs.getInt("id"));
            u.setUsername(rs.getString("username"));
            u.setPwd(rs.getString("pwd"));
            u.setCx(rs.getString("cx"));
            u.setAddtime(rs.getString("addtime"));
        }
        rs.close();
        pstmt.close();
        conn.close();
        return u;
    }
}