<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>编辑需求分析信息</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
    <script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"> </script>
    <script type="text/javascript">
        //回显项目下拉框
        $(function () {
            //alert("kkkkkk");
            var aid = ${ana.id};
            $.ajax({
                url:'${pageContext.request.contextPath}/ana/getPro?pid='+aid,
                type:'post',
                dataType:'json',
                success:function (obj) {
                    console.log(obj);
                    if (obj.length > 0){
                            $.each(obj,function (inedx) {
                            if (aid == obj[inedx].pid) {
                                $("#pro").append("<option value='"+obj[inedx].pid+","+obj[inedx].pname+"' selected >"+obj[inedx].pname+"</option>");
                            }else {
                                $("#pro").append("<option value='"+obj[inedx].pid+","+obj[inedx].pname+"'>"+obj[inedx].pname+"</option>");
                            }

                        })
                    }
                },
                error:function (xhr) {
                    alert("错误");
                }

            })
        })

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
                        当前位置:项目管理>>编辑需求分析信息
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<form name="form2" action="${pageContext.request.contextPath}/ana/saveInfo" id="form3">
    <table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center"
           style="margin-top:8px">
        <input name="id" value="${ana.id}" type="hidden">
        <tr bgcolor="#E7E7E7">
            <td height="24" colspan="2" background="skin/images/tbg.gif">&nbsp;编辑需求信息&nbsp;</td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">项目：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <select id="pro" name="newproname">
                    <option value="0">选择项目</option>
                </select>
            </td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">标题：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input name="title" value="${ana.title}"/></td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">简单描述：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <textarea name="simpledis" rows=10 cols=130>${ana.simpledis}</textarea>
            </td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">详细描述：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <textarea name="detaileddis" rows=15 cols=130>${ana.detaileddis}</textarea>
            </td>
        </tr>

        <tr>
            <td align="right" bgcolor="#FAFAF1">备注：</td>
            <td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';">
                <textarea name="remark" rows=10 cols=130>${ana.remark}</textarea>
            </td>
        </tr>


        <tr bgcolor="#FAFAF1">
            <td height="28" colspan=4 align=center>
                &nbsp;
                <a href="javascript:commit()" class="coolbg">保存</a>
                <a href="${pageContext.request.contextPath}/ana" class="coolbg">返回</a>
            </td>
        </tr>
    </table>

</form>
<script type="text/javascript">

    //提交保存
    function commit() {
        $("#form3").submit();
    }

</script>



</body>
</html>