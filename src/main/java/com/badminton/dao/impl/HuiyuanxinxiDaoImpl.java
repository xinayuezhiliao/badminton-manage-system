package com.badminton.dao.impl;

import com.badminton.dao.HuiyuanxinxiDao;
import com.badminton.entity.Huiyuanxinxi;
import com.badminton.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class HuiyuanxinxiDaoImpl implements HuiyuanxinxiDao {
    @Override
    public List<Huiyuanxinxi> list() throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM huiyuanxinxi ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Huiyuanxinxi> list = new ArrayList<>();
        while (rs.next()) {
            Huiyuanxinxi h = new Huiyuanxinxi();
            h.setId(rs.getInt("id"));
            h.setHuiyuanbianhao(rs.getString("huiyuanbianhao"));
            h.setMima(rs.getString("mima"));
            h.setXingming(rs.getString("xingming"));
            h.setXingbie(rs.getString("xingbie"));
            h.setHuiyuandengji(rs.getString("huiyuandengji"));
            h.setZhekou(rs.getString("zhekou"));
            h.setShouji(rs.getString("shouji"));
            h.setBeizhu(rs.getString("beizhu"));
            h.setAddtime(rs.getString("addtime"));
            h.setYue(rs.getString("yue"));
            list.add(h);
        }
        rs.close();
        pstmt.close();
        conn.close();
        return list;
    }

    @Override
    public int add(Huiyuanxinxi huiyuanxinxi) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO huiyuanxinxi(huiyuanbianhao,mima,xingming,xingbie,huiyuandengji,zhekou,shouji,beizhu,yue,addtime) VALUES(?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, huiyuanxinxi.getHuiyuanbianhao());
        pstmt.setString(2, huiyuanxinxi.getMima());
        pstmt.setString(3, huiyuanxinxi.getXingming());
        pstmt.setString(4, huiyuanxinxi.getXingbie());
        pstmt.setString(5, huiyuanxinxi.getHuiyuandengji());
        pstmt.setString(6, huiyuanxinxi.getZhekou());
        pstmt.setString(7, huiyuanxinxi.getShouji());
        pstmt.setString(8, huiyuanxinxi.getBeizhu());
        pstmt.setString(9, huiyuanxinxi.getYue());
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        pstmt.setString(10, now);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int update(Huiyuanxinxi huiyuanxinxi) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE huiyuanxinxi SET huiyuanbianhao=?,mima=?,xingming=?,xingbie=?,huiyuandengji=?,zhekou=?,shouji=?,beizhu=?,yue=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, huiyuanxinxi.getHuiyuanbianhao());
        pstmt.setString(2, huiyuanxinxi.getMima());
        pstmt.setString(3, huiyuanxinxi.getXingming());
        pstmt.setString(4, huiyuanxinxi.getXingbie());
        pstmt.setString(5, huiyuanxinxi.getHuiyuandengji());
        pstmt.setString(6, huiyuanxinxi.getZhekou());
        pstmt.setString(7, huiyuanxinxi.getShouji());
        pstmt.setString(8, huiyuanxinxi.getBeizhu());
        pstmt.setString(9, huiyuanxinxi.getYue());
        pstmt.setInt(10, huiyuanxinxi.getId());
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "DELETE FROM huiyuanxinxi WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public Huiyuanxinxi getById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM huiyuanxinxi WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        Huiyuanxinxi h = null;
        if (rs.next()) {
            h = new Huiyuanxinxi();
            h.setId(rs.getInt("id"));
            h.setHuiyuanbianhao(rs.getString("huiyuanbianhao"));
            h.setMima(rs.getString("mima"));
            h.setXingming(rs.getString("xingming"));
            h.setXingbie(rs.getString("xingbie"));
            h.setHuiyuandengji(rs.getString("huiyuandengji"));
            h.setZhekou(rs.getString("zhekou"));
            h.setShouji(rs.getString("shouji"));
            h.setBeizhu(rs.getString("beizhu"));
            h.setAddtime(rs.getString("addtime"));
            h.setYue(rs.getString("yue"));
        }
        rs.close();
        pstmt.close();
        conn.close();
        return h;
    }

    @Override
    public Huiyuanxinxi getByHuiyuanbianhao(String huiyuanbianhao) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM huiyuanxinxi WHERE huiyuanbianhao=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, huiyuanbianhao);
        ResultSet rs = pstmt.executeQuery();
        Huiyuanxinxi h = null;
        if (rs.next()) {
            h = new Huiyuanxinxi();
            h.setId(rs.getInt("id"));
            h.setHuiyuanbianhao(rs.getString("huiyuanbianhao"));
            h.setMima(rs.getString("mima"));
            h.setXingming(rs.getString("xingming"));
            h.setXingbie(rs.getString("xingbie"));
            h.setHuiyuandengji(rs.getString("huiyuandengji"));
            h.setZhekou(rs.getString("zhekou"));
            h.setShouji(rs.getString("shouji"));
            h.setBeizhu(rs.getString("beizhu"));
            h.setAddtime(rs.getString("addtime"));
            h.setYue(rs.getString("yue"));
        }
        rs.close();
        pstmt.close();
        conn.close();
        return h;
    }

    @Override
    public Huiyuanxinxi login(String huiyuanbianhao, String mima) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM huiyuanxinxi WHERE huiyuanbianhao=? AND mima=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, huiyuanbianhao);
        pstmt.setString(2, mima);
        ResultSet rs = pstmt.executeQuery();
        Huiyuanxinxi h = null;
        if (rs.next()) {
            h = new Huiyuanxinxi();
            h.setId(rs.getInt("id"));
            h.setHuiyuanbianhao(rs.getString("huiyuanbianhao"));
            h.setMima(rs.getString("mima"));
            h.setXingming(rs.getString("xingming"));
            h.setXingbie(rs.getString("xingbie"));
            h.setHuiyuandengji(rs.getString("huiyuandengji"));
            h.setZhekou(rs.getString("zhekou"));
            h.setShouji(rs.getString("shouji"));
            h.setBeizhu(rs.getString("beizhu"));
            h.setAddtime(rs.getString("addtime"));
            h.setYue(rs.getString("yue"));
        }
        rs.close();
        pstmt.close();
        conn.close();
        return h;
    }
}
