package com.badminton.controller;

import com.badminton.entity.User;
import com.badminton.service.UserService;
import com.badminton.service.impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/hsgloginyanzheng.jsp")
public class HsgLoginYanzhengController extends HttpServlet {
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String pwd = request.getParameter("pwd");
        String cx = request.getParameter("cx");
        String pagerandom = request.getParameter("pagerandom");
        String yzm = (String) request.getSession().getAttribute("random");

        System.out.println("登录调试 - 用户名:" + username + ", 密码:" + pwd + ", 权限:" + cx);
        System.out.println("登录调试 - 输入验证码:" + pagerandom + ", Session验证码:" + yzm);

        // 验证码验证
         if (pagerandom == null || yzm == null || !pagerandom.equals(yzm)) {
             request.setAttribute("msg", "验证码错误");
             request.getRequestDispatcher("/login.jsp").forward(request, response);
             return;
         }

        // 密码验证
        User user = userService.login(username, pwd, cx);
        if (user == null) {
            request.setAttribute("msg", "用户名或密码错误");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("username", username);
        session.setAttribute("cx", cx);
        System.out.println("登录调试 - 登录成功，跳转到main.jsp");
        response.sendRedirect(request.getContextPath() + "/main.jsp");
    }
}