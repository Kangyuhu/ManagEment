<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>任务信息</title>
    <link rel="stylesheet" type="text/css" href="skin/css/base.css">
    <script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

</head>
<body leftmargin="8" topmargin="8" background='skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
    <tr>
        <td height="26" background="skin/images/newlinebg3.gif">
            <table width="58%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        当前位置:任务管理>>任务信息
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!--  搜索表单  -->
<form name='form3' action='${pageContext.request.contextPath}/task' method='get'>
    <input type='hidden' name='dopost' value=''/>
    <table width='98%' border='0' cellpadding='1' cellspacing='1' bgcolor='#CBD8AC' align="center"
           style="margin-top:8px">
        <tr bgcolor='#EEF4EA'>
            <td background='skin/images/wbg.gif' align='center'>
                <table border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td width='90' align='center'>状态：</td>
                        <td width='160'>
                            <select name='status' style='width:150px'>
                                <option value='0'>请选择</option>
                                <option value='1' <c:if test="${status == 1}">selected</c:if>>未完成</option>
                                <option value='2' <c:if test="${status == 2}">selected</c:if>>进行中</option>
                                <option value='3' <c:if test="${status == 3}">selected</c:if>>已完成</option>
                            </select>
                        </td>
                        <td width='90' align='center'>搜索条件：</td>
                        <td width='160'>
                            <select name='cid' style='width:150px'>
                                <option value='0'>选择类型...</option>
                                <option value='1' <c:if test="${cid == 1}">selected</c:if>>任务标题</option>
                                <option value='2' <c:if test="${cid == 2}">selected</c:if>>执行者</option>
                            </select>
                        </td>
                        <td width='70'>
                            关键字：
                        </td>
                        <td width='160'>
                            <input type='text' name='keyword' value='${keyword}' style='width:120px'/>
                        </td>
                        <td width='110'>
                            <select name='orderby' style='width:120px'>
                                <option value='0'>排序...</option>
                                <option value='1' <c:if test="${orderby == 1}">selected</c:if>>开始时间</option>
                                <option value='2' <c:if test="${orderby == 2}">selected</c:if>>结束时间</option>
                            </select>
                        </td>
                        <td>
                            &nbsp;&nbsp;&nbsp;<input name="imageField" type="submit" src="skin/images/frame/search.gif"
                                                     width="45" height="20" border="0" class="np"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>
<!--  内容列表   -->
<form name="form2">

    <table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center"
           style="margin-top:8px">
        <tr bgcolor="#E7E7E7">
            <td height="24" colspan="12" background="skin/images/tbg.gif">&nbsp;任务信息&nbsp;</td>
        </tr>
        <tr align="center" bgcolor="#FAFAF1" height="22" id="tr2">
            <td width="4%">选择</td>
            <td width="6%">序号</td>
            <td width="10%">任务标题</td>
            <td width="10%">执行者</td>
            <td width="8%">状态</td>
            <td width="8%">优先级</td>
            <td width="8%">开始时间</td>
            <td width="8%">结束时间</td>
            <td width="15%">操作</td>
        </tr>

        <c:forEach items="${tList}" var="t" >
            <tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <td><input name="id" type="checkbox" id="id" value="101" class="np"></td>
                <td>${t.id}</td>
                <td>${t.tasktitle}</td>
                <td align="center">${t.ename}</td>
                <td align="center" >
                    <c:if test="${t.status == 1}">未开始</c:if>
                    <c:if test="${t.status == 2}">进行中</c:if>
                    <c:if test="${t.status == 3}">已完成</c:if>
                </td>
                <td align="center">${t.level}</td>
                <td><fmt:formatDate value="${t.starttime}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
                <td><fmt:formatDate value="${t.endtime}" pattern="yyyy-MM-dd"></fmt:formatDate></td>

                <td><a href="${pageContext.request.contextPath}/task/updateEcho?id=${t.id}">编辑</a> |
                    <a href="${pageContext.request.contextPath}/task/getTask?id=${t.id}">查看详情</a>
                </td>
            </tr>
        </c:forEach>

        <tr>
            <td colspan="7">
                <div id="pager" style="width:20%;float:right">
                </div>
                <div style="width:10%;float:right"><span>共有数据：<strong>${count}</strong> 条</span></div>
                <link href="static\page\pagination.css" type="text/css" rel="stylesheet" />
                <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js" ></script>
                <script type="text/javascript" src="${pageContext.request.contextPath}/static/page/jquery.pagination.js" ></script>
                <script type="text/javascript">
                    //初始化分页组件
                    var count=${count};
                    var size=${size};
                    var pageNO=${pageNO};
                    //alert(count+"==="+size+"==="+pageNO);
                    $("#pager").pagination(count, {
                        items_per_page:size,
                        current_page:pageNO-1,
                        next_text:"下一页",
                        prev_text:"上一页",
                        num_edge_entries:2,
                        load_first_page:false,
                        callback:handlePaginationClick
                    });

                    //回调方法
                    function handlePaginationClick(new_page_index, pagination_container){
//                  <c:url value="${pageContext.request.contextPath}/task"/>?pageNO="+(new_page_index+1);
                        $("#pg").val(new_page_index+1);
                        $("#fm").submit();
                    }

                    //删除
                    function del() {
                        var len = $("input[name = id]:checked").length;
                        if (len > 0){
                            if (confirm("确定删除吗？")){
                                alert(len)
                                $("#form2").submit();
                            }
                        }else {
                            alert("选择要删除的内容");
                        }
                    }

                    //全选
                    function  checkedAll() {
                        alert("啦啦啦");
                        $("[name = id]").prop("checked",true);
                    }

                    //反选
                    function cancelCheckedAll() {
                        //var ids = document.getElementsByName("id");
                        var ids = $("[name = id]");

                        for(var i=0;i<ids.length;i++){
                            if(ids[i].checked)
                                ids[i].checked=false ;
                            else
                                ids[i].checked=true ;
                        }
                    }

                    //全不选
                    function noCheckedAll() {
                        alert("哒哒哒");
                        $("[name = id]").prop("checked",false);
                    }

                </script>
            </td>
        </tr>


        <tr bgcolor="#FAFAF1">
            <td height="28" colspan="12">
                &nbsp;
                <a href="${pageContext.request.contextPath}/task?status=1" class="coolbg">未完成的任务</a>
                <a href="${pageContext.request.contextPath}/task?status=2" class="coolbg">进行中的任务</a>
                <a href="${pageContext.request.contextPath}/task?status=3" class="coolbg">已完成的任务</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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