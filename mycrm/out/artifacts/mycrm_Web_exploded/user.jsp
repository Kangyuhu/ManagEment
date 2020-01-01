<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>用户管理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
</head>
<body leftmargin="8" topmargin="8" background='${pageContext.request.contextPath}/skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
    <tr>
        <td height="26" background="${pageContext.request.contextPath}/skin/images/newlinebg3.gif">
            <table width="58%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        当前位置:权限管理>>用户管理
                    </td>
                    <td>
                        <input type='button' class="coolbg np" onClick="location='${pageContext.request.contextPath}/user-add.jsp';" value='添加用户'/>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!--  搜索表单  -->
<form name='form3' action='' method='get'>
    <input type='hidden' name='dopost' value=''/>
    <table width='98%' border='0' cellpadding='1' cellspacing='1' bgcolor='#CBD8AC' align="center"
           style="margin-top:8px">
        <tr bgcolor='#EEF4EA'>
            <td background='${pageContext.request.contextPath}/skin/images/wbg.gif' align='center'>
                <table border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td width='90' align='center'>搜索条件：</td>
                        <td width='160'>
                            <select name='cid' style='width:150'>
                                <option value='0'>选择类型...</option>
                                <option value='1'>姓名</option>
                                <option value='1'>联系电话</option>
                            </select>
                        </td>
                        <td width='70'>
                            关键字：
                        </td>
                        <td width='160'>
                            <input type='text' name='keyword' value='' style='width:120px'/>
                        </td>
                        <td width='110'>
                            <select name='orderby' style='width:120px'>
                                <option value='id'>排序...</option>
                                <option value='pubdate'>添加时间</option>
                                <option value='pubdate'>修改时间</option>
                            </select>
                        </td>
                        <td>
                            &nbsp;&nbsp;&nbsp;<input name="imageField" type="image" src="${pageContext.request.contextPath}/skin/images/frame/search.gif"
                                                     width="45" height="20" border="0" class="np"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>
<!--  内容列表   -->
<form action="${pageContext.request.contextPath}/auth/getEmpAll" method="post" id="fm">

    <table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center"
           style="margin-top:8px">
        <tr bgcolor="#E7E7E7">
            <input name="pageNO" value="1" id="pg" type="hidden"/>
            <td height="24" colspan="12" background="skin/images/tbg.gif">&nbsp;用户列表&nbsp;</td>
        </tr>
        <tr align="center" bgcolor="#FAFAF1" height="22">
            <td width="4%">选择</td>
            <td width="6%">序号</td>
            <td width="10%">姓名</td>
            <td width="10%">职位</td>
            <td width="10%">性别</td>
            <td width="10%">年龄</td>
            <td width="10%">联系电话</td>
            <td width="8%">入职时间</td>
            <td width="8%">状态</td>
            <td width="10%">操作</td>
        </tr>


        <c:forEach items="${empAll}" var="emp">
            <tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <td><input name="id" type="checkbox" id="${emp.eid}" value="101" class="np"></td>
                <td>${emp.eid}</td>
                <td>${emp.ename}</td>
                <td align="center">
                    <c:forEach items="${pl}" var="p">
                        <c:if test="${p.id == emp.pFk}">${p.name}</c:if>
                    </c:forEach>
                </td>

                <td>
                    <c:if test="${emp.esex eq '0'}">男</c:if>
                    <c:if test="${emp.esex eq '1'}">女</c:if>
                </td>
                <td>${emp.eage}</td>
                <td>${emp.telephone}</td>
                <td>
                    <fmt:formatDate value="${emp.hiredate}" pattern="yyyy-MM-dd"></fmt:formatDate>
                </td>
                <td>正常</td>
                <td><a href="${pageContext.request.contextPath}/auth/toUpdate?eid=${emp.eid}">编辑</a> | <a href="user-look.jsp">查看详情</a></td>
            </tr>
        </c:forEach>

        <tr>
            <td colspan="7">
                <div id="pager" style="width:20%;float:right">
                </div>
                <div style="width:10%;float:right"><span>共有数据：<strong>${count}</strong> 条</span></div>
                <link href="${pageContext.request.contextPath}/static/page/pagination.css" type="text/css" rel="stylesheet"/>
                <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
                <script type="text/javascript"
                        src="${pageContext.request.contextPath}/static/page/jquery.pagination.js"></script>
                <script type="text/javascript">
                    //初始化分页组件
                    var count =${count};
                    var size =${size};
                    var pageNO =${pageNO};
                    $("#pager").pagination(count, {
                        items_per_page: size,
                        current_page: pageNO - 1,
                        next_text: "下一页",
                        prev_text: "上一页",
                        num_edge_entries: 2,
                        load_first_page: false,
                        callback: handlePaginationClick
                    });

                    //回调方法
                    function handlePaginationClick(new_page_index, pagination_container) {
                        $("#pg").val(new_page_index + 1);
                        $("#fm").submit();
                    }

                    //删除
                    function del() {
                        var len = $("input[name = id]:checked").length;
                        if (len > 0) {
                            if (confirm("确定删除吗？")) {
                                alert(len)
                                $("#form2").submit();
                            }
                        } else {
                            alert("选择要删除的内容");
                        }
                    }

                    //全选
                    function checkedAll() {
                        $("[name = id]").prop("checked", true);
                    }

                    //反选
                    function cancelCheckedAll() {
                        //var ids = document.getElementsByName("id");
                        var ids = $("[name = id]");

                        for (var i = 0; i < ids.length; i++) {
                            if (ids[i].checked)
                                ids[i].checked = false;
                            else
                                ids[i].checked = true;
                        }
                    }

                    //全不选
                    function noCheckedAll() {
                        $("[name = id]").prop("checked", false);
                    }

                </script>
            </td>
        </tr>


        <tr bgcolor="#FAFAF1">
            <td height="28" colspan="12">
                &nbsp;
                <a href="" class="coolbg">全选</a>
                <a href="" class="coolbg">反选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="" class="coolbg">删除</a>
                <a href="" class="coolbg">&nbsp;注销&nbsp;</a>
                <a href="" class="coolbg">&nbsp;导出Excel&nbsp;</a>
            </td>
        </tr>
        <tr align="right" bgcolor="#EEF4EA">
            <td height="36" colspan="12" align="center"><!--翻页代码 --></td>
        </tr>
    </table>

</form>


</body>
</html>