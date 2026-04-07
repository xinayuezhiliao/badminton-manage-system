package com.badminton.controller;

import com.badminton.entity.Pinglun;
import com.badminton.service.PinglunService;
import com.badminton.service.impl.PinglunServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/pinglun")
public class PinglunController extends HttpServlet {
    private PinglunService pinglunService = new PinglunServiceImpl();

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
            List<Pinglun> list = pinglunService.list();
            request.setAttribute("pinglunList", list);
            request.getRequestDispatcher("pinglun_list.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Pinglun pinglun = pinglunService.getById(id);
            request.setAttribute("pinglun", pinglun);
            request.getRequestDispatcher("pinglun_updt.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("pinglun_list.jsp");
        }
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String biaoti = request.getParameter("biaoti");
        String neirong = request.getParameter("neirong");
        String faburen = request.getParameter("faburen");
        String fabushijian = request.getParameter("fabushijian");

        Pinglun obj = new Pinglun();
        obj.setBiaoti(biaoti);
        obj.setNeirong(neirong);
        obj.setFaburen(faburen);
        obj.setFabushijian(fabushijian);

        try {
            pinglunService.add(obj);
            response.sendRedirect("pinglun?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("pinglun_list.jsp");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String biaoti = request.getParameter("biaoti");
        String neirong = request.getParameter("neirong");
        String faburen = request.getParameter("faburen");
        String fabushijian = request.getParameter("fabushijian");

        Pinglun obj = new Pinglun();
        obj.setId(id);
        obj.setBiaoti(biaoti);
        obj.setNeirong(neirong);
        obj.setFaburen(faburen);
        obj.setFabushijian(fabushijian);

        try {
            pinglunService.update(obj);
            response.sendRedirect("pinglun?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("pinglun_list.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            pinglunService.delete(id);
            response.sendRedirect("pinglun?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("pinglun_list.jsp");
        }
    }
}
