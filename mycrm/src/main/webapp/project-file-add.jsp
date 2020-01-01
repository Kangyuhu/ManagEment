<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>添加附件</title>
    <link rel="stylesheet" type="text/css" href="skin/css/base.css">
    <script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript">
        //回显项目下拉框
        $(function () {
            //alert("kkkkkk");
            $.ajax({
                url: '${pageContext.request.contextPath}/ana/getPro?pid=1',
                type: 'post',
                dataType: 'json',
                success: function (obj) {
                    // console.log(obj);
                    if (obj.length > 0) {
                        $.each(obj, function (inedx) {
                            var proobj = "<option value='" + obj[inedx].pid + "'>" + obj[inedx].pname + "</option>";
                            $("#pro").append(proobj);
                        })
                    }
                },
                error: function (xhr) {
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
                        当前位置:项目管理>>添加附件
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<form name="form2" action="${pageContext.request.contextPath}/att/saveInfo" method="post"
      enctype="multipart/form-data" id="form2">

    <table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center"
           style="margin-top:8px">
        <tr bgcolor="#E7E7E7">
            <td height="24" colspan="2" background="skin/images/tbg.gif">&nbsp;添加附件&nbsp;</td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">选择项目：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <select id="pro" name="proFk">
                    <option value=0>选择项目</option>
                </select>
            </td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">附件名称：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input size="26" name="attname"/></td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">附件信息描述：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input size="52" name="attdis"/></td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">附件：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input type="file" name="files"/></td>
        </tr>

        <tr>
            <td align="right" bgcolor="#FAFAF1">备注：</td>
            <td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';">
                <textarea rows=10 cols=130 name="remark"></textarea>
            </td>
        </tr>


        <tr bgcolor="#FAFAF1">
            <td height="28" colspan=4 align=center>
                &nbsp;
                <a href="javascript:commit()" class="coolbg">保存</a>
                <a href="${pageContext.request.contextPath}/att" class="coolbg">返回</a>
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