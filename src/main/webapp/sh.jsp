<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="connDbBean" scope="page" class="com.badminton.util.db"/>
<%@ page isELIgnored="false" %> 


<%
String yuan=request.getParameter("yuan");
String id=request.getParameter("id");
String tablename=request.getParameter("tablename");
String sql="";
if(yuan.equals("否"))
{
	sql="update "+request.getParameter("tablename")+" set issh='是' where id="+request.getParameter("id");
}
else
{
	sql="update "+request.getParameter("tablename")+" set issh='否' where id="+request.getParameter("id");
}


connDbBean.hsgexecute(sql);
out.print("<script>javascript:alert('操作成功！');location.href='"+request.getParameter("tablename")+"?action=list2';</script>");


%>
