package com.badminton.dao.impl;

import com.badminton.dao.QiuzhuoxinxiDao;
import com.badminton.entity.Qiuzhuoxinxi;
import com.badminton.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class QiuzhuoxinxiDaoImpl implements QiuzhuoxinxiDao {
    @Override
    public List<Qiuzhuoxinxi> list() throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM qiuzhuoxinxi ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Qiuzhuoxinxi> list = new ArrayList<>();
        while (rs.next()) {
            Qiuzhuoxinxi q = new Qiuzhuoxinxi();
            q.setId(rs.getInt("id"));
            q.setQiuzhuohao(rs.getString("qiuzhuohao"));
            q.setZhuangtai(rs.getString("zhuangtai"));
            q.setMeixiaoshijifei(rs.getString("meixiaoshijifei"));
            q.setBeizhu(rs.getString("beizhu"));
            q.setAddtime(rs.getString("addtime"));
            list.add(q);
        }
        rs.close();
        pstmt.close();
        conn.close();
        return list;
    }

    @Override
    public int add(Qiuzhuoxinxi qiuzhuoxinxi) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO qiuzhuoxinxi(qiuzhuohao,zhuangtai,meixiaoshijifei,beizhu,addtime) VALUES(?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, qiuzhuoxinxi.getQiuzhuohao());
        pstmt.setString(2, qiuzhuoxinxi.getZhuangtai());
        pstmt.setString(3, qiuzhuoxinxi.getMeixiaoshijifei());
        pstmt.setString(4, qiuzhuoxinxi.getBeizhu());
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        pstmt.setString(5, now);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int update(Qiuzhuoxinxi qiuzhuoxinxi) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE qiuzhuoxinxi SET qiuzhuohao=?,zhuangtai=?,meixiaoshijifei=?,beizhu=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, qiuzhuoxinxi.getQiuzhuohao());
        pstmt.setString(2, qiuzhuoxinxi.getZhuangtai());
        pstmt.setString(3, qiuzhuoxinxi.getMeixiaoshijifei());
        pstmt.setString(4, qiuzhuoxinxi.getBeizhu());
        pstmt.setInt(5, qiuzhuoxinxi.getId());
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "DELETE FROM qiuzhuoxinxi WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public Qiuzhuoxinxi getById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM qiuzhuoxinxi WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        Qiuzhuoxinxi q = null;
        if (rs.next()) {
            q = new Qiuzhuoxinxi();
            q.setId(rs.getInt("id"));
            q.setQiuzhuohao(rs.getString("qiuzhuohao"));
            q.setZhuangtai(rs.getString("zhuangtai"));
            q.setMeixiaoshijifei(rs.getString("meixiaoshijifei"));
            q.setBeizhu(rs.getString("beizhu"));
            q.setAddtime(rs.getString("addtime"));
        }
        rs.close();
        pstmt.close();
        conn.close();
        return q;
    }
}
