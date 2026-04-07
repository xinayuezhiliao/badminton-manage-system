package com.badminton.dao.impl;

import com.badminton.dao.YonghuzhuceDao;
import com.badminton.entity.Yonghuzhuce;
import com.badminton.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class YonghuzhuceDaoImpl implements YonghuzhuceDao {
    @Override
    public List<Yonghuzhuce> list() throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM yonghuzhuce ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Yonghuzhuce> list = new ArrayList<>();
        while (rs.next()) {
            Yonghuzhuce y = new Yonghuzhuce();
            y.setId(rs.getInt("id"));
            y.setYonghuming(rs.getString("yonghuming"));
            y.setMima(rs.getString("mima"));
            y.setXingming(rs.getString("xingming"));
            y.setXingbie(rs.getString("xingbie"));
            y.setChushengnianyue(rs.getString("chushengnianyue"));
            y.setQQ(rs.getString("QQ"));
            y.setYouxiang(rs.getString("youxiang"));
            y.setShouji(rs.getString("shouji"));
            y.setShenfenzheng(rs.getString("shenfenzheng"));
            y.setTouxiang(rs.getString("touxiang"));
            y.setDizhi(rs.getString("dizhi"));
            y.setBeizhu(rs.getString("beizhu"));
            y.setAddtime(rs.getString("addtime"));
            list.add(y);
        }
        rs.close();
        pstmt.close();
        conn.close();
        return list;
    }

    @Override
    public int add(Yonghuzhuce yonghuzhuce) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO yonghuzhuce(yonghuming,mima,xingming,xingbie,chushengnianyue,QQ,youxiang,shouji,shenfenzheng,touxiang,dizhi,beizhu,addtime) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, yonghuzhuce.getYonghuming());
        pstmt.setString(2, yonghuzhuce.getMima());
        pstmt.setString(3, yonghuzhuce.getXingming());
        pstmt.setString(4, yonghuzhuce.getXingbie());
        pstmt.setString(5, yonghuzhuce.getChushengnianyue());
        pstmt.setString(6, yonghuzhuce.getQQ());
        pstmt.setString(7, yonghuzhuce.getYouxiang());
        pstmt.setString(8, yonghuzhuce.getShouji());
        pstmt.setString(9, yonghuzhuce.getShenfenzheng());
        pstmt.setString(10, yonghuzhuce.getTouxiang());
        pstmt.setString(11, yonghuzhuce.getDizhi());
        pstmt.setString(12, yonghuzhuce.getBeizhu());
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        pstmt.setString(13, now);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int update(Yonghuzhuce yonghuzhuce) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE yonghuzhuce SET yonghuming=?,mima=?,xingming=?,xingbie=?,chushengnianyue=?,QQ=?,youxiang=?,shouji=?,shenfenzheng=?,touxiang=?,dizhi=?,beizhu=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, yonghuzhuce.getYonghuming());
        pstmt.setString(2, yonghuzhuce.getMima());
        pstmt.setString(3, yonghuzhuce.getXingming());
        pstmt.setString(4, yonghuzhuce.getXingbie());
        pstmt.setString(5, yonghuzhuce.getChushengnianyue());
        pstmt.setString(6, yonghuzhuce.getQQ());
        pstmt.setString(7, yonghuzhuce.getYouxiang());
        pstmt.setString(8, yonghuzhuce.getShouji());
        pstmt.setString(9, yonghuzhuce.getShenfenzheng());
        pstmt.setString(10, yonghuzhuce.getTouxiang());
        pstmt.setString(11, yonghuzhuce.getDizhi());
        pstmt.setString(12, yonghuzhuce.getBeizhu());
        pstmt.setInt(13, yonghuzhuce.getId());
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "DELETE FROM yonghuzhuce WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public Yonghuzhuce getById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM yonghuzhuce WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        Yonghuzhuce y = null;
        if (rs.next()) {
            y = new Yonghuzhuce();
            y.setId(rs.getInt("id"));
            y.setYonghuming(rs.getString("yonghuming"));
            y.setMima(rs.getString("mima"));
            y.setXingming(rs.getString("xingming"));
            y.setXingbie(rs.getString("xingbie"));
            y.setChushengnianyue(rs.getString("chushengnianyue"));
            y.setQQ(rs.getString("QQ"));
            y.setYouxiang(rs.getString("youxiang"));
            y.setShouji(rs.getString("shouji"));
            y.setShenfenzheng(rs.getString("shenfenzheng"));
            y.setTouxiang(rs.getString("touxiang"));
            y.setDizhi(rs.getString("dizhi"));
            y.setBeizhu(rs.getString("beizhu"));
            y.setAddtime(rs.getString("addtime"));
        }
        rs.close();
        pstmt.close();
        conn.close();
        return y;
    }
}
