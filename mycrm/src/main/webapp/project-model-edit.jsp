<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>编辑模块信息</title>
    <link rel="stylesheet" type="text/css" href="skin/css/base.css">
    <script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript">
        //回显项目下拉框
        $(function () {
            //alert("kkkkkk");
            var mid = ${module.proname};
            $.ajax({
                url: '${pageContext.request.contextPath}/ana/getPro?pid=' + mid,
                type: 'post',
                dataType: 'json',
                success: function (obj) {
                    console.log(obj);
                    if (obj.length > 0) {
                        $.each(obj, function (inedx) {
                            if (mid == obj[inedx].pid) {
                                $("#pro").append("<option value='" + obj[inedx].pid + "," + obj[inedx].pname + "' selected >" + obj[inedx].pname + "</option>");
                            } else {
                                $("#pro").append("<option value='" + obj[inedx].pid + "," + obj[inedx].pname + "'>" + obj[inedx].pname + "</option>");
                            }

                        })
                    }

                    //回显需求名
                    addayalisys(mid);

                },
                error: function (xhr) {
                    alert("错误");
                }

            })
        })

        //回显需求下拉框
        function addayalisys(pid) {
            $("#anid").empty();
            $.ajax({
                url: '${pageContext.request.contextPath}/mod/getAna?pid=' + pid,
                type: 'post',
                dataType: 'json',
                success: function (obj) {
                    console.log(obj);
                    if (null != obj) {
                        proobj = "<option value='" + obj.id + "'>" + obj.title + "</option>";
                        $("#anid").append(proobj);
                    } else {
                        alert("请选择项目");
                    }
                },
                error: function (xhr) {
                    alert("错误2");
                }

            })
        }


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
                        当前位置:项目管理>>编辑模块信息
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<form name="form2" action="${pageContext.request.contextPath}/mod/saveInfo" method="post" id="form2">

    <table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center"
           style="margin-top:8px">
        <tr bgcolor="#E7E7E7">
            <td height="24" colspan="2" background="skin/images/tbg.gif">&nbsp;编辑模块&nbsp;</td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">选择项目：</td>
            <input name="id" value="${module.id}" type="hidden">
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <select id="pro" name="proname" onchange="addayalisys(this.value.split(',')[0])">
                </select></td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">选择需求：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <select id="anid" name="analysis_fk">
                    <option value=0>帐户管理需求分析</option>
                </select></td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">模块名称：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input name="modname" value="${module.modname}"/></td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">优先级：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <select name="level">
                    <option value="高" <c:if test="${module.level eq '高'}" >selected</c:if>>高</option>
                    <option value="中" <c:if test="${module.level eq '中'}" >selected</c:if>>中</option>
                    <option value="低"  <c:if test="${module.level eq '低'}" >selected</c:if>>低</option>
                    <option value="暂缓"  <c:if test="${module.level eq '暂缓'}" >selected</c:if>>暂缓</option>
                </select></td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">简单描述：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <textarea name="simpledis" rows=10 cols=130>${module.simpledis}</textarea></td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">详细描述：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <textarea name="detaileddis" rows=15 cols=130>${module.detaileddis}</textarea>
            </td>
        </tr>

        <tr>
            <td align="right" bgcolor="#FAFAF1">备注：</td>
            <td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';">
                <textarea name="remark" rows=10 cols=130>${module.remark}</textarea>
            </td>
        </tr>


        <tr bgcolor="#FAFAF1">
            <td height="28" colspan=4 align=center>
                &nbsp;
                <a href="javascript:commit();" class="coolbg">保存</a>
                <a href="project-model.jsp" class="coolbg">返回</a>
            </td>
        </tr>
    </table>

</form>
<script type="text/javascript">

    function commit() {
        $("#form2").submit();
    }

</script>

</body>
</html>