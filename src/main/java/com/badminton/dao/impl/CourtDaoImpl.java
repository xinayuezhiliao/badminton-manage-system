package com.badminton.dao.impl;

import com.badminton.dao.CourtDao;
import com.badminton.entity.Court;
import com.badminton.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CourtDaoImpl implements CourtDao {
    @Override
    public List<Court> list() throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM court ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Court> list = new ArrayList<>();
        while (rs.next()) {
            Court c = new Court();
            c.setId(rs.getInt("id"));
            c.setName(rs.getString("name"));
            c.setPosition(rs.getString("position"));
            c.setPrice(rs.getString("price"));
            c.setStatus(rs.getString("status"));
            c.setRemark(rs.getString("remark"));
            list.add(c);
        }
        rs.close(); pstmt.close(); conn.close();
        return list;
    }

    @Override
    public int add(Court court) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO court(name,position,price,status,remark) VALUES(?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, court.getName());
        pstmt.setString(2, court.getPosition());
        pstmt.setString(3, court.getPrice());
        pstmt.setString(4, court.getStatus());
        pstmt.setString(5, court.getRemark());
        int rows = pstmt.executeUpdate();
        pstmt.close(); conn.close();
        return rows;
    }

    @Override
    public int update(Court court) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE court SET name=?,position=?,price=?,status=?,remark=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, court.getName());
        pstmt.setString(2, court.getPosition());
        pstmt.setString(3, court.getPrice());
        pstmt.setString(4, court.getStatus());
        pstmt.setString(5, court.getRemark());
        pstmt.setInt(6, court.getId());
        int rows = pstmt.executeUpdate();
        pstmt.close(); conn.close();
        return rows;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "DELETE FROM court WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        int rows = pstmt.executeUpdate();
        pstmt.close(); conn.close();
        return rows;
    }

    @Override
    public Court getById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM court WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        Court c = null;
        if (rs.next()) {
            c = new Court();
            c.setId(rs.getInt("id"));
            c.setName(rs.getString("name"));
            c.setPosition(rs.getString("position"));
            c.setPrice(rs.getString("price"));
            c.setStatus(rs.getString("status"));
            c.setRemark(rs.getString("remark"));
        }
        rs.close(); pstmt.close(); conn.close();
        return c;
    }
}