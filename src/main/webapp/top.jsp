<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
if((String)request.getSession().getAttribute("username")==null || (String)request.getSession().getAttribute("username")=="")
{
	out.print("<script>javascript:alert('对不起，您已超时或未登陆,请在IE中重新打开登陆！);window.parent.location.href='login.jsp';</script>");
	out.close();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>无标题文档</title>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>

<body bgcolor="339999" style="margin: 0; padding: 0;">
<table width="100%" height="60" border="0" cellspacing="0" cellpadding="0" style="background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%); box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
  <tr>
    <td valign="middle" style="padding-left: 20px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="right" valign="middle"><table width="100%" height="60" border="0" style="vertical-align: middle;">
                
          <tr>
            <td align="right" valign="middle"><font color="#FFFFFF" style="font-size: 14px; font-weight: 500;">当前用户：<strong><%=request.getSession().getAttribute("username")%></strong>&nbsp;&nbsp;权限：<strong><%=request.getSession().getAttribute("cx")%></strong>&nbsp;&nbsp;&nbsp;&nbsp;</font><a href="logout.jsp" target="_parent" style="background: rgba(255,255,255,0.2); color: #FFFFFF; padding: 8px 16px; border-radius: 6px; text-decoration: none; font-size: 14px; transition: all 0.3s; display: inline-block;" onmouseover="this.style.background='rgba(255,255,255,0.3)'" onmouseout="this.style.background='rgba(255,255,255,0.2)'"><font color="#FFFFFF">退出</font></a></td>
          </tr>
        </table></td>
      </tr>
    </table> </td>
  </tr>
</table>

</body>
</html>
