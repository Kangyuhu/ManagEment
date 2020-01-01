<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>编辑项目信息</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/date/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/date/WdatePicker.js"></script>
	<script type="text/javascript">
		var dateSkin = "blue";
		$(document).ready(function () {
			$("#ks").focus(function () {
				WdatePicker({skin: dateSkin, readOnly: true, dateFmt: 'yyyy-MM-dd'})
			});
			$("#br1").focus(function () {
				WdatePicker({skin: dateSkin, readOnly: true, dateFmt: 'yyyy-MM-dd'})
			});
			$("#br2").focus(function () {
				WdatePicker({skin: dateSkin, readOnly: true, dateFmt: 'yyyy-MM-dd'})
			});
		});
	</script>


</head>
<body leftmargin="8" topmargin="8" background='skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
<tr>
 <td height="26" background="skin/images/newlinebg3.gif">
  <table width="58%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td >
    当前位置:项目管理>>编辑项目基本信息
 </td>
 </tr>
</table>
</td>
</tr>
</table>

<form name="form2" id="forms" action="${pageContext.request.contextPath}/pro/saveInfo" method="post">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">

	<input name="pid" value="${pro.pid}" type="hidden"/>
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="12" background="skin/images/tbg.gif">&nbsp;编辑项目信息&nbsp;</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">项目名称：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="pname" value="${pro.pname}"/></td>
	<td align="right" bgcolor="#FAFAF1" height="22">客户公司名称：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
	<select id="com" name="newcomname" onchange="addcus(this.value)">
		<option>选择公司</option>
		<c:forEach items="${clist}" var="c">
			<option value="${c.id},${c.companyperson}"  <c:if test="${c.id == pro.comname}" >selected</c:if>>${c.comname}</option>
		</c:forEach>
	</select>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">客户方负责人：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="comper" value="${pro.comper}" readonly/></td>
	<td align="right" bgcolor="#FAFAF1" height="22">项目经理：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<select name="empFk" >
			<c:forEach items="${elist}" var="e">
				<option value="${e.eid}" <c:if test="${e.eid==p.empFk}">selected</c:if> >${e.ename}</option>
			</c:forEach>
		</select>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">开发人数：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="empcount" value="${pro.empcount}">人</td>

	<td align="right" bgcolor="#FAFAF1" height="22">开始时间：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="starttime" id="ks" value="<fmt:formatDate value='${pro.starttime}' pattern='yyyy-MM-dd'></fmt:formatDate>"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">立项时间：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="buildtime" id="br1" value="<fmt:formatDate value='${pro.buildtime}' pattern='yyyy-MM-dd'></fmt:formatDate>"/>

	</td>


	<td align="right" bgcolor="#FAFAF1" height="22">预估成本：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="cost" value="${pro.cost}"/>万</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">级别：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<select name="level">
			<option value=1 <c:if test="${pro.level == 1}" >selected</c:if>>紧急</option>
			<option value=2 <c:if test="${pro.level == 2}" >selected</c:if>>一般</option>
			<option value=3 <c:if test="${pro.level == 3}" >selected</c:if>>暂缓</option>
		</select></td>
	<td align="right" bgcolor="#FAFAF1" height="22">计划完成时间：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="endtime" id="br2" value="<fmt:formatDate value='${pro.endtime}' pattern='yyyy-MM-dd'></fmt:formatDate>"/></td>
</tr>

<tr >
	<td align="right" bgcolor="#FAFAF1" >备注：</td>
	<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
		<textarea name="remark" rows=15 cols=130>${pro.remark}</textarea>
	</td>
</tr>


<tr bgcolor="#FAFAF1">
<td height="28" colspan=4 align=center>
	&nbsp;
	<a href="javascript:commit()" class="coolbg">保存</a>
	<a href="${pageContext.request.contextPath}/pro" class="coolbg">返回</a>
</td>
</tr>
</table>

</form>
<script type="text/javascript">

	<%--	自动选择客户负责人--%>

	function addcus(clist) {
		var c = clist.split(",");
		$("[name = comper]").val(c[1]);
	}

	//提交添加
	function commit() {
		$("#forms").submit();
	}


</script>

</body>
</html>