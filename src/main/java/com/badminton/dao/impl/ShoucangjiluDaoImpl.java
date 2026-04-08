package com.badminton.dao.impl;

import com.badminton.dao.ShoucangjiluDao;
import com.badminton.entity.Shoucangjilu;
import com.badminton.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class ShoucangjiluDaoImpl implements ShoucangjiluDao {
    @Override
    public List<Shoucangjilu> list() throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM shoucangjilu ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Shoucangjilu> list = new ArrayList<>();
        while (rs.next()) {
            Shoucangjilu s = new Shoucangjilu();
            s.setId(rs.getInt("id"));
            s.setQiuzhuohao(rs.getString("qiuzhuohao"));
            s.setMingcheng(rs.getString("mingcheng"));
            s.setYonghuzhanghao(rs.getString("yonghuzhanghao"));
            s.setShoucangshijian(rs.getString("shoucangshijian"));
            s.setAddtime(rs.getString("addtime"));
            list.add(s);
        }
        rs.close();
        pstmt.close();
        conn.close();
        return list;
    }

    @Override
    public int add(Shoucangjilu shoucangjilu) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "INSERT INTO shoucangjilu(qiuzhuohao,mingcheng,yonghuzhanghao,shoucangshijian,addtime) VALUES(?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, shoucangjilu.getQiuzhuohao());
        pstmt.setString(2, shoucangjilu.getMingcheng());
        pstmt.setString(3, shoucangjilu.getYonghuzhanghao());
        pstmt.setString(4, shoucangjilu.getShoucangshijian());
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        pstmt.setString(5, now);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int update(Shoucangjilu shoucangjilu) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE shoucangjilu SET qiuzhuohao=?,mingcheng=?,yonghuzhanghao=?,shoucangshijian=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, shoucangjilu.getQiuzhuohao());
        pstmt.setString(2, shoucangjilu.getMingcheng());
        pstmt.setString(3, shoucangjilu.getYonghuzhanghao());
        pstmt.setString(4, shoucangjilu.getShoucangshijian());
        pstmt.setInt(5, shoucangjilu.getId());
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "DELETE FROM shoucangjilu WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        int rows = pstmt.executeUpdate();
        pstmt.close();
        conn.close();
        return rows;
    }

    @Override
    public Shoucangjilu getById(Integer id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql = "SELECT * FROM shoucangjilu WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        Shoucangjilu s = null;
        if (rs.next()) {
            s = new Shoucangjilu();
            s.setId(rs.getInt("id"));
            s.setQiuzhuohao(rs.getString("qiuzhuohao"));
            s.setMingcheng(rs.getString("mingcheng"));
            s.setYonghuzhanghao(rs.getString("yonghuzhanghao"));
            s.setShoucangshijian(rs.getString("shoucangshijian"));
            s.setAddtime(rs.getString("addtime"));
        }
        rs.close();
        pstmt.close();
        conn.close();
        return s;
    }
}
