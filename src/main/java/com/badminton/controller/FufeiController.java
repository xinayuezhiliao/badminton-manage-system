package com.badminton.controller;

import com.badminton.entity.Fufei;
import com.badminton.service.FufeiService;
import com.badminton.service.impl.FufeiServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/fufei")
public class FufeiController extends HttpServlet {
    private FufeiService fufeiService = new FufeiServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        if ("list".equals(action)) {
            list(request, response);
        } else if ("searchPage".equals(action)) {
            searchPage(request, response);
        } else if ("list2".equals(action)) {
            list2(request, response);
        } else if ("delete".equals(action)) {
            delete(request, response);
        } else if ("toUpdate".equals(action)) {
            toUpdate(request, response);
        }
        else if ("detail".equals(action)) {
            detail(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            add(request, response);
        } else if ("update".equals(action)) {
            update(request, response);
        } else if ("doSearch".equals(action)) {
            doSearch(request, response);
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 显示所有付费信息
            List<Fufei> list = fufeiService.list();
            
            System.out.println("===== 付费信息列表 =====");
            System.out.println("数据库总记录数：" + (list != null ? list.size() : 0));
            
            request.setAttribute("fufeiList", list);
            request.getRequestDispatcher("fufei_list.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    
    // 显示精准查询页面
    private void searchPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("fufei_search.jsp").forward(request, response);
    }
    
    // 执行精准查询
    private void doSearch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String qiuzhuohao = request.getParameter("qiuzhuohao");
            String huiyuanbianhao = request.getParameter("huiyuanbianhao");
            String issh = request.getParameter("issh");
            
            System.out.println("===== 付费信息精准查询开始 =====");
            System.out.println("搜索场地号：" + qiuzhuohao);
            System.out.println("搜索会员编号：" + huiyuanbianhao);
            System.out.println("搜索支付状态：" + issh);
            
            List<Fufei> allList = fufeiService.list();
            List<Fufei> filteredList = new java.util.ArrayList<>();
            
            for (Fufei fee : allList) {
                boolean match = true;
                
                if (qiuzhuohao != null && !qiuzhuohao.trim().isEmpty()) {
                    String dbQiuzhuohao = fee.getQiuzhuohao();
                    if (dbQiuzhuohao == null || !dbQiuzhuohao.contains(qiuzhuohao.trim())) {
                        match = false;
                    }
                }
                
                if (huiyuanbianhao != null && !huiyuanbianhao.trim().isEmpty()) {
                    String dbHuiyuanbianhao = fee.getHuiyuanbianhao();
                    if (dbHuiyuanbianhao == null || !dbHuiyuanbianhao.contains(huiyuanbianhao.trim())) {
                        match = false;
                    }
                }
                
                if (issh != null && !issh.trim().isEmpty()) {
                    String dbIssh = fee.getIssh();
                    if (dbIssh == null || !dbIssh.equals(issh.trim())) {
                        match = false;
                    }
                }
                
                if (match) {
                    filteredList.add(fee);
                }
            }
            
            System.out.println("过滤后记录数：" + filteredList.size());
            
            request.setAttribute("fufeiList", filteredList);
            request.setAttribute("searchKeyQiu", qiuzhuohao);
            request.setAttribute("searchKeyHui", huiyuanbianhao);
            request.setAttribute("searchKeyIssh", issh);
            request.getRequestDispatcher("fufei_search.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // 会员专用付费列表
    private void list2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String huiyuanbianhao = (String) request.getSession().getAttribute("username");
            List<Fufei> list = fufeiService.listByHuiyuanbianhao(huiyuanbianhao);
            request.setAttribute("list", list);
            request.getRequestDispatcher("fufei_list2.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Fufei fufei = fufeiService.getById(id);
            request.setAttribute("fufei", fufei);
            request.getRequestDispatcher("fufei_updt.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("fufei_list.jsp");
        }
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String qiuzhuohao = request.getParameter("qiuzhuohao");
        String meixiaoshijifei = request.getParameter("meixiaoshijifei");
        String zongshichang = request.getParameter("zongshichang");
        String huiyuanbianhao = request.getParameter("huiyuanbianhao");
        String xingming = request.getParameter("xingming");
        String huiyuandengji = request.getParameter("huiyuandengji");
        String zhekou = request.getParameter("zhekou");
        String zongjine = request.getParameter("zongjine");
        String beizhu = request.getParameter("beizhu");

        Fufei fufei = new Fufei();
        fufei.setQiuzhuohao(qiuzhuohao);
        fufei.setMeixiaoshijifei(meixiaoshijifei);
        fufei.setZongshichang(zongshichang);
        fufei.setHuiyuanbianhao(huiyuanbianhao);
        fufei.setXingming(xingming);
        fufei.setHuiyuandengji(huiyuandengji);
        fufei.setZhekou(zhekou);
        fufei.setZongjine(zongjine);
        fufei.setBeizhu(beizhu);

        try {
            fufeiService.add(fufei);
            response.sendRedirect("fufei?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("fufei_list.jsp");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String qiuzhuohao = request.getParameter("qiuzhuohao");
        String meixiaoshijifei = request.getParameter("meixiaoshijifei");
        String zongshichang = request.getParameter("zongshichang");
        String huiyuanbianhao = request.getParameter("huiyuanbianhao");
        String xingming = request.getParameter("xingming");
        String huiyuandengji = request.getParameter("huiyuandengji");
        String zhekou = request.getParameter("zhekou");
        String zongjine = request.getParameter("zongjine");
        String beizhu = request.getParameter("beizhu");
        String issh = request.getParameter("issh");

        Fufei fufei = new Fufei();
        fufei.setId(id);
        fufei.setQiuzhuohao(qiuzhuohao);
        fufei.setMeixiaoshijifei(meixiaoshijifei);
        fufei.setZongshichang(zongshichang);
        fufei.setHuiyuanbianhao(huiyuanbianhao);
        fufei.setXingming(xingming);
        fufei.setHuiyuandengji(huiyuandengji);
        fufei.setZhekou(zhekou);
        fufei.setZongjine(zongjine);
        fufei.setBeizhu(beizhu);
        fufei.setIssh(issh);

        try {
            fufeiService.update(fufei);
            response.sendRedirect("fufei?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("fufei_list.jsp");
        }
    }

    // 付费详情
    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Fufei fufei = fufeiService.getById(id);
            request.setAttribute("fufei", fufei);
            request.getRequestDispatcher("fufei_detail.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("fufei_list2.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            fufeiService.delete(id);
            response.sendRedirect("fufei?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("fufei_list.jsp");
        }
    }
}
