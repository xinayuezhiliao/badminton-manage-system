package com.badminton.dao.impl;

import com.badminton.dao.FufeiDao;
import com.badminton.entity.Fufei;
import com.badminton.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class FufeiDaoImpl implements FufeiDao {
    @Override
    public List<Fufei> list() throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM fufei ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Fufei> list = new ArrayList<>();
        while (rs.next()) {
            Fufei f = new Fufei();
            f.setId(rs.getInt("id"));
            f.setQiuzhuohao(rs.getString("qiuzhuohao"));
            f.setMeixiaoshijifei(rs.getString("meixiaoshijifei"));
            f.setZongshichang(rs.getString("zongshichang"));
            f.setHuiyuanbianhao(rs.getString("huiyuanbianhao"));
            f.setXingming(rs.getString("xingming"));
            f.setHuiyuandengji(rs.getString("huiyuandengji"));
            f.setZhekou(rs.getString("zhekou"));
            f.setZongjine(rs.getString("zongjine"));
            f.setBeizhu(rs.getString("beizhu"));
            f.setIssh(rs.getString("issh"));
            f.setAddtime(rs.getString("addtime"));
            list.add(f);
        }
        rs.close();
        pstmt.close();
        conn.close();
        return list;
    }

    @Override
    public List<Fufei> listByHuiyuanbianhao(String huiyuanbianhao) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM fufei WHERE huiyuanbianhao=? ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, huiyuanbianhao);
        ResultSet rs = pstmt.executeQuery();
        List<Fufei> list = new ArrayList<>();
        while (rs.next()) {
            Fufei f = new Fufei();
            f.setId(rs.getInt("id"));
            f.setQiuzhuohao(rs.getString("qiuzhuohao"));
            f.setMeixiaoshijifei(rs.getString("meixiaoshijifei"));
            f.setZongshichang(rs.getString("zongshichang"));
            f.setHuiyuanbianhao(rs.getString("huiyuanbianhao"));
            f.setXingming(rs.getString("xingming"));
            f.setHuiyuandengji(rs.getString("huiyuandengji"));
            f.setZhekou(rs.getString("zhekou"));
            f.setZongjine(rs.getString("zongjine"));
            f.setBeizhu(rs.getString("beizhu"));
            f.setIssh(rs.getString("issh"));
            f.setAddtime(rs.getString("addtime"));
            list.add(f);
        }
        rs.close();
        pstmt.close();
        conn.close();
        return list;
    }

    @Override
    public int add(Fufei fufei) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO fufei(qiuzhuohao,meixiaoshijifei,zongshichang,huiyuanbianhao,xingming,huiyuandengji,zhekou,zongjine,beizhu,issh,addtime) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, fufei.getQiuzhuohao());
        pstmt.setString(2, fufei.getMeixiaoshijifei());
        pstmt.setString(3, fufei.getZongshichang());
        pstmt.setString(4, fufei.getHuiyuanbianhao());
        pstmt.setString(5, fufei.getXingming());
        pstmt.setString(6, fufei.getHuiyuandengji());
        pstmt.setString(7, fufei.getZhekou());
        pstmt.setString(8, fufei.getZongjine());
        pstmt.setString(9, fufei.getBeizhu());
        pstmt.setString(10, fufei.getIssh());
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        pstmt.setString(11, now);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int update(Fufei fufei) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE fufei SET qiuzhuohao=?,meixiaoshijifei=?,zongshichang=?,huiyuanbianhao=?,xingming=?,huiyuandengji=?,zhekou=?,zongjine=?,beizhu=?,issh=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, fufei.getQiuzhuohao());
        pstmt.setString(2, fufei.getMeixiaoshijifei());
        pstmt.setString(3, fufei.getZongshichang());
        pstmt.setString(4, fufei.getHuiyuanbianhao());
        pstmt.setString(5, fufei.getXingming());
        pstmt.setString(6, fufei.getHuiyuandengji());
        pstmt.setString(7, fufei.getZhekou());
        pstmt.setString(8, fufei.getZongjine());
        pstmt.setString(9, fufei.getBeizhu());
        pstmt.setString(10, fufei.getIssh());
        pstmt.setInt(11, fufei.getId());
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "DELETE FROM fufei WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public Fufei getById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM fufei WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        Fufei f = null;
        if (rs.next()) {
            f = new Fufei();
            f.setId(rs.getInt("id"));
            f.setQiuzhuohao(rs.getString("qiuzhuohao"));
            f.setMeixiaoshijifei(rs.getString("meixiaoshijifei"));
            f.setZongshichang(rs.getString("zongshichang"));
            f.setHuiyuanbianhao(rs.getString("huiyuanbianhao"));
            f.setXingming(rs.getString("xingming"));
            f.setHuiyuandengji(rs.getString("huiyuandengji"));
            f.setZhekou(rs.getString("zhekou"));
            f.setZongjine(rs.getString("zongjine"));
            f.setBeizhu(rs.getString("beizhu"));
            f.setIssh(rs.getString("issh"));
            f.setAddtime(rs.getString("addtime"));
        }
        rs.close();
        pstmt.close();
        conn.close();
        return f;
    }
}
