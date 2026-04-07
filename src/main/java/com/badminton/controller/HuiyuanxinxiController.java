package com.badminton.controller;

import com.badminton.entity.Huiyuanxinxi;
import com.badminton.service.HuiyuanxinxiService;
import com.badminton.service.impl.HuiyuanxinxiServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/huiyuanxinxi")
public class HuiyuanxinxiController extends HttpServlet {
    private HuiyuanxinxiService huiyuanxinxiService = new HuiyuanxinxiServiceImpl();

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
        } else if ("toUpdate2".equals(action)) {
            toUpdate2(request, response);
        } else if ("check".equals(action)) {
            checkMemberExists(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            add(request, response);
        } else if ("update".equals(action)) {
            update(request, response);
        } else if ("update2".equals(action)) {
            update2(request, response);
        } else if ("doSearch".equals(action)) {
            doSearch(request, response);
        } else if ("check".equals(action)) {
            checkMemberExists(request, response);
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 显示所有会员
            List<Huiyuanxinxi> allList = huiyuanxinxiService.list();
            
            System.out.println("===== 会员列表 =====");
            System.out.println("数据库总记录数：" + (allList != null ? allList.size() : 0));
            
            request.setAttribute("huiyuanxinxiList", allList);
            request.getRequestDispatcher("huiyuanxinxi_list.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    
    // 显示精准查询页面
    private void searchPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("huiyuanxinxi_search.jsp").forward(request, response);
    }
    
    // 执行精准查询
    private void doSearch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String huiyuanbianhao = request.getParameter("huiyuanbianhao");
            
            System.out.println("===== 精准查询开始 =====");
            System.out.println("搜索会员编号：" + huiyuanbianhao);
            
            List<Huiyuanxinxi> allList = huiyuanxinxiService.list();
            List<Huiyuanxinxi> filteredList = new java.util.ArrayList<>();
            
            if (huiyuanbianhao != null && !huiyuanbianhao.trim().isEmpty()) {
                String searchKey = huiyuanbianhao.trim();
                for (Huiyuanxinxi member : allList) {
                    String dbHuiyuanbianhao = member.getHuiyuanbianhao();
                    if (dbHuiyuanbianhao != null && dbHuiyuanbianhao.contains(searchKey)) {
                        filteredList.add(member);
                    }
                }
            }
            
            System.out.println("过滤后记录数：" + filteredList.size());
            
            request.setAttribute("huiyuanxinxiList", filteredList);
            request.setAttribute("searchKey", huiyuanbianhao);
            request.getRequestDispatcher("huiyuanxinxi_search.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Huiyuanxinxi huiyuanxinxi = huiyuanxinxiService.getById(id);
            request.setAttribute("huiyuanxinxi", huiyuanxinxi);
            request.getRequestDispatcher("huiyuanxinxi_updt.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("huiyuanxinxi_list.jsp");
        }
    }

    // 会员专用个人资料修改
    private void toUpdate2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String huiyuanbianhao = (String) request.getSession().getAttribute("username");
            Huiyuanxinxi huiyuanxinxi = huiyuanxinxiService.getByHuiyuanbianhao(huiyuanbianhao);
            request.setAttribute("huiyuanxinxi", huiyuanxinxi);
            request.getRequestDispatcher("huiyuanxinxi_updt2.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 设置请求编码，防止中文乱码
        request.setCharacterEncoding("UTF-8");
        
        String huiyuanbianhao = request.getParameter("huiyuanbianhao");
        String mima = request.getParameter("mima");
        String xingming = request.getParameter("xingming");
        String xingbie = request.getParameter("xingbie");
        String huiyuandengji = request.getParameter("huiyuandengji");
        String zhekou = request.getParameter("zhekou");
        String shouji = request.getParameter("shouji");
        String beizhu = request.getParameter("beizhu");
        String yue = request.getParameter("yue");

        try {
            // 先检查会员编号是否已存在
            Huiyuanxinxi existingMember = huiyuanxinxiService.getByHuiyuanbianhao(huiyuanbianhao);
            if (existingMember != null) {
                // 会员编号已存在，重定向回添加页面并带错误提示
                request.getSession().setAttribute("addError", "会员编号已存在，请更换！");
                response.sendRedirect("huiyuanxinxi_add.jsp");
                return;
            }
            
            Huiyuanxinxi obj = new Huiyuanxinxi();
            obj.setHuiyuanbianhao(huiyuanbianhao);
            obj.setMima(mima);
            obj.setXingming(xingming);
            obj.setXingbie(xingbie);
            obj.setHuiyuandengji(huiyuandengji);
            obj.setZhekou(zhekou);
            obj.setShouji(shouji);
            obj.setBeizhu(beizhu);
            obj.setYue(yue);

            huiyuanxinxiService.add(obj);
            response.sendRedirect("huiyuanxinxi?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("huiyuanxinxi_list.jsp");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 设置请求编码，防止中文乱码
        request.setCharacterEncoding("UTF-8");
        
        int id = Integer.parseInt(request.getParameter("id"));
        String huiyuanbianhao = request.getParameter("huiyuanbianhao");
        String mima = request.getParameter("mima");
        String xingming = request.getParameter("xingming");
        String xingbie = request.getParameter("xingbie");
        String huiyuandengji = request.getParameter("huiyuandengji");
        String zhekou = request.getParameter("zhekou");
        String shouji = request.getParameter("shouji");
        String beizhu = request.getParameter("beizhu");
        String yue = request.getParameter("yue");

        Huiyuanxinxi obj = new Huiyuanxinxi();
        obj.setId(id);
        obj.setHuiyuanbianhao(huiyuanbianhao);
        obj.setMima(mima);
        obj.setXingming(xingming);
        obj.setXingbie(xingbie);
        obj.setHuiyuandengji(huiyuandengji);
        obj.setZhekou(zhekou);
        obj.setShouji(shouji);
        obj.setBeizhu(beizhu);
        obj.setYue(yue);

        try {
            huiyuanxinxiService.update(obj);
            response.sendRedirect("huiyuanxinxi?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("huiyuanxinxi_list.jsp");
        }
    }

    private void update2(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 设置请求编码，防止中文乱码
        request.setCharacterEncoding("UTF-8");
        
        try {
            String huiyuanbianhao = (String) request.getSession().getAttribute("username");
            Huiyuanxinxi huiyuanxinxi = huiyuanxinxiService.getByHuiyuanbianhao(huiyuanbianhao);
            
            int id = huiyuanxinxi.getId();
            String mima = request.getParameter("mima");
            String xingming = request.getParameter("xingming");
            String xingbie = request.getParameter("xingbie");
            String huiyuandengji = request.getParameter("huiyuandengji");
            String zhekou = request.getParameter("zhekou");
            String shouji = request.getParameter("shouji");
            String beizhu = request.getParameter("beizhu");

            huiyuanxinxi.setMima(mima);
            huiyuanxinxi.setXingming(xingming);
            huiyuanxinxi.setXingbie(xingbie);
            huiyuanxinxi.setHuiyuandengji(huiyuandengji);
            huiyuanxinxi.setZhekou(zhekou);
            huiyuanxinxi.setShouji(shouji);
            huiyuanxinxi.setBeizhu(beizhu);

            try {
                huiyuanxinxiService.update(huiyuanxinxi);
                response.sendRedirect("sy.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("huiyuanxinxi_updt2.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            huiyuanxinxiService.delete(id);
            response.sendRedirect("huiyuanxinxi?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("huiyuanxinxi_list.jsp");
        }
    }
    
    // 检查会员编号是否存在（AJAX 调用）
    private void checkMemberExists(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String huiyuanbianhao = request.getParameter("huiyuanbianhao");
        response.setContentType("application/json;charset=UTF-8");
        
        try {
            Huiyuanxinxi existingMember = huiyuanxinxiService.getByHuiyuanbianhao(huiyuanbianhao);
            if (existingMember != null) {
                // 会员编号已存在
                response.getWriter().write("{\"info\":\"ng\"}");
            } else {
                // 会员编号可用
                response.getWriter().write("{\"info\":\"ok\"}");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"info\":\"error\"}");
        }
    }
}

