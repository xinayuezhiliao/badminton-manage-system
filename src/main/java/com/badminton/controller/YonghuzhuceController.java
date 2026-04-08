package com.badminton.controller;

import com.badminton.entity.Yonghuzhuce;
import com.badminton.service.YonghuzhuceService;
import com.badminton.service.impl.YonghuzhuceServiceImpl;
import com.badminton.util.Md5;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/yonghuzhuce")
public class YonghuzhuceController extends HttpServlet {
    private YonghuzhuceService yonghuzhuceService = new YonghuzhuceServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        if ("list".equals(action)) {
            list(request, response);
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
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Yonghuzhuce> list = yonghuzhuceService.list();
            request.setAttribute("yonghuzhuceList", list);
            request.getRequestDispatcher("yonghuzhuce_list.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Yonghuzhuce yonghuzhuce = yonghuzhuceService.getById(id);
            request.setAttribute("yonghuzhuce", yonghuzhuce);
            request.getRequestDispatcher("yonghuzhuce_updt.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("yonghuzhuce_list.jsp");
        }
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String yonghuming = request.getParameter("yonghuming");
        String mima = Md5.md5(request.getParameter("mima"));
        String xingming = request.getParameter("xingming");
        String xingbie = request.getParameter("xingbie");
        String chushengnianyue = request.getParameter("chushengnianyue");
        String QQ = request.getParameter("QQ");
        String youxiang = request.getParameter("youxiang");
        String shouji = request.getParameter("shouji");
        String shenfenzheng = request.getParameter("shenfenzheng");
        String touxiang = request.getParameter("touxiang");
        String dizhi = request.getParameter("dizhi");
        String beizhu = request.getParameter("beizhu");

        Yonghuzhuce obj = new Yonghuzhuce();
        obj.setYonghuming(yonghuming);
        obj.setMima(mima);
        obj.setXingming(xingming);
        obj.setXingbie(xingbie);
        obj.setChushengnianyue(chushengnianyue);
        obj.setQQ(QQ);
        obj.setYouxiang(youxiang);
        obj.setShouji(shouji);
        obj.setShenfenzheng(shenfenzheng);
        obj.setTouxiang(touxiang);
        obj.setDizhi(dizhi);
        obj.setBeizhu(beizhu);

        try {
            yonghuzhuceService.add(obj);
            response.sendRedirect("yonghuzhuce?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("yonghuzhuce_list.jsp");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String yonghuming = request.getParameter("yonghuming");
        String mima = Md5.md5(request.getParameter("mima"));
        String xingming = request.getParameter("xingming");
        String xingbie = request.getParameter("xingbie");
        String chushengnianyue = request.getParameter("chushengnianyue");
        String QQ = request.getParameter("QQ");
        String youxiang = request.getParameter("youxiang");
        String shouji = request.getParameter("shouji");
        String shenfenzheng = request.getParameter("shenfenzheng");
        String touxiang = request.getParameter("touxiang");
        String dizhi = request.getParameter("dizhi");
        String beizhu = request.getParameter("beizhu");

        Yonghuzhuce obj = new Yonghuzhuce();
        obj.setId(id);
        obj.setYonghuming(yonghuming);
        obj.setMima(mima);
        obj.setXingming(xingming);
        obj.setXingbie(xingbie);
        obj.setChushengnianyue(chushengnianyue);
        obj.setQQ(QQ);
        obj.setYouxiang(youxiang);
        obj.setShouji(shouji);
        obj.setShenfenzheng(shenfenzheng);
        obj.setTouxiang(touxiang);
        obj.setDizhi(dizhi);
        obj.setBeizhu(beizhu);

        try {
            yonghuzhuceService.update(obj);
            response.sendRedirect("yonghuzhuce?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("yonghuzhuce_list.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            yonghuzhuceService.delete(id);
            response.sendRedirect("yonghuzhuce?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("yonghuzhuce_list.jsp");
        }
    }
}
