package com.badminton.controller;

import com.badminton.entity.Huiyuan;
import com.badminton.service.HuiyuanService;
import com.badminton.service.impl.HuiyuanServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/huiyuan/list")
public class HuiyuanListController extends HttpServlet {
    private final HuiyuanService service = new HuiyuanServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Huiyuan> list = service.list();
        request.setAttribute("list", list);
        request.getRequestDispatcher("/huiyuanxinxi_listxls.jsp").forward(request, response);
    }
}