<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>收件箱</title>
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
                        当前位置:消息推送>>展示消息
                    </td>
                    <td>
                        <input type='button' class="coolbg np"
                               onClick="location='${pageContext.request.contextPath}/msg/toSeedMsg';" value='添加消息'/>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>


<!--  内容列表   -->
<form name="form2">

    <table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center"
           style="margin-top:8px">
        <tr bgcolor="#E7E7E7">
            <td height="24" colspan="12" background="skin/images/tbg.gif">&nbsp;消息列表&nbsp;</td>
        </tr>
        <tr align="center" bgcolor="#FAFAF1" height="22">
            <td width="4%">选择</td>
            <td width="4%">序号</td>
            <td width="10%">内容</td>
            <td width="5%">
                <c:if test="${flag == 1}">发件人</c:if>
                <c:if test="${flag == 0}">收件人</c:if>
            </td>
            <td width="6%">收件时间</td>
            <td width="5%">状态</td>
            <td width="8%">操作</td>
        </tr>

        <c:forEach items="${mlist}" var="m">
            <tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <td><input name="id" type="checkbox" id="id" value="${m.msgid}" class="np"></td>
                <td>${m.msgid}</td>
                <td align="center"><span>${m.msgcontent}</span></td>
                <td>${m.emp.ename}</td>
                <td>
                    <fmt:formatDate value="${m.msgtime}" pattern="yyyy-MM-dd"></fmt:formatDate>
                </td>
                <td>
                    <c:if test="${m.mark == 0}">未读</c:if>
                    <c:if test="${m.mark == 1}">已读</c:if>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/msg/getByMsgId?msgid=${m.msgid}">删除</a>
                    <a href="${pageContext.request.contextPath}/msg/getByMsgId?msgid=${m.msgid}&flag=1">查看</a>
                </td>
            </tr>
        </c:forEach>


        <tr bgcolor="#FAFAF1">
            <td height="28" colspan="12">
                &nbsp;
                <a href="" class="coolbg">全选</a>
                <a href="" class="coolbg">反选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="" class="coolbg">&nbsp;删除&nbsp;</a>

            </td>
        </tr>
        <tr align="right" bgcolor="#EEF4EA">
            <td height="36" colspan="12" align="center"><!--翻页代码 --></td>
        </tr>
    </table>

</form>


</body>
</html>