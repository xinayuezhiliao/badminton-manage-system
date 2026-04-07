package com.badminton.controller;

import com.badminton.entity.Liuyanban;
import com.badminton.service.LiuyanbanService;
import com.badminton.service.impl.LiuyanbanServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/liuyanban")
public class LiuyanbanController extends HttpServlet {
    private LiuyanbanService liuyanbanService = new LiuyanbanServiceImpl();

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
            List<Liuyanban> list = liuyanbanService.list();
            request.setAttribute("liuyanbanList", list);
            request.getRequestDispatcher("liuyanban_list.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Liuyanban liuyanban = liuyanbanService.getById(id);
            request.setAttribute("liuyanban", liuyanban);
            request.getRequestDispatcher("liuyanban_updt.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("liuyanban_list.jsp");
        }
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String biaoti = request.getParameter("biaoti");
        String neirong = request.getParameter("neirong");
        String lianxifangshi = request.getParameter("lianxifangshi");
        String liuyanshijian = request.getParameter("liuyanshijian");

        Liuyanban obj = new Liuyanban();
        obj.setBiaoti(biaoti);
        obj.setNeirong(neirong);
        obj.setLianxifangshi(lianxifangshi);
        obj.setLiuyanshijian(liuyanshijian);

        try {
            liuyanbanService.add(obj);
            response.sendRedirect("liuyanban?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("liuyanban_list.jsp");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String biaoti = request.getParameter("biaoti");
        String neirong = request.getParameter("neirong");
        String lianxifangshi = request.getParameter("lianxifangshi");
        String liuyanshijian = request.getParameter("liuyanshijian");

        Liuyanban obj = new Liuyanban();
        obj.setId(id);
        obj.setBiaoti(biaoti);
        obj.setNeirong(neirong);
        obj.setLianxifangshi(lianxifangshi);
        obj.setLiuyanshijian(liuyanshijian);

        try {
            liuyanbanService.update(obj);
            response.sendRedirect("liuyanban?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("liuyanban_list.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            liuyanbanService.delete(id);
            response.sendRedirect("liuyanban?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("liuyanban_list.jsp");
        }
    }
}