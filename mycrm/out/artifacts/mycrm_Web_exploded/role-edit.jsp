<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>编辑角色信息</title>
	<script src="${pageContext.request.contextPath}/js/jquery-2.1.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/script/docs.min.js"></script>
	<script src="${pageContext.request.contextPath}/layer/layer.js"></script>
	<script src="${pageContext.request.contextPath}/ztree/jquery.ztree.all-3.5.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/ztree/zTreeStyle.css">
	<script type="application/javascript">
		$(function(){
			var setting = {
				check: {
					enable: true,
					chkStyle: "checkbox",
					chkboxType: { "Y": "p", "N": "s" }
				},
				async: {
					enable: true,
					url:"${pageContext.request.contextPath}/auth/showAuth",
					autoParam:["id", "name=n", "level=lv"]
				},
				callback: {
					onAsyncSuccess: dd
				}
			};
			$.fn.zTree.init($("#permissionTree"), setting);
			dd();
			$("#myButton").click(function() {
				// 获取我们的树
				var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
				// 获取被选中的节点
				var nodes = treeObj.getCheckedNodes(true);//[1,3,6]
				if(0 === nodes.length) {
					alert("请选择!");
					return;
				}
				var dataNodes = "";//1,3,6
				for(var i = 0; i < nodes.length; i++) {
					dataNodes += nodes[i].id + ",";
				}
				console.log("ids"+dataNodes);
				$("#sid").val(dataNodes);
				$("#form18").submit();
			});
		});

		function dd(event, treeId, treeNode, msg){
			var zTree = $.fn.zTree.getZTreeObj("permissionTree");
			var sstr="${rsisList}";
			var menuIds =sstr.split(",");
			console.log(menuIds+"---------");
			for(var i = 0; i < menuIds.length; i++) {
				var node = zTree.getNodeByParam("id",menuIds[i]);
				console.log(node);
				if(node != null) {
					zTree.checkNode(node,true,true);
				}
			}
			return false;
		}

	</script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
</head>
<body leftmargin="8" topmargin="8" background='${pageContext.request.contextPath}/skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
	<tr>
		<td height="26" background="${pageContext.request.contextPath}/skin/images/newlinebg3.gif">
			<table width="58%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td >
						当前位置:权限管理>>编辑角色
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<form name="form2" action="${pageContext.request.contextPath}/auth/updRole" method="post" id="form18">

	<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
		<tr bgcolor="#E7E7E7">
			<td height="24" colspan="2" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;编辑角色&nbsp;</td>
		</tr>
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22">角色编号：</td>
			<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">${role.roleid}</td>
		</tr>
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22">角色名称：</td>
			<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<input value="${role.rolename}" name="rolename"/></td>
		</tr>
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22">状态：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<select>
					<option <c:if test="${role.status==1}">selected</c:if> value=1>启用</option>
					<option <c:if test="${role.status==0}">selected</c:if> value=0>禁用</option>
				</select>
			</td>
		</tr>
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22">赋菜单资源：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">

				<div class="panel-body">
					<ul id="permissionTree" class="ztree"></ul>
				</div>

			</td>
		</tr>

		<tr >
			<td align="right" bgcolor="#FAFAF1" >备注：</td>
			<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
				<textarea rows=10 cols=130 name="roledis">${role.roledis}</textarea>
			</td>
		</tr>


		<tr bgcolor="#FAFAF1">
			<td height="28" colspan=4 align=center>
				&nbsp;
				<input type="hidden" name="sid" id="sid">
				<input type="hidden" name="roleid" value="${role.roleid}">
				<a href="javascript:;" class="coolbg" id="myButton">保存</a>
				<a href="role.jsp" class="coolbg">返回</a>
				<%--<a href="javascript:dd()" >kkkk</a>--%>

			</td>
		</tr>
	</table>

</form>


</body>
</html>