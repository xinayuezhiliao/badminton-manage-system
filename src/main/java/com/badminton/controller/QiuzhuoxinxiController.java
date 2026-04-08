package com.badminton.controller;

import com.badminton.entity.Dingzhuoxinxi;
import com.badminton.entity.Fufei;
import com.badminton.entity.Qiuzhuoxinxi;
import com.badminton.service.DingzhuoxinxiService;
import com.badminton.service.FufeiService;
import com.badminton.service.QiuzhuoxinxiService;
import com.badminton.service.impl.DingzhuoxinxiServiceImpl;
import com.badminton.service.impl.FufeiServiceImpl;
import com.badminton.service.impl.QiuzhuoxinxiServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/qiuzhuoxinxi")
public class QiuzhuoxinxiController extends HttpServlet {
    private QiuzhuoxinxiService qiuzhuoxinxiService = new QiuzhuoxinxiServiceImpl();
    private DingzhuoxinxiService dingzhuoxinxiService = new DingzhuoxinxiServiceImpl();
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
        } else if ("detail".equals(action)) {
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
        } else if ("dingyue".equals(action)) {
            dingyue(request, response);
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 显示所有场地
            List<Qiuzhuoxinxi> list = qiuzhuoxinxiService.list();
            
            System.out.println("===== 场地列表 =====");
            System.out.println("数据库总记录数：" + (list != null ? list.size() : 0));
            
            request.setAttribute("qiuzhuoxinxiList", list);
            request.getRequestDispatcher("qiuzhuoxinxi_list.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    
    // 显示精准查询页面
    private void searchPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("qiuzhuoxinxi_search.jsp").forward(request, response);
    }
    
    // 执行精准查询
    private void doSearch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String qiuzhuohao = request.getParameter("qiuzhuohao");
            
            System.out.println("===== 场地精准查询开始 =====");
            System.out.println("搜索场地号：" + qiuzhuohao);
            
            List<Qiuzhuoxinxi> allList = qiuzhuoxinxiService.list();
            List<Qiuzhuoxinxi> filteredList = new java.util.ArrayList<>();
            
            if (qiuzhuohao != null && !qiuzhuohao.trim().isEmpty()) {
                String searchKey = qiuzhuohao.trim();
                for (Qiuzhuoxinxi court : allList) {
                    String dbQiuzhuohao = court.getQiuzhuohao();
                    if (dbQiuzhuohao != null && dbQiuzhuohao.contains(searchKey)) {
                        filteredList.add(court);
                    }
                }
            }
            
            System.out.println("过滤后记录数：" + filteredList.size());
            
            request.setAttribute("qiuzhuoxinxiList", filteredList);
            request.setAttribute("searchKey", qiuzhuohao);
            request.getRequestDispatcher("qiuzhuoxinxi_search.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // 会员专用场地列表
    private void list2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Qiuzhuoxinxi> list = qiuzhuoxinxiService.list();
            request.setAttribute("list", list);
            request.getRequestDispatcher("qiuzhuoxinxi_list2.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Qiuzhuoxinxi qiuzhuoxinxi = qiuzhuoxinxiService.getById(id);
            request.setAttribute("qiuzhuoxinxi", qiuzhuoxinxi);
            request.getRequestDispatcher("qiuzhuoxinxi_updt.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("qiuzhuoxinxi_list.jsp");
        }
    }

    // 详情页面
    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Qiuzhuoxinxi qiuzhuoxinxi = qiuzhuoxinxiService.getById(id);
            request.setAttribute("qiuzhuoxinxi", qiuzhuoxinxi);
            request.getRequestDispatcher("qiuzhuoxinxi_detail.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("qiuzhuoxinxi_list2.jsp");
        }
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 设置请求编码，防止中文乱码
        request.setCharacterEncoding("UTF-8");
        
        String qiuzhuohao = request.getParameter("qiuzhuohao");
        String zhuangtai = request.getParameter("zhuangtai");
        String meixiaoshijifei = request.getParameter("meixiaoshijifei");
        String beizhu = request.getParameter("beizhu");

        Qiuzhuoxinxi obj = new Qiuzhuoxinxi();
        obj.setQiuzhuohao(qiuzhuohao);
        obj.setZhuangtai(zhuangtai);
        obj.setMeixiaoshijifei(meixiaoshijifei);
        obj.setBeizhu(beizhu);

        try {
            qiuzhuoxinxiService.add(obj);
            response.sendRedirect("qiuzhuoxinxi?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("qiuzhuoxinxi_list.jsp");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 设置请求编码，防止中文乱码
        request.setCharacterEncoding("UTF-8");
        
        int id = Integer.parseInt(request.getParameter("id"));
        String qiuzhuohao = request.getParameter("qiuzhuohao");
        String zhuangtai = request.getParameter("zhuangtai");
        String meixiaoshijifei = request.getParameter("meixiaoshijifei");
        String beizhu = request.getParameter("beizhu");

        Qiuzhuoxinxi obj = new Qiuzhuoxinxi();
        obj.setId(id);
        obj.setQiuzhuohao(qiuzhuohao);
        obj.setZhuangtai(zhuangtai);
        obj.setMeixiaoshijifei(meixiaoshijifei);
        obj.setBeizhu(beizhu);

        try {
            qiuzhuoxinxiService.update(obj);
            response.sendRedirect("qiuzhuoxinxi?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("qiuzhuoxinxi_list.jsp");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            qiuzhuoxinxiService.delete(id);
            response.sendRedirect("qiuzhuoxinxi?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("qiuzhuoxinxi_list.jsp");
        }
    }

    // 管理员预定场地
    private void dingyue(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String qiuzhuoid = request.getParameter("qiuzhuoid");
        String qiuzhuohao = request.getParameter("qiuzhuohao");
        String meixiaoshijifei = request.getParameter("meixiaoshijifei");
        String zongshichang = request.getParameter("zongshichang");
        String huiyuanbianhao = request.getParameter("huiyuanbianhao");
        String xingming = request.getParameter("xingming");
        String huiyuandengji = request.getParameter("huiyuandengji");
        String zhekou = request.getParameter("zhekou");
        String zongjine = request.getParameter("zongjine");
        String issh = request.getParameter("issh");
        String beizhu = request.getParameter("beizhu");

        // 处理默认值：会员编号和姓名为空时设为"游客"
        if (huiyuanbianhao == null || huiyuanbianhao.trim().isEmpty()) {
            huiyuanbianhao = "游客";
        }
        if (xingming == null || xingming.trim().isEmpty()) {
            xingming = "游客";
        }

        // 自动生成订场时间
        String dingzhuoshijian = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        try {
            // 1. 更新场地状态为"已订"
            if (qiuzhuoid != null && !qiuzhuoid.isEmpty()) {
                Qiuzhuoxinxi qiuzhuo = qiuzhuoxinxiService.getById(Integer.parseInt(qiuzhuoid));
                if (qiuzhuo != null) {
                    qiuzhuo.setZhuangtai("已订");
                    qiuzhuoxinxiService.update(qiuzhuo);
                }
            }

            // 2. 创建订场信息
            Dingzhuoxinxi dingzhuo = new Dingzhuoxinxi();
            dingzhuo.setQiuzhuohao(qiuzhuohao);
            dingzhuo.setMeixiaoshijifei(meixiaoshijifei);
            dingzhuo.setDingzhuoshijian(dingzhuoshijian);
            dingzhuo.setHuiyuanbianhao(huiyuanbianhao);
            dingzhuo.setXingming(xingming);
            dingzhuo.setHuiyuandengji(huiyuandengji);
            dingzhuo.setZhekou(zhekou);
            dingzhuo.setBeizhu(beizhu);
            dingzhuoxinxiService.add(dingzhuo);

            // 3. 创建付费信息
            Fufei fufei = new Fufei();
            fufei.setQiuzhuohao(qiuzhuohao);
            fufei.setMeixiaoshijifei(meixiaoshijifei);
            fufei.setZongshichang(zongshichang != null && !zongshichang.isEmpty() ? zongshichang : "1");
            fufei.setHuiyuanbianhao(huiyuanbianhao);
            fufei.setXingming(xingming);
            fufei.setHuiyuandengji(huiyuandengji);
            fufei.setZhekou(zhekou);
            fufei.setZongjine(zongjine);
            fufei.setBeizhu(beizhu);
            fufei.setIssh(issh != null ? issh : "否");
            fufeiService.add(fufei);

            response.sendRedirect("qiuzhuoxinxi?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("qiuzhuoxinxi_list.jsp");
        }
    }
}
