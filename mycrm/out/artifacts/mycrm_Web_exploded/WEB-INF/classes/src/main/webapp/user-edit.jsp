<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>编辑用户信息</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
	<script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/date/WdatePicker.js"></script>
	<script type="text/javascript">
		var dateSkin = "blue";
		$(document).ready(function () {
			$("#time").focus(function () {
				WdatePicker({skin: dateSkin, readOnly: true, dateFmt: 'yyyy-MM-dd'})
			});
		});
		//回显下拉框
		$(function () {
			$.ajax({
				url: '${pageContext.request.contextPath}/auth/getAll',
				type: 'post',
				dataType: 'json',
				success: function (obj) {
					console.log(obj);
					var pot = obj.pot;
					var lev = obj.lev;
					var dep = obj.dep;
					var rol = obj.rol;
					var potid = ${emp.pFk};
					var rolid = ${eRole.roleFk};
					$("#position").html("<option value=0>请选择</option>");
					$("#role").html("<option value=0>请选择</option>");
					$.each(pot, function (inedx) {
						if (pot[inedx].id == potid){
							$("#position").append("<option value="+pot[inedx].id+" <c:if test='${pot[inedx].id == potid}'>selected</c:if>>"+pot[inedx].name+"</option>");

						} else {
							$("#position").append("<option value="+pot[inedx].id+" >"+pot[inedx].name+"</option>");
						}
					})
					$.each(rol, function (inedx) {
						if (rol[inedx].roleid == rolid){

							$("#role").append("<option value="+rol[inedx].roleid+" <c:if test='${rol[inedx].roleid == rolid}'>selected</c:if>>"+rol[inedx].rolename+"</option>");
						} else {
							$("#role").append("<option value="+rol[inedx].roleid+">"+rol[inedx].rolename+"</option>");
						}
					})
				},
				error: function (xhr) {
					alert("错误");
				}
			})
		})
	</script>
</head>
<body leftmargin="8" topmargin="8" background='${pageContext.request.contextPath}/skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
<tr>
 <td height="26" background="${pageContext.request.contextPath}/skin/images/newlinebg3.gif">
  <table width="58%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td >
    当前位置:权限管理>>编辑用户
 </td>
 </tr>
</table>
</td>
</tr>
</table>

<form name="form2" action="${pageContext.request.contextPath}/auth/SaveEmp" method="post" id="form19">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="2" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;编辑用户&nbsp;</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">职位：</td>
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<select name="pFk" id="position">

		</select>
	</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">姓名：</td>
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="ename" value="${emp.ename}"/></td>
		<input type="hidden" name="eid" value="${emp.eid}"/>
<%--		<input type="erid" name="eid" value="${eRole.erid}"/>--%>
	</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">性别：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<select name="esex">
			<option value=0 <c:if test="${emp.esex == 0}">selected</c:if>>男</option>
			<option value=1 <c:if test="${emp.esex == 1}">selected</c:if>>女</option>
		</select>
	</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">年龄：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="eage" value="${emp.eage}"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">联系电话：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="telephone" value="${emp.telephone}"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">入职时间：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="hiredate" value="<fmt:formatDate value="${emp.hiredate}" pattern="yyyy-MM-dd" ></fmt:formatDate>" id="time"/>
	</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">身份证号码：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="pnum" value="${emp.pnum}"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">用户名：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="username" value="${emp.username}"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">密码：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="password" value="${emp.password}"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">赋角色：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<select name="roleid" id="role">
		</select>
	</td>
</tr>

<tr >
	<td align="right" bgcolor="#FAFAF1" >备注：</td>
	<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
		<textarea name="remark" rows=10 cols=130>${emp.remark}</textarea>
	</td>
</tr>


<tr bgcolor="#FAFAF1">
<td height="28" colspan=4 align=center>
	&nbsp;
	<a href="javascript:commit()" class="coolbg">保存</a>
	<a href="${pageContext.request.contextPath}/auth/getEmpAll" class="coolbg">返回</a>
</td>
</tr>
</table>

</form>
<script type="text/javascript">

	function commit() {
		$("#form19").submit();
	}

</script>
  

</body>
</html>