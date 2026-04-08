package com.badminton.controller;

import com.badminton.entity.Youqinglianjie;
import com.badminton.service.YouqinglianjieService;
import com.badminton.service.impl.YouqinglianjieServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/youqinglianjie")
public class YouqinglianjieController extends HttpServlet {
    private YouqinglianjieService youqinglianjieService = new YouqinglianjieServiceImpl();

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
            List<Youqinglianjie> list = youqinglianjieService.list();
            request.setAttribute("youqinglianjieList", list);
            request.getRequestDispatcher("youqinglianjie_list.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Youqinglianjie youqinglianjie = youqinglianjieService.getById(id);
            request.setAttribute("youqinglianjie", youqinglianjie);
            request.getRequestDispatcher("youqinglianjie_updt.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("youqinglianjie_list.jsp");
        }
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String mingcheng = request.getParameter("mingcheng");
        String url = request.getParameter("url");
        String shijian = request.getParameter("shijian");

        Youqinglianjie obj = new Youqinglianjie();
        obj.setMingcheng(mingcheng);
        obj.setUrl(url);
        obj.setShijian(shijian);

        try {
            youqinglianjieService.add(obj);
            response.sendRedirect("youqinglianjie?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("youqinglianjie_list.jsp");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String mingcheng = request.getParameter("mingcheng");
        String url = request.getParameter("url");
        String shijian = request.getParameter("shijian");

        Youqinglianjie obj = new Youqinglianjie();
        obj.setId(id);
        obj.setMingcheng(mingcheng);
        obj.setUrl(url);
        obj.setShijian(shijian);

        try {
            youqinglianjieService.update(obj);
            response.sendRedirect("youqinglianjie?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("youqinglianjie_list.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            youqinglianjieService.delete(id);
            response.sendRedirect("youqinglianjie?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("youqinglianjie_list.jsp");
        }
    }
}