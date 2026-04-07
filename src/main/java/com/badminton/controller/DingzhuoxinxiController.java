package com.badminton.controller;

import com.badminton.entity.Dingzhuoxinxi;
import com.badminton.entity.Fufei;
import com.badminton.entity.Qiuzhuoxinxi;
import com.badminton.service.DingzhuoxinxiService;
import com.badminton.service.FufeiService;
import com.badminton.service.QiuzhuoxinxiService;
import com.badminton.service.HuiyuanxinxiService;
import com.badminton.service.impl.DingzhuoxinxiServiceImpl;
import com.badminton.service.impl.FufeiServiceImpl;
import com.badminton.service.impl.QiuzhuoxinxiServiceImpl;
import com.badminton.service.impl.HuiyuanxinxiServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/dingzhuoxinxi")
public class DingzhuoxinxiController extends HttpServlet {
    private DingzhuoxinxiService dingzhuoxinxiService = new DingzhuoxinxiServiceImpl();
    private QiuzhuoxinxiService qiuzhuoxinxiService = new QiuzhuoxinxiServiceImpl();
    private FufeiService fufeiService = new FufeiServiceImpl();
    private HuiyuanxinxiService huiyuanxinxiService = new HuiyuanxinxiServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        if ("list".equals(action)) {
            list(request, response);
        } else if ("searchPage".equals(action)) {
            searchPage(request, response);
        } else if ("searchPage2".equals(action)) {
            searchPage2(request, response);
        } else if ("list2".equals(action)) {
            list2(request, response);
        } else if ("delete".equals(action)) {
            delete(request, response);
        } else if ("toUpdate".equals(action)) {
            toUpdate(request, response);
        } else if ("detail".equals(action)) {
            detail(request, response);
        } else if ("dingyueMember".equals(action)) {
            dingyueMember(request, response);
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
        } else if ("doSearch2".equals(action)) {
            doSearch2(request, response);
        } else if ("addMember".equals(action)) {
            addMember(request, response);
        }
    }

    // 列表
    private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 显示所有订场信息
            List<Dingzhuoxinxi> list = dingzhuoxinxiService.list(null, null, null, null, null, null);
            
            System.out.println("===== 订场信息列表 =====");
            System.out.println("数据库总记录数：" + (list != null ? list.size() : 0));
            
            request.setAttribute("dingzhuoxinxiList", list);
            request.getRequestDispatcher("dingzhuoxinxi_list.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    
    // 显示精准查询页面
    private void searchPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("dingzhuoxinxi_search.jsp").forward(request, response);
    }
    
    // 显示会员专用精准查询页面
    private void searchPage2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("dingzhuoxinxi_search2.jsp").forward(request, response);
    }
    
    // 执行精准查询
    private void doSearch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String qiuzhuohao = request.getParameter("qiuzhuohao");
            String huiyuanbianhao = request.getParameter("huiyuanbianhao");
            
            System.out.println("===== 订场信息精准查询开始 =====");
            System.out.println("搜索场地号：" + qiuzhuohao);
            System.out.println("搜索会员编号：" + huiyuanbianhao);
            
            List<Dingzhuoxinxi> allList = dingzhuoxinxiService.list(null, null, null, null, null, null);
            List<Dingzhuoxinxi> filteredList = new java.util.ArrayList<>();
            
            if ((qiuzhuohao != null && !qiuzhuohao.trim().isEmpty()) || 
                (huiyuanbianhao != null && !huiyuanbianhao.trim().isEmpty())) {
                
                for (Dingzhuoxinxi record : allList) {
                    boolean match = true;
                    
                    if (qiuzhuohao != null && !qiuzhuohao.trim().isEmpty()) {
                        String dbQiuzhuohao = record.getQiuzhuohao();
                        if (dbQiuzhuohao == null || !dbQiuzhuohao.contains(qiuzhuohao.trim())) {
                            match = false;
                        }
                    }
                    
                    if (huiyuanbianhao != null && !huiyuanbianhao.trim().isEmpty()) {
                        String dbHuiyuanbianhao = record.getHuiyuanbianhao();
                        if (dbHuiyuanbianhao == null || !dbHuiyuanbianhao.contains(huiyuanbianhao.trim())) {
                            match = false;
                        }
                    }
                    
                    if (match) {
                        filteredList.add(record);
                    }
                }
            } else {
                filteredList = allList;
            }
            
            System.out.println("过滤后记录数：" + filteredList.size());
            
            request.setAttribute("dingzhuoxinxiList", filteredList);
            request.setAttribute("searchKeyQiu", qiuzhuohao);
            request.setAttribute("searchKeyHui", huiyuanbianhao);
            request.getRequestDispatcher("dingzhuoxinxi_search.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // 会员专用订场列表
    private void list2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String huiyuanbianhao = (String) request.getSession().getAttribute("username");
            List<Dingzhuoxinxi> list = dingzhuoxinxiService.list(null, null, huiyuanbianhao, null, null, null);
            request.setAttribute("list", list);
            request.getRequestDispatcher("dingzhuoxinxi_list2.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // 去修改页面
    private void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Dingzhuoxinxi dingzhuoxinxi = dingzhuoxinxiService.getById(id);
            request.setAttribute("dingzhuoxinxi", dingzhuoxinxi);
            request.getRequestDispatcher("dingzhuoxinxi_updt.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("dingzhuoxinxi_list.jsp");
        }
    }

    // 详情页面
    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Dingzhuoxinxi dingzhuoxinxi = dingzhuoxinxiService.getById(id);
            request.setAttribute("dingzhuoxinxi", dingzhuoxinxi);
            request.getRequestDispatcher("dingzhuoxinxi_detail.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("dingzhuoxinxi_list2.jsp");
        }
    }

    // 添加
    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String qiuzhuohao = request.getParameter("qiuzhuohao");
        String meixiaoshijifei = request.getParameter("meixiaoshijifei");
        String huiyuanbianhao = request.getParameter("huiyuanbianhao");
        String xingming = request.getParameter("xingming");
        String huiyuandengji = request.getParameter("huiyuandengji");
        String zhekou = request.getParameter("zhekou");
        String beizhu = request.getParameter("beizhu");

        // 自动生成订场时间
        String dingzhuoshijian = java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        Dingzhuoxinxi obj = new Dingzhuoxinxi();
        obj.setQiuzhuohao(qiuzhuohao);
        obj.setMeixiaoshijifei(meixiaoshijifei);
        obj.setDingzhuoshijian(dingzhuoshijian);
        obj.setHuiyuanbianhao(huiyuanbianhao);
        obj.setXingming(xingming);
        obj.setHuiyuandengji(huiyuandengji);
        obj.setZhekou(zhekou);
        obj.setBeizhu(beizhu);

        try {
            dingzhuoxinxiService.add(obj);
            
            // 更新场地状态为"已订"
            String qiuzhuoidStr = request.getParameter("qiuzhuoid");
            if (qiuzhuoidStr != null && !qiuzhuoidStr.isEmpty()) {
                Qiuzhuoxinxi qiuzhuo = qiuzhuoxinxiService.getById(Integer.parseInt(qiuzhuoidStr));
                if (qiuzhuo != null) {
                    qiuzhuo.setZhuangtai("已订");
                    qiuzhuoxinxiService.update(qiuzhuo);
                }
            }
            
            // 创建付费信息记录
            Fufei fufei = new Fufei();
            fufei.setQiuzhuohao(qiuzhuohao);
            fufei.setMeixiaoshijifei(meixiaoshijifei);
            fufei.setZongshichang("1"); // 默认1小时，管理员可在付费管理中修改
            fufei.setHuiyuanbianhao(huiyuanbianhao);
            fufei.setXingming(xingming);
            fufei.setHuiyuandengji(huiyuandengji);
            fufei.setZhekou(zhekou);
            // 计算总金额 = 每小时计费 * 总时长 * 折扣
            double meixiaoshijifeiVal = Double.parseDouble(meixiaoshijifei);
            double zhekouVal = Double.parseDouble(zhekou != null && !zhekou.isEmpty() ? zhekou : "1");
            double zongjine = meixiaoshijifeiVal * 1 * zhekouVal;
            fufei.setZongjine(String.format("%.2f", zongjine));
            fufei.setBeizhu(beizhu);
            fufei.setIssh("否"); // 默认未支付
            fufeiService.add(fufei);
            
            response.sendRedirect("dingzhuoxinxi?action=list2");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("dingzhuoxinxi_list.jsp");
        }
    }

    // 修改
    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String qiuzhuohao = request.getParameter("qiuzhuohao");
        String meixiaoshijifei = request.getParameter("meixiaoshijifei");
        String zongshichang = request.getParameter("zongshichang");
        String dingzhuoshijian = request.getParameter("dingzhuoshijifei");
        String huiyuanbianhao = request.getParameter("huiyuanbianhao");
        String xingming = request.getParameter("xingming");
        String huiyuandengji = request.getParameter("huiyuandengji");
        String zhekou = request.getParameter("zhekou");
        String beizhu = request.getParameter("beizhu");

        Dingzhuoxinxi obj = new Dingzhuoxinxi();
        obj.setId(id);
        obj.setQiuzhuohao(qiuzhuohao);
        obj.setMeixiaoshijifei(meixiaoshijifei);
        obj.setDingzhuoshijian(dingzhuoshijian);
        obj.setHuiyuanbianhao(huiyuanbianhao);
        obj.setXingming(xingming);
        obj.setHuiyuandengji(huiyuandengji);
        obj.setZhekou(zhekou);
        obj.setBeizhu(beizhu);

        try {
            dingzhuoxinxiService.update(obj);
            
            // 同步更新付费信息
            List<Fufei> fufeiList = fufeiService.list();
            for (Fufei fufei : fufeiList) {
                // 根据场地号和会员编号找到对应的付费记录
                if (fufei.getQiuzhuohao().equals(qiuzhuohao) && fufei.getHuiyuanbianhao().equals(huiyuanbianhao)) {
                    fufei.setMeixiaoshijifei(meixiaoshijifei);
                    if (zongshichang != null && !zongshichang.isEmpty()) {
                        fufei.setZongshichang(zongshichang);
                    }
                    fufei.setXingming(xingming);
                    fufei.setHuiyuandengji(huiyuandengji);
                    fufei.setZhekou(zhekou);
                    // 重新计算总金额
                    double meixiaoshijifeiVal = Double.parseDouble(meixiaoshijifei);
                    double zongshichangVal = Double.parseDouble(zongshichang != null && !zongshichang.isEmpty() ? zongshichang : fufei.getZongshichang());
                    double zhekouVal = Double.parseDouble(zhekou != null && !zhekou.isEmpty() ? zhekou : "1");
                    double zongjine = meixiaoshijifeiVal * zongshichangVal * zhekouVal;
                    fufei.setZongjine(String.format("%.2f", zongjine));
                    fufei.setBeizhu(beizhu);
                    fufeiService.update(fufei);
                    break;
                }
            }
            
            response.sendRedirect("dingzhuoxinxi?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("dingzhuoxinxi_list.jsp");
        }
    }

    // 删除
    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            dingzhuoxinxiService.delete(id);
            response.sendRedirect("dingzhuoxinxi?action=list");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("dingzhuoxinxi_list.jsp");
        }
    }
    
    // 会员专用：执行精准查询
    private void doSearch2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String qiuzhuohao = request.getParameter("qiuzhuohao");
            String huiyuanbianhao = (String) request.getSession().getAttribute("username");
            
            System.out.println("===== 会员订场精准查询开始 =====");
            System.out.println("搜索场地号：" + qiuzhuohao);
            System.out.println("当前会员编号：" + huiyuanbianhao);
            
            List<Dingzhuoxinxi> allList = dingzhuoxinxiService.list(null, null, huiyuanbianhao, null, null, null);
            List<Dingzhuoxinxi> filteredList = new java.util.ArrayList<>();
            
            if (qiuzhuohao != null && !qiuzhuohao.trim().isEmpty()) {
                String searchKey = qiuzhuohao.trim();
                for (Dingzhuoxinxi record : allList) {
                    String dbQiuzhuohao = record.getQiuzhuohao();
                    if (dbQiuzhuohao != null && dbQiuzhuohao.contains(searchKey)) {
                        filteredList.add(record);
                    }
                }
            } else {
                filteredList = allList;
            }
            
            System.out.println("过滤后记录数：" + filteredList.size());
            
            request.setAttribute("list", filteredList);
            request.setAttribute("searchKeyQiu", qiuzhuohao);
            request.getRequestDispatcher("dingzhuoxinxi_search2.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    
    // 显示会员预定页面
    private void dingyueMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("qiuzhuoxinxi_dingyue_member.jsp").forward(request, response);
    }
    
    // 会员专用：添加订场信息
    private void addMember(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // 设置请求编码，防止中文乱码
        request.setCharacterEncoding("UTF-8");
        
        String qiuzhuohao = request.getParameter("qiuzhuohao");
        String meixiaoshijifei = request.getParameter("meixiaoshijifei");
        String zongshichang = request.getParameter("zongshichang");
        String huiyuanbianhao = request.getParameter("huiyuanbianhao");
        String xingming = request.getParameter("xingming");
        String huiyuandengji = request.getParameter("huiyuandengji");
        String zhekou = request.getParameter("zhekou");
        String beizhu = request.getParameter("beizhu");
        
        try {
            // 获取会员信息，检查余额
            com.badminton.entity.Huiyuanxinxi member = huiyuanxinxiService.getByHuiyuanbianhao(huiyuanbianhao);
            if (member == null) {
                request.setAttribute("error", "会员信息不存在");
                request.getRequestDispatcher("qiuzhuoxinxi_dingyue_member.jsp").forward(request, response);
                return;
            }
            
            // 计算扣款金额 = 每小时计费 * 总时长 * 折扣
            double meixiaoshijifeiVal = Double.parseDouble(meixiaoshijifei);
            double zongshichangVal = Double.parseDouble(zongshichang != null && !zongshichang.isEmpty() ? zongshichang : "1");
            double zhekouVal = Double.parseDouble(zhekou != null && !zhekou.isEmpty() ? zhekou : "1");
            double deductAmount = meixiaoshijifeiVal * zongshichangVal * zhekouVal;
            
            double currentBalance = Double.parseDouble(member.getYue() != null ? member.getYue() : "0");
            if (currentBalance < deductAmount) {
                request.setAttribute("error", "余额不足请充值");
                request.getRequestDispatcher("qiuzhuoxinxi_dingyue_member.jsp").forward(request, response);
                return;
            }
            
            // 扣款
            double newBalance = currentBalance - deductAmount;
            member.setYue(String.format("%.2f", newBalance));
            huiyuanxinxiService.update(member);
            
            // 自动生成订场时间
            String dingzhuoshijian = java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

            Dingzhuoxinxi obj = new Dingzhuoxinxi();
            obj.setQiuzhuohao(qiuzhuohao);
            obj.setMeixiaoshijifei(meixiaoshijifei);
            obj.setZongshichang(zongshichang);
            obj.setDingzhuoshijian(dingzhuoshijian);
            obj.setHuiyuanbianhao(huiyuanbianhao);
            obj.setXingming(xingming);
            obj.setHuiyuandengji(huiyuandengji);
            obj.setZhekou(zhekou);
            obj.setBeizhu(beizhu);

            dingzhuoxinxiService.add(obj);
            
            // 更新场地状态为“已订”
            String qiuzhuoidStr = request.getParameter("qiuzhuoid");
            if (qiuzhuoidStr != null && !qiuzhuoidStr.isEmpty()) {
                Qiuzhuoxinxi qiuzhuo = qiuzhuoxinxiService.getById(Integer.parseInt(qiuzhuoidStr));
                if (qiuzhuo != null) {
                    qiuzhuo.setZhuangtai("已订");
                    qiuzhuoxinxiService.update(qiuzhuo);
                }
            }
            
            // 创建付费信息记录（会员不能修改支付状态，默认为"是"因为已扣款）
            Fufei fufei = new Fufei();
            fufei.setQiuzhuohao(qiuzhuohao);
            fufei.setMeixiaoshijifei(meixiaoshijifei);
            fufei.setZongshichang(zongshichang != null ? zongshichang : "1");
            fufei.setHuiyuanbianhao(huiyuanbianhao);
            fufei.setXingming(xingming);
            fufei.setHuiyuandengji(huiyuandengji);
            fufei.setZhekou(zhekou);
            fufei.setZongjine(String.format("%.2f", deductAmount));
            fufei.setBeizhu(beizhu);
            fufei.setIssh("是"); // 已从余额扣款，设为已支付
            fufeiService.add(fufei);
            
            response.sendRedirect("dingzhuoxinxi?action=list2");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
