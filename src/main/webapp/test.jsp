<%@ page import="com.badminton.util.db" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.StringWriter" %>
<%
    db connDbBean = new db();
    out.println("db对象创建成功<br>");

    try {
        java.sql.ResultSet rs = connDbBean.executeQuery("SELECT 1");
        if (rs != null && rs.next()) {
            out.println("数据库连接成功！结果：" + rs.getInt(1));
        } else {
            out.println("数据库连接失败：ResultSet为null或无数据");
        }
    } catch (Exception e) {
        out.println("异常：" + e.getMessage() + "<br>");
        StringWriter sw = new StringWriter();
        e.printStackTrace(new PrintWriter(sw));
        out.println("<pre>" + sw.toString() + "</pre>");
    }
%>