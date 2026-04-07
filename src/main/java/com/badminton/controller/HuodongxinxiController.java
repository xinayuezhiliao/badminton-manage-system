package com.badminton.controller;

import com.badminton.entity.Huodongxinxi;
import com.badminton.service.HuodongxinxiService;
import com.badminton.service.impl.HuodongxinxiServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/huodongxinxi")
public class HuodongxinxiController extends HttpServlet {
    private HuodongxinxiService huodongxinxiService = new HuodongxinxiServiceImpl();

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
            List<Huodongxinxi> list = huodongxinxiService.list();
            request.setAttribute("huodongxinxiList", list);
            request.getRequestDispatcher("huodongxinxi_list.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Huodongxinxi huodongxinxi = huodongxinxiService.getById(id);
            request.setAttribute("huodongxinxi", huodongxinxi);
            request.getRequestDispatcher("huodongxinxi_updt.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("huodongxinxi_list.jsp");
        }
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String biaoti = request.getParameter("biaoti");
        String neirong = request.getParameter("neirong");
        String fabushijian = request.getParameter("fabushijian");

        Huodongxinxi obj = new Huodongxinxi();
        obj.setBiaoti(biaoti);
        obj.setNeirong(neirong);
        obj.setFabushijian(fabushijian);

        try {
            huodongxinxiService.add(obj);
            response.sendRedirect("huodongxinxi?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("huodongxinxi_list.jsp");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String biaoti = request.getParameter("biaoti");
        String neirong = request.getParameter("neirong");
        String fabushijian = request.getParameter("fabushijian");

        Huodongxinxi obj = new Huodongxinxi();
        obj.setId(id);
        obj.setBiaoti(biaoti);
        obj.setNeirong(neirong);
        obj.setFabushijian(fabushijian);

        try {
            huodongxinxiService.update(obj);
            response.sendRedirect("huodongxinxi?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("huodongxinxi_list.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            huodongxinxiService.delete(id);
            response.sendRedirect("huodongxinxi?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("huodongxinxi_list.jsp");
        }
    }
}