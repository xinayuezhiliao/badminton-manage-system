<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ page import="java.util.*"%>
<%
String path = request.getContextPath();
%>
<%
    String newFile1Name=null;
    
    // 使用Jakarta Servlet 6.0 文件上传
    jakarta.servlet.http.Part filePart = request.getPart("fujian");
    if (filePart == null || filePart.getSize() == 0) {
        out.println("<script language=javascript>alert('必须选择文件');history.back(-1);</script>");
        return;
    }
    
    String file_name = filePart.getSubmittedFileName();
    String ext = file_name.substring(file_name.lastIndexOf("."));
    newFile1Name = new Date().getTime() + ext;
    
    String saveDir = request.getServletContext().getRealPath("/upload");
    java.io.File dir = new java.io.File(saveDir);
    if (!dir.exists()) dir.mkdirs();
    
    String savePath = saveDir + java.io.File.separator + newFile1Name;
    filePart.write(savePath);
%>

<script language="javascript">

    var str=location.toString()
    var Result=((((str.split('?'))[1]).split('='))[1]);
	//window.opener.Form1(Result).focus();	
	window.parent.document.getElementById(Result).value="upload/<%= newFile1Name%>";					

    
	//window.opener=null;
	document.write("上传成功");
    //window.close();

</script>
