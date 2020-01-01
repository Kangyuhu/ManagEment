<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fom" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>档案信息管理</title>
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
                        当前位置:项目管理>>档案信息管理
                    </td>

                </tr>
            </table>
        </td>
    </tr>
</table>

<!--  搜索表单  -->

<!--  内容列表   -->
<form name="form2" action="${pageContext.request.contextPath}/emp/getArcList" id="fm">
    <table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center"
           style="margin-top:8px">
        <tr bgcolor="#E7E7E7">
            <td height="24" colspan="12" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;员工档案信息列表&nbsp;</td>
        </tr>
        <tr align="center" bgcolor="#FAFAF1" height="22">
            <input name="pageNO" value="1" id="pg" type="hidden"/>
            <td width="4%">选择</td>
            <td width="6%">序号</td>
            <td width="4%">姓名</td>
            <td width="4%">年龄</td>
            <td width="10%">毕业院校</td>
            <td width="10%">入职时间</td>
            <td width="8%">联系方式</td>
            <td width="8%">学历</td>
            <td width="10%">邮箱</td>
            <td width="8%">政治面貌</td>
            <td width="8%">民族</td>
            <td width="10%">操作</td>
        </tr>
        <c:forEach items="${arcList}" var="a">
            <tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <td><input name="id" type="checkbox" id="id" value="${a.arc.dnum}" class="np"></td>
                <td>${a.arc.dnum}</td>
                <td align="left"><a href=''><u>${a.ename}</u></a></td>
                <td>${a.eage}</td>
                <td>${a.arc.school}</td>
                <td>
                    <fom:formatDate value="${a.arc.hirdate}" pattern="yyyy-MM-dd"></fom:formatDate>
                </td>
                <td>${a.arc.landline}</td>
                <td>${a.arc.xueli}</td>
                <td>${a.arc.email}</td>
                <td>${a.arc.zzmm}</td>
                <td>${a.arc.minzu}</td>
                <td><a href="${pageContext.request.contextPath}/emp/getMyArcList?arc=1&eid=${a.eid}">编辑</a> |
                    <a href="../myarchives.jsp">查看详情</a></td>
            </tr>
        </c:forEach>

        <tr>
            <td colspan="7">
                <div id="pager" style="width:20%;float:right">
                </div>
                <div style="width:10%;float:right"><span>共有数据：<strong>${count}</strong> 条</span></div>
                <link href="${pageContext.request.contextPath}/static\page\pagination.css" type="text/css" rel="stylesheet"/>
                <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
                <script type="text/javascript"
                        src="${pageContext.request.contextPath}/static/page/jquery.pagination.js"></script>
                <script type="text/javascript">
                    //初始化分页组件
                    var count =${count};
                    var size =${size};
                    var pageNO =${pageNO};
                    //alert(count+"==="+size+"==="+pageNO);
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
                        alert("啦啦啦");
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
                        alert("哒哒哒");
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
                <a href="" class="coolbg">&nbsp;删除&nbsp;</a>
                <a href="" class="coolbg">&nbsp;导出Excel&nbsp;</a>
                <a href="../archives-add.jsp" class="coolbg">&nbsp;添加档案信息&nbsp;</a>
            </td>
        </tr>
        <tr align="right" bgcolor="#EEF4EA">
            <td height="36" colspan="12" align="center"><!--翻页代码 --></td>
        </tr>
    </table>

</form>


</body>
</html>