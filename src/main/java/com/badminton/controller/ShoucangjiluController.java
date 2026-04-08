package com.badminton.controller;

import com.badminton.entity.Shoucangjilu;
import com.badminton.service.ShoucangjiluService;
import com.badminton.service.impl.ShoucangjiluServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/shoucangjilu")
public class ShoucangjiluController extends HttpServlet {
    private ShoucangjiluService shoucangjiluService = new ShoucangjiluServiceImpl();

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
            List<Shoucangjilu> list = shoucangjiluService.list();
            request.setAttribute("shoucangjiluList", list);
            request.getRequestDispatcher("shoucangjilu_list.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Shoucangjilu shoucangjilu = shoucangjiluService.getById(id);
            request.setAttribute("shoucangjilu", shoucangjilu);
            request.getRequestDispatcher("shoucangjilu_updt.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("shoucangjilu_list.jsp");
        }
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String qiuzhuohao = request.getParameter("qiuzhuohao");
        String mingcheng = request.getParameter("mingcheng");
        String yonghuzhanghao = request.getParameter("yonghuzhanghao");
        String shoucangshijian = request.getParameter("shoucangshijian");

        Shoucangjilu obj = new Shoucangjilu();
        obj.setQiuzhuohao(qiuzhuohao);
        obj.setMingcheng(mingcheng);
        obj.setYonghuzhanghao(yonghuzhanghao);
        obj.setShoucangshijian(shoucangshijian);

        try {
            shoucangjiluService.add(obj);
            response.sendRedirect("shoucangjilu?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("shoucangjilu_list.jsp");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String qiuzhuohao = request.getParameter("qiuzhuohao");
        String mingcheng = request.getParameter("mingcheng");
        String yonghuzhanghao = request.getParameter("yonghuzhanghao");
        String shoucangshijian = request.getParameter("shoucangshijian");

        Shoucangjilu obj = new Shoucangjilu();
        obj.setId(id);
        obj.setQiuzhuohao(qiuzhuohao);
        obj.setMingcheng(mingcheng);
        obj.setYonghuzhanghao(yonghuzhanghao);
        obj.setShoucangshijian(shoucangshijian);

        try {
            shoucangjiluService.update(obj);
            response.sendRedirect("shoucangjilu?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("shoucangjilu_list.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            shoucangjiluService.delete(id);
            response.sendRedirect("shoucangjilu?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("shoucangjilu_list.jsp");
        }
    }
}
