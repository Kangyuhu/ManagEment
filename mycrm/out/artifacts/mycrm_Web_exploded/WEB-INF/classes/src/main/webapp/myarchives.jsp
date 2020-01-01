<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>展示个人档案</title>
    <link rel="stylesheet" type="text/css" href="skin/css/base.css">
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
                    <td>
                        当前位置:档案>>个人档案信息
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<form name="form2" id="form2" action="${pageContext.request.contextPath}/emp/saveInfo" method="post">
         <input type="hidden" name="eid" id="id" value="${myArc.eid}"/>
    <table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center"
           style="margin-top:8px">

        <tr bgcolor="#E7E7E7">
            <td height="24" colspan="12" background="skin/images/tbg.gif">&nbsp;个人档案信息&nbsp;</td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">员工姓名：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input type="text" name="ename" id="pname" value="${myArc.ename}"/>
            </td>

            <td align="right" bgcolor="#FAFAF1" height="22">性别：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                男<input type="radio" name="esex"  value="1"
                        <c:if test="${myArc.esex ==1}" >checked</c:if>>
                女<input type="radio" name="esex"  value="2"
                        <c:if test="${myArc.esex ==2}" >checked</c:if>>
	</td>
</tr>
<tr >
	<td align=" right" bgcolor="#FAFAF1" height="22">毕业院校：
            </td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input type="text" id="arc.school" name="school" value="${myArc.arc.school}"/>
	</td>
	<td align=" right" bgcolor="#FAFAF1" height="22">专业：
            </td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input type="text" id="zhuanye" name="arc.zhuanye" value="${myArc.arc.zhuanye}"/>
	</td>
</tr>

<tr >
	<td align=" right" bgcolor="#FAFAF1" height="22" >生日：
            </td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input id="ks" type="text" name="hiredate"
                value="<fmt:formatDate value='${myArc.hiredate}' pattern='yyyy-MM-dd' ></fmt:formatDate>"/>
            </td>


	<td align=" right" bgcolor="#FAFAF1" height="22">民族：
            </td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input type="text" name="arc.minzu" value="${myArc.arc.minzu}"/></td>
</tr>

<tr >
	<td align=" right" bgcolor="#FAFAF1" height="22">入职时间：
            </td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input id="br1" type="text" name="arc.hirdate"
                value="<fmt:formatDate value='${myArc.arc.hirdate}' pattern='yyyy-MM-dd' ></fmt:formatDate>"/>

            </td>

	<td align=" right" bgcolor="#FAFAF1" height="22">紧急联系人：
            </td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input type="text" name="arc.sosperson" id="sosperson" value="${myArc.arc.sosperson}"/></td>
</tr>
<tr >
	<td align=" right" bgcolor="#FAFAF1" height="22">级别：
            </td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input type="text" name="level.jdis" id="level" readonly="true" value="${myArc.level.jdis}"/></td>
	</td>

	<td align=" right" bgcolor="#FAFAF1" height="22">职位：
            </td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input type="text" name="position.name" id="position" readonly="true" value="${myArc.position.name}"/></td>
</tr>
	<tr >
		<td align=" right" bgcolor="#FAFAF1" height="22">部门：
            </td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input type="text" name="dept.dname" id="dname" readonly="true" value="${myArc.dept.dname}"/></td>
		</td>

		<td align=" right" bgcolor="#FAFAF1" height="22">邮箱：
            </td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input type="text" name="arc.email" readonly="true" value="${myArc.arc.email}"/></td>
	</tr>



<tr >
	<td align=" right" bgcolor="#FAFAF1" >备注：
            </td>
            <td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';">
                <textarea type="text" rows=15 cols=130 name="arc.remark">${myArc.arc.remark}</textarea><span
                    id="number"></span>
            </td>
        </tr>


        <tr bgcolor="#FAFAF1">
            <td height="28" colspan=4 align=center>
                &nbsp;
                <a href="javascript:commit()" class="coolbg">保存</a>
                <a href="javascript:retu()" class="coolbg">返回</a>
            </td>
        </tr>
    </table>

</form>
<script type="text/javascript">

    function commit() {
        alert("提交");
        $("#form2").submit();
    }

    function retu(){
        var  sign = ${sign};
        if ( sign == 1){
        //    别人的
            window.location.href = "${pageContext.request.contextPath}/emp/getArcList";
        }else {
        //    自己的
            window.location.href = "${pageContext.request.contextPath}/index.jsp";
        }
    }



</script>


</body>
</html>