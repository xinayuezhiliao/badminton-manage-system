package com.badminton.controller;

import com.badminton.entity.Court;
import com.badminton.service.CourtService;
import com.badminton.service.impl.CourtServiceImpl;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/court/list")
public class CourtListController extends HttpServlet {
    private final CourtService service = new CourtServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Court> list = service.list();
        request.setAttribute("list", list);
        try {
            request.getRequestDispatcher("/court_list.jsp").forward(request, response);
        } catch (Exception e) { e.printStackTrace(); }
    }
}