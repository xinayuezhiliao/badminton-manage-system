package com.badminton.dao.impl;

import com.badminton.dao.DingzhuoxinxiDao;
import com.badminton.entity.Dingzhuoxinxi;
import com.badminton.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class DingzhuoxinxiDaoImpl implements DingzhuoxinxiDao {

    @Override
    public List<Dingzhuoxinxi> list(String qiuzhuohao, String meixiaoshijifei, String huiyuanbianhao, String xingming, String huiyuandengji, String zhekou) throws SQLException {
        Connection conn = DBUtil.getConnection();
        StringBuilder sql = new StringBuilder("SELECT * FROM dingzhuoxinxi WHERE 1=1 ");
        if (qiuzhuohao != null && !qiuzhuohao.isEmpty()) sql.append("AND qiuzhuohao LIKE ? ");
        if (meixiaoshijifei != null && !meixiaoshijifei.isEmpty()) sql.append("AND meixiaoshijifei LIKE ? ");
        if (huiyuanbianhao != null && !huiyuanbianhao.isEmpty()) sql.append("AND huiyuanbianhao LIKE ? ");
        if (xingming != null && !xingming.isEmpty()) sql.append("AND xingming LIKE ? ");
        if (huiyuandengji != null && !huiyuandengji.isEmpty()) sql.append("AND huiyuandengji LIKE ? ");
        if (zhekou != null && !zhekou.isEmpty()) sql.append("AND zhekou LIKE ? ");
        sql.append("ORDER BY id DESC");

        PreparedStatement pstmt = conn.prepareStatement(sql.toString());
        int index = 1;
        if (qiuzhuohao != null && !qiuzhuohao.isEmpty()) pstmt.setString(index++, "%" + qiuzhuohao + "%");
        if (meixiaoshijifei != null && !meixiaoshijifei.isEmpty()) pstmt.setString(index++, "%" + meixiaoshijifei + "%");
        if (huiyuanbianhao != null && !huiyuanbianhao.isEmpty()) pstmt.setString(index++, "%" + huiyuanbianhao + "%");
        if (xingming != null && !xingming.isEmpty()) pstmt.setString(index++, "%" + xingming + "%");
        if (huiyuandengji != null && !huiyuandengji.isEmpty()) pstmt.setString(index++, "%" + huiyuandengji + "%");
        if (zhekou != null && !zhekou.isEmpty()) pstmt.setString(index++, "%" + zhekou + "%");

        ResultSet rs = pstmt.executeQuery();
        List<Dingzhuoxinxi> list = new ArrayList<>();
        while (rs.next()) {
            Dingzhuoxinxi d = new Dingzhuoxinxi();
            d.setId(rs.getInt("id"));
            d.setQiuzhuohao(rs.getString("qiuzhuohao"));
            d.setMeixiaoshijifei(rs.getString("meixiaoshijifei"));
            d.setDingzhuoshijian(rs.getString("dingzhuoshijian"));
            d.setHuiyuanbianhao(rs.getString("huiyuanbianhao"));
            d.setXingming(rs.getString("xingming"));
            d.setHuiyuandengji(rs.getString("huiyuandengji"));
            d.setZhekou(rs.getString("zhekou"));
            d.setBeizhu(rs.getString("beizhu"));
            d.setAddtime(rs.getString("addtime"));
            list.add(d);
        }
        rs.close();
        pstmt.close();
        conn.close();
        return list;
    }

    @Override
    public int add(Dingzhuoxinxi dingzhuoxinxi) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO dingzhuoxinxi(qiuzhuohao,meixiaoshijifei,dingzhuoshijian,huiyuanbianhao,xingming,huiyuandengji,zhekou,beizhu,addtime) VALUES(?,?,?,?,?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, dingzhuoxinxi.getQiuzhuohao());
        pstmt.setString(2, dingzhuoxinxi.getMeixiaoshijifei());
        pstmt.setString(3, dingzhuoxinxi.getDingzhuoshijian());
        pstmt.setString(4, dingzhuoxinxi.getHuiyuanbianhao());
        pstmt.setString(5, dingzhuoxinxi.getXingming());
        pstmt.setString(6, dingzhuoxinxi.getHuiyuandengji());
        pstmt.setString(7, dingzhuoxinxi.getZhekou());
        pstmt.setString(8, dingzhuoxinxi.getBeizhu());
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        pstmt.setString(9, now);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int update(Dingzhuoxinxi dingzhuoxinxi) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE dingzhuoxinxi SET qiuzhuohao=?,meixiaoshijifei=?,dingzhuoshijian=?,huiyuanbianhao=?,xingming=?,huiyuandengji=?,zhekou=?,beizhu=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, dingzhuoxinxi.getQiuzhuohao());
        pstmt.setString(2, dingzhuoxinxi.getMeixiaoshijifei());
        pstmt.setString(3, dingzhuoxinxi.getDingzhuoshijian());
        pstmt.setString(4, dingzhuoxinxi.getHuiyuanbianhao());
        pstmt.setString(5, dingzhuoxinxi.getXingming());
        pstmt.setString(6, dingzhuoxinxi.getHuiyuandengji());
        pstmt.setString(7, dingzhuoxinxi.getZhekou());
        pstmt.setString(8, dingzhuoxinxi.getBeizhu());
        pstmt.setInt(9, dingzhuoxinxi.getId());
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "DELETE FROM dingzhuoxinxi WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public Dingzhuoxinxi getById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM dingzhuoxinxi WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        Dingzhuoxinxi d = null;
        if (rs.next()) {
            d = new Dingzhuoxinxi();
            d.setId(rs.getInt("id"));
            d.setQiuzhuohao(rs.getString("qiuzhuohao"));
            d.setMeixiaoshijifei(rs.getString("meixiaoshijifei"));
            d.setDingzhuoshijian(rs.getString("dingzhuoshijian"));
            d.setHuiyuanbianhao(rs.getString("huiyuanbianhao"));
            d.setXingming(rs.getString("xingming"));
            d.setHuiyuandengji(rs.getString("huiyuandengji"));
            d.setZhekou(rs.getString("zhekou"));
            d.setBeizhu(rs.getString("beizhu"));
            d.setAddtime(rs.getString("addtime"));
        }
        rs.close();
        pstmt.close();
        conn.close();
        return d;
    }
}
