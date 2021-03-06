<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>创建任务</title>
    <link rel="stylesheet" type="text/css" href="skin/css/base.css">
    <script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript">
        //回显项目下拉框
        $(function () {
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
                    alert("错误项目");
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
                success: function (ana) {
                    console.log(ana);
                    if (null != ana) {
                        proobj = "<option value='" + ana.id + "'>" + ana.title + "</option>";
                        $("#anid").append(proobj);

                        //回显模块下拉框
                        $("#mod").html("<option value=0>请选择模块</option>");
                        $.ajax({
                            url: '${pageContext.request.contextPath}/fun/getMod?mid=' + ana.id,
                            type: 'post',
                            dataType: 'json',
                            success: function (mod) {
                                console.log(mod);
                                if (mod.length > 0) {
                                    $.each(mod, function (inedx) {
                                        var proobj = "<option value='" + mod[inedx].id + "'>" + mod[inedx].modname + "</option>";
                                        $("#mod").append(proobj);
                                    })
                                }
                            },
                            error: function (xhr) {
                                alert("错误模块");
                            }
                        })
                    }
                },
                error: function (xhr) {
                    alert("错误需求");
                }

            })
        }

        //回显功能下拉框
        function addfunc(mid) {
            $("#fun").html("<option value=0>请选择功能</option>");
            $.ajax({
                url: '${pageContext.request.contextPath}/task/getFun?mid=' + mid,
                type: 'post',
                dataType: 'json',
                success: function (obj) {
                    console.log(obj);
                    if (obj.length > 0) {
                        $.each(obj, function (inedx) {
                            var proobj = "<option value='" + obj[inedx].id + "'>" + obj[inedx].functionname + "</option>";
                            $("#fun").append(proobj);
                        })
                    }
                },
                error: function (xhr) {
                    alert("错误功能");
                }
            })
        }


        //    执行人员

        $(function () {
            $("#emp").html("<option value=0>任务的执行者</option>");
            $.ajax({
                url: '${pageContext.request.contextPath}/task/getEmpList',
                type: 'post',
                dataType: 'json',
                success: function (obj) {
                    console.log(obj);
                    if (obj.length > 0) {
                        $.each(obj, function (inedx) {
                            var proobj = "<option value='" + obj[inedx].eid + "'>" + obj[inedx].ename + "</option>";
                            $("#emp").append(proobj);
                        })
                    }
                },
                error: function (xhr) {
                    alert("错误功能");
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
                        当前位置:任务管理>>创建任务
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<form name="form2" id="form2" action="${pageContext.request.contextPath}/task/saveInfo" method="post">

    <table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center"
           style="margin-top:8px">
        <tr bgcolor="#E7E7E7">
            <td height="24" colspan="2" background="skin/images/tbg.gif">&nbsp;创建任务&nbsp;</td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">参考位置：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <select id="pro" onchange="addayalisys(this.value)">
                    <option value=0>请选择项目</option>
                </select>-
                <select id="anid">
                    <option value=0>请选择需求</option>
                </select>
                -<select id="mod" onchange="addfunc(this.value)">
                <option value=0>请选择模块</option>
            </select>-
                <select id="fun" name="funFk">
                    <option value=0>请选择功能</option>
                </select>
            </td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">任务标题：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22"><input name="tasktitle"/></td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">开始时间：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input name="starttime"/></td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">结束时间：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input name="endtime"/></td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">执行者：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <select id="emp" name="empFk2" onchange="addemp()">
                    <option value=0>任务的执行者</option>
                </select>
            </td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">优先级：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <select name="level">
                    <option value="高">高</option>
                    <option value="中">中</option>
                    <option value="低">低</option>
                </select></td>
        </tr>

        <tr>
            <td align="right" bgcolor="#FAFAF1">详细说明：</td>
            <td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';">
                <textarea rows=10 cols=130 name="remark"></textarea>
            </td>
        </tr>


        <tr bgcolor="#FAFAF1">
            <td height="28" colspan=4 align=center>
                &nbsp;
                <a href="javascript:commit()" class="coolbg">保存</a>
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