package com.badminton.dao.impl;

import com.badminton.dao.UserDao;
import com.badminton.entity.User;
import com.badminton.util.DBUtil;
import com.badminton.util.Md5;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDaoImpl implements UserDao {

    @Override
    public User login(String username, String pwd, String cx) throws SQLException {
        Connection conn = DBUtil.getConnection();
        String sql;
        PreparedStatement pstmt;
        
        if ("huiyuan".equals(cx)) {
            // 会员登录，查询huiyuanxinxi表（密码明文存储）
            sql = "SELECT * FROM huiyuanxinxi WHERE huiyuanbianhao=? AND mima=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, pwd);
        } else {
            // 管理员登录，查询allusers表（密码MD5加密存储）
            sql = "SELECT * FROM allusers WHERE username=? AND pwd=? AND cx=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, Md5.md5(pwd));
            pstmt.setString(3, cx);
        }
        
        ResultSet rs = pstmt.executeQuery();

        User user = null;
        if (rs.next()) {
            user = new User();
            user.setId(rs.getInt("id"));
            user.setUsername(username);
            user.setPwd(pwd);
            user.setCx(cx);
        }

        rs.close();
        pstmt.close();
        conn.close();
        return user;
    }
}