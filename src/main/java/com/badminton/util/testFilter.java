package com.badminton.util;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class testFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        String path = req.getServletPath();

        // 放行登录、注册、验证码等页面
        if (path.contains("login") || path.contains("register") || path.contains("checkCode")) {
            chain.doFilter(request, response);
            return;
        }

        // 检查用户是否登录
        Object user = req.getSession().getAttribute(Constant.LOGIN_USER);
        Object admin = req.getSession().getAttribute(Constant.LOGIN_ADMIN);
        if (user == null && admin == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}