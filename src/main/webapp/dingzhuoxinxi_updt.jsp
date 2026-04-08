<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="connDbBean" scope="page" class="com.badminton.util.db"/>

<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js" charset="gb2312"></script>
<script type="text/javascript" src="js/popup.js"></script>
<script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<TITLE>修改订场信息</TITLE>
	    

 	<style type="text/css">
<!--
body,td,th {
	font-size: 12px;
}
-->
</style>      
	</head>

<script language="javascript">

function gows()
{
	document.location.href="dingzhuoxinxi_updt.jsp?id=${dingzhuoxinxi.id}";
}
function hsgxia2shxurxu(nstr,nwbk)
{
	if (eval("form1."+nwbk).value.indexOf(nstr)>=0)
	{
		eval("form1."+nwbk).value=eval("form1."+nwbk).value.replace(nstr+"，", "");
	}
	else
	{
		eval("form1."+nwbk).value=eval("form1."+nwbk).value+nstr+"，";
	}
}
</script>
	<body>
			<form action="dingzhuoxinxi?action=update" name="form1" method="post">
				      <table width="100%" border="1" align="center" cellpadding="3" cellspacing="1"  style="border-collapse:collapse" bgcolor="#F2FDFF">
						<tr bgcolor="#E7E7E7">
							<td height="20" colspan="2" background="images/table_header.gif">修改订场信息<input type="hidden" name="id" value="${dingzhuoxinxi.id}" /></td>
						</tr>
						<tr ><td width="200">场地号：</td><td><input name='qiuzhuohao' type='text' id='qiuzhuohao' value='' onblur='' style='border:solid 1px #000000; color:#666666'  readonly='readonly' /></td></tr>
		<tr ><td width="200">每小时计费：</td><td><input name='meixiaoshijifei' type='text' id='meixiaoshijifei' value='' onblur='checkform()' style='border:solid 1px #000000; color:#666666' />&nbsp;*<label id='clabelmeixiaoshijifei' /></td></tr>
		<tr ><td width="200">总时长(小时)：</td><td><input name='zongshichang' type='text' id='zongshichang' value='1' onblur='jisuan()' style='border:solid 1px #000000; color:#666666' />&nbsp;*<label id='clabelzongshichang' /></td></tr>
		<tr ><td width="200">订场时间：</td><td><input name='dingzhuoshijian' type='text' id='dingzhuoshijian' value='' onblur='' style='border:solid 1px #000000; color:#666666'  readonly='readonly' /></td></tr>
		<tr ><td width="200">会员编号：</td><td><input name='huiyuanbianhao' type='text' id='huiyuanbianhao' onblur='' style='border:solid 1px #000000; color:#666666'  readonly='readonly' /></td></tr>
		<tr ><td width="200">姓名：</td><td><input name='xingming' type='text' id='xingming' value='' onblur='' style='border:solid 1px #000000; color:#666666'  readonly='readonly' /></td></tr>
		<tr ><td width="200">会员等级：</td><td><input name='huiyuandengji' type='text' id='huiyuandengji' value='' onblur='' style='border:solid 1px #000000; color:#666666'  readonly='readonly' /></td></tr>
		<tr ><td width="200">折扣：</td><td><input name='zhekou' type='text' id='zhekou' value='' onblur='' style='border:solid 1px #000000; color:#666666'  readonly='readonly' /></td></tr>
		<tr ><td width="200">备注：</td><td><textarea name='beizhu' cols='50' rows='5' id='beizhu' onblur='' style='border:solid 1px #000000; color:#666666' ></textarea></td></tr>
		
		
						<tr align='center'   height="22">
						    <td width="25%"  align="right">&nbsp;
						        
						    </td>
						    <td width="75%"  align="left">
						       <input type="submit" name="querenzhuce" id="querenzhuce" value="提交" onClick="return checkform();"/>
						       <input type="reset" value="重置"/>&nbsp;
						    </td>
						</tr>
					 </table>
			</form>
			<script language="javascript">document.form1.qiuzhuohao.value='${dingzhuoxinxi.qiuzhuohao}';</script>
	<script language="javascript">document.form1.meixiaoshijifei.value='${dingzhuoxinxi.meixiaoshijifei}';</script>
	<script language="javascript">document.form1.dingzhuoshijian.value='${dingzhuoxinxi.dingzhuoshijian}';</script>
	<script language="javascript">document.form1.huiyuanbianhao.value='${dingzhuoxinxi.huiyuanbianhao}';</script>
	<script language="javascript">document.form1.xingming.value='${dingzhuoxinxi.xingming}';</script>
	<script language="javascript">document.form1.huiyuandengji.value='${dingzhuoxinxi.huiyuandengji}';</script>
	<script language="javascript">document.form1.zhekou.value='${dingzhuoxinxi.zhekou}';</script>
	<script language="javascript">document.form1.beizhu.value='${dingzhuoxinxi.beizhu}';</script>
   </body>
</html>






<script language=javascript >  
 
 function checkform(){  
 
	var meixiaoshijifeiobj = document.getElementById("meixiaoshijifei"); if(meixiaoshijifeiobj.value==""){document.getElementById("clabelmeixiaoshijifei").innerHTML="&nbsp;&nbsp;<font color=red>请输入每小时计费</font>";return false;}else{document.getElementById("clabelmeixiaoshijifei").innerHTML="  "; } 
	var meixiaoshijifeiobj = document.getElementById("meixiaoshijifei"); if(meixiaoshijifeiobj.value!=""){ if(/^[0-9]+.?[0-9]*$/.test(meixiaoshijifeiobj.value)){document.getElementById("clabelmeixiaoshijifei").innerHTML=""; }else{document.getElementById("clabelmeixiaoshijifei").innerHTML="&nbsp;&nbsp;<font color=red>请输入数字</font>"; return false;}}  
	var zongshichangobj = document.getElementById("zongshichang"); if(zongshichangobj.value==""){document.getElementById("clabelzongshichang").innerHTML="&nbsp;&nbsp;<font color=red>请输入总时长</font>";return false;}else{document.getElementById("clabelzongshichang").innerHTML="  "; } 
	var zongshichangobj = document.getElementById("zongshichang"); if(zongshichangobj.value!=""){ if(/^[0-9]+.?[0-9]*$/.test(zongshichangobj.value)){document.getElementById("clabelzongshichang").innerHTML=""; }else{document.getElementById("clabelzongshichang").innerHTML="&nbsp;&nbsp;<font color=red>请输入数字</font>"; return false;}}  
    


return true;   
}   

function jisuan(){
    var meixiaoshijifei = document.getElementById("meixiaoshijifei").value;
    var zongshichang = document.getElementById("zongshichang").value;
    var zhekou = document.getElementById("zhekou").value;
    if(meixiaoshijifei!="" && zongshichang!="" && zhekou!=""){
        var zongjine = parseFloat(meixiaoshijifei) * parseFloat(zongshichang) * parseFloat(zhekou);
        document.getElementById("zongjine").value = zongjine.toFixed(2);
    }
}
popheight=450;
</script>  
