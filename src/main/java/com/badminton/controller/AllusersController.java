package com.badminton.controller;

import com.badminton.entity.Allusers;
import com.badminton.service.AllusersService;
import com.badminton.service.impl.AllusersServiceImpl;
import com.badminton.util.Constant;
import com.badminton.util.Md5;
import com.badminton.util.PageBean;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/allusers")
public class AllusersController extends HttpServlet {
    private AllusersService allusersService = new AllusersServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        if ("list".equals(action)) {
            list(request, response);
        } else if ("searchPage".equals(action)) {
            searchPage(request, response);
        } else if ("delete".equals(action)) {
            delete(request, response);
        } else if ("toUpdate".equals(action)) {
            toUpdate(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            add(request, response);
        } else if ("update".equals(action)) {
            update(request, response);
        } else if ("doSearch".equals(action)) {
            doSearch(request, response);
        }
    }

    // 列表 —— 跳转到 allusers_list.jsp
    private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String pageStr = request.getParameter("page");
            int pageNo = 1;
            int pageSize = 10;
            if (pageStr != null && !pageStr.isEmpty()) {
                pageNo = Integer.parseInt(pageStr);
            }
            PageBean<Allusers> pageBean = allusersService.listPage(pageNo, pageSize);
            
            System.out.println("===== 管理员账号列表 =====");
            System.out.println("数据库总记录数：" + (pageBean.getTotalCount()));
            
            request.setAttribute("page", pageBean);
            request.setAttribute("list", pageBean.getList());
            request.getRequestDispatcher("allusers_list.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    
    // 显示精准查询页面
    private void searchPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("allusers_search.jsp").forward(request, response);
    }
    
    // 执行精准查询
    private void doSearch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String cx = request.getParameter("cx");
            
            System.out.println("===== 管理员账号精准查询开始 =====");
            System.out.println("搜索账号：" + username);
            System.out.println("搜索角色：" + cx);
            
            List<Allusers> allList = allusersService.list();
            List<Allusers> filteredList = new java.util.ArrayList<>();
            
            for (Allusers user : allList) {
                boolean match = true;
                
                if (username != null && !username.trim().isEmpty()) {
                    String dbUsername = user.getUsername();
                    if (dbUsername == null || !dbUsername.contains(username.trim())) {
                        match = false;
                    }
                }
                
                if (cx != null && !cx.trim().isEmpty()) {
                    String dbCx = user.getCx();
                    if (dbCx == null || !dbCx.equals(cx.trim())) {
                        match = false;
                    }
                }
                
                if (match) {
                    filteredList.add(user);
                }
            }
            
            System.out.println("过滤后记录数：" + filteredList.size());
            
            request.setAttribute("allusersList", filteredList);
            request.setAttribute("searchKeyUser", username);
            request.setAttribute("searchKeyCx", cx);
            request.getRequestDispatcher("allusers_search.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // 去修改页面 —— 跳转到 allusers_updt.jsp
    private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Allusers allusers = allusersService.getById(id);
            request.setAttribute("allusers", allusers);
            request.getRequestDispatcher("allusers_updt.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("allusers_list.jsp");
        }
    }

    // 添加 —— 完成后返回列表
    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String pwd = Md5.md5(request.getParameter("pwd"));
        String cx = request.getParameter("cx");

        Allusers allusers = new Allusers();
        allusers.setUsername(username);
        allusers.setPwd(pwd);
        allusers.setCx(cx);

        try {
            allusersService.add(allusers);
            response.sendRedirect("allusers?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("allusers_list.jsp");
        }
    }

    // 修改
    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String pwd = Md5.md5(request.getParameter("pwd"));
        String cx = request.getParameter("cx");

        Allusers allusers = new Allusers();
        allusers.setId(id);
        allusers.setUsername(username);
        allusers.setPwd(pwd);
        allusers.setCx(cx);

        try {
            allusersService.update(allusers);
            response.sendRedirect("allusers?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("allusers_list.jsp");
        }
    }

    // 删除
    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            allusersService.delete(id);
            response.sendRedirect("allusers?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("allusers_list.jsp");
        }
    }
}