package com.badminton.controller;

import com.badminton.entity.Xinwentongzhi;
import com.badminton.service.XinwentongzhiService;
import com.badminton.service.impl.XinwentongzhiServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/xinwentongzhi")
public class XinwentongzhiController extends HttpServlet {
    private XinwentongzhiService xinwentongzhiService = new XinwentongzhiServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        if ("list".equals(action)) {
            list(request, response);
        } else if ("detail".equals(action)) {
            detail(request, response);
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
            List<Xinwentongzhi> list = xinwentongzhiService.list();
            request.setAttribute("xinwentongzhiList", list);
            request.getRequestDispatcher("xinwentongzhi_list.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Xinwentongzhi xinwentongzhi = xinwentongzhiService.getById(id);
            request.setAttribute("xinwentongzhi", xinwentongzhi);
            request.getRequestDispatcher("xinwentongzhi_detail.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("xinwentongzhi?action=list");
        }
    }

    private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Xinwentongzhi xinwentongzhi = xinwentongzhiService.getById(id);
            request.setAttribute("xinwentongzhi", xinwentongzhi);
            request.getRequestDispatcher("xinwentongzhi_updt.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("xinwentongzhi_list.jsp");
        }
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String biaoti = request.getParameter("biaoti");
        String neirong = request.getParameter("neirong");
        String fabushijian = request.getParameter("fabushijian");

        Xinwentongzhi obj = new Xinwentongzhi();
        obj.setXinwenbiaoti(biaoti);
        obj.setXinwenneirong(neirong);
        obj.setFabushijian(fabushijian);

        try {
            xinwentongzhiService.add(obj);
            response.sendRedirect("xinwentongzhi?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("xinwentongzhi_list.jsp");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String biaoti = request.getParameter("biaoti");
        String neirong = request.getParameter("neirong");
        String fabushijian = request.getParameter("fabushijian");

        Xinwentongzhi obj = new Xinwentongzhi();
        obj.setId(id);
        obj.setXinwenbiaoti(biaoti);
        obj.setXinwenneirong(neirong);
        obj.setFabushijian(fabushijian);

        try {
            xinwentongzhiService.update(obj);
            response.sendRedirect("xinwentongzhi?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("xinwentongzhi_list.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            xinwentongzhiService.delete(id);
            response.sendRedirect("xinwentongzhi?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("xinwentongzhi_list.jsp");
        }
    }
}