<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fomt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>对标信息管理</title>
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
                        当前位置:对标管理>>对标信息管理
                    </td>

                </tr>
            </table>
        </td>
    </tr>
</table>

<!--  搜索表单  -->

<!--  内容列表   -->
<form name="form2">

    <table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center"
           style="margin-top:8px">
        <tr bgcolor="#E7E7E7">
            <td height="24" colspan="12" background="skin/images/tbg.gif">&nbsp;标杆企业信息列表&nbsp;</td>
        </tr>
        <tr align="center" bgcolor="#FAFAF1" height="22">
            <td width="4%">选择</td>
            <td width="6%">序号</td>
            <td width="9%">企业名称</td>
            <td width="9%">年度</td>
            <td width="8%">年营业额</td>
            <td width="10%">企业优势</td>
            <td width="5%">员工数量</td>
            <td width="9%">成立时间</td>
            <td width="10%">操作</td>
        </tr>

        <c:forEach items="${cList}" var="c">
            <tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <td><input name="id" type="checkbox" id="id" value="${c.daid}" class="np"></td>
                <td>${c.daid}</td>
                <td><a href=''><u>${c.dacname}</u></a></td>
                <td>
                <fomt:formatDate value="${c.datime}" pattern="yyyy-MM-dd" ></fomt:formatDate>
                </td>
                <td>${c.daturnover}</td>
                <td>${c.dasuperiority}</td>
                <td>${c.empcount}</td>
                <td>
                    <fomt:formatDate value="${c.buildtime}" pattern="yyyy-MM-dd" ></fomt:formatDate>
                </td>
                <td><a href="project-base-edit.jsp">编辑</a> | <a href="project-base-look.jsp">查看详情</a></td>
            </tr>
        </c:forEach>


        <tr bgcolor="#FAFAF1">
            <td height="28" colspan="12">
                &nbsp;
                <a href="" class="coolbg">全选</a>
                <a href="" class="coolbg">反选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="" class="coolbg">&nbsp;删除&nbsp;</a>
                <a href="${pageContext.request.contextPath}/duibiao/exportExcel" class="coolbg">&nbsp;导出Excel&nbsp;</a>
                <a href="../duibiao-add.jsp" class="coolbg">&nbsp;添加采集信息&nbsp;</a>
            </td>
        </tr>
        <tr align="right" bgcolor="#EEF4EA">
            <td height="36" colspan="12" align="center"><!--翻页代码 --></td>
        </tr>
    </table>

</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js" ></script>
<script type="text/javascript" >
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


</body>
</html>