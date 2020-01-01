<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>报销管理</title>
    <link rel="stylesheet" type="text/css" href="skin/css/base.css">
</head>
<body leftmargin="8" topmargin="8" background='skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
    <tr>
        <td height="26" background="skin/images/newlinebg3.gif">
            <table width="58%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        当前位置:报销管理>>报销列表
                    </td>

                </tr>
            </table>
        </td>
    </tr>
</table>


<!--  内容列表   -->
<form name="form2">

    <table width="98%" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
        <tr bgcolor="#E7E7E7">
            <td height="24" colspan="12" background="skin/images/tbg.gif">&nbsp;报销单列表&nbsp;</td>
        </tr>
        <tr align="center" bgcolor="#FAFAF1" height="22">
            <td width="4%">选择</td>
            <td width="10%">编号</td>
            <td width="10%">类型</td>
            <td width="10%">报销人</td>
            <td width="6%">总金额</td>
            <td width="10%">使用时间</td>
            <td width="30%">备注信息</td>
            <td width="10%">审批状态</td>
            <td width="10%">操作</td>
        </tr>

        <c:forEach items="${bList}" var="bs">
            <tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <td><input name="id" type="checkbox" id="id" value="101" class="np"></td>
                <td>${bs.bxid}</td>
                <td>${bs.paymode}</td>
                <td>${bs.employee.ename}</td>
                <td>${bs.totalmoney}</td>
                <td align="center"><a href=''><u> <fmt:formatDate value="${bs.bxtime}"
                                                                  pattern="yyyy-MM-dd"></fmt:formatDate> </u></a></td>
                <td>${bs.bxremark}</td>
                <td>
                    <c:if test="${bs.bxstatus == 0}">未审批</c:if>
                    <c:if test="${bs.bxstatus == 1}">审批通过 </c:if>
                    <c:if test="${bs.bxstatus == 2}">驳回</c:if>
                </td>
                <td>
                    <c:if test="${bs.bxstatus == 0}">
                        <a href="${pageContext.request.contextPath}/bx/getByBaoXiao/?bxid=${bs.bxid}">审批</a></c:if>
                    <c:if test="${bs.bxstatus == 1}">
                        <a href="javascript:void(0)" style="pointer-events:none;color: grey">编辑</a></c:if>
                    <c:if test="${bs.bxstatus == 2}">
                        <a href="${pageContext.request.contextPath}/bx/getByBaoXiao/?bxid=${bs.bxid}">审批</a></c:if>
                </td>
            </tr>
        </c:forEach>

        <tr bgcolor="#FAFAF1">
            <td height="28" colspan="12">
                <c:if test="${examine == 0}">
                    <a href="${pageContext.request.contextPath}/bx/getBaoXiao?examine=1"
                       class="coolbg">&nbsp;已审批的报销&nbsp;</a>
                </c:if>
                <c:if test="${examine == 1}">
                    <a href="${pageContext.request.contextPath}/bx/getBaoXiao"
                       class="coolbg">&nbsp;返回&nbsp;</a>
                </c:if>
            </td>

        </tr>

        <tr align="right" bgcolor="#EEF4EA">
            <td height="36" colspan="12" align="center"><!--翻页代码 --></td>
        </tr>
    </table>

</form>


</body>
</html>