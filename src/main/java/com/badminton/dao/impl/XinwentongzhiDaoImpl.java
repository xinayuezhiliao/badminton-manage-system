package com.badminton.dao.impl;

import com.badminton.dao.XinwentongzhiDao;
import com.badminton.entity.Xinwentongzhi;
import com.badminton.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class XinwentongzhiDaoImpl implements XinwentongzhiDao {
    @Override
    public List<Xinwentongzhi> list() throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM xinwentongzhi ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Xinwentongzhi> list = new ArrayList<>();
        while (rs.next()) {
            Xinwentongzhi x = new Xinwentongzhi();
            x.setId(rs.getInt("id"));
            x.setXinwenbiaoti(rs.getString("xinwenbiaoti"));
            x.setXinwenleixing(rs.getString("xinwenleixing"));
            x.setXinwenfengmian(rs.getString("xinwenfengmian"));
            x.setFabushijian(rs.getString("fabushijian"));
            x.setFaburen(rs.getString("faburen"));
            x.setXinwenneirong(rs.getString("xinwenneirong"));
            x.setAddtime(rs.getString("addtime"));
            list.add(x);
        }
        rs.close();
        pstmt.close();
        conn.close();
        return list;
    }

    @Override
    public int add(Xinwentongzhi xinwentongzhi) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO xinwentongzhi(xinwenbiaoti,xinwenleixing,xinwenfengmian,fabushijian,faburen,xinwenneirong,addtime) VALUES(?,?,?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, xinwentongzhi.getXinwenbiaoti());
        pstmt.setString(2, xinwentongzhi.getXinwenleixing());
        pstmt.setString(3, xinwentongzhi.getXinwenfengmian());
        pstmt.setString(4, xinwentongzhi.getFabushijian());
        pstmt.setString(5, xinwentongzhi.getFaburen());
        pstmt.setString(6, xinwentongzhi.getXinwenneirong());
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        pstmt.setString(7, now);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int update(Xinwentongzhi xinwentongzhi) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE xinwentongzhi SET xinwenbiaoti=?,xinwenleixing=?,xinwenfengmian=?,fabushijian=?,faburen=?,xinwenneirong=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, xinwentongzhi.getXinwenbiaoti());
        pstmt.setString(2, xinwentongzhi.getXinwenleixing());
        pstmt.setString(3, xinwentongzhi.getXinwenfengmian());
        pstmt.setString(4, xinwentongzhi.getFabushijian());
        pstmt.setString(5, xinwentongzhi.getFaburen());
        pstmt.setString(6, xinwentongzhi.getXinwenneirong());
        pstmt.setInt(7, xinwentongzhi.getId());
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "DELETE FROM xinwentongzhi WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public Xinwentongzhi getById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM xinwentongzhi WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        Xinwentongzhi x = null;
        if (rs.next()) {
            x = new Xinwentongzhi();
            x.setId(rs.getInt("id"));
            x.setXinwenbiaoti(rs.getString("xinwenbiaoti"));
            x.setXinwenleixing(rs.getString("xinwenleixing"));
            x.setXinwenfengmian(rs.getString("xinwenfengmian"));
            x.setFabushijian(rs.getString("fabushijian"));
            x.setFaburen(rs.getString("faburen"));
            x.setXinwenneirong(rs.getString("xinwenneirong"));
            x.setAddtime(rs.getString("addtime"));
        }
        rs.close();
        pstmt.close();
        conn.close();
        return x;
    }
}