<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>对标管理</title>
    <link rel="stylesheet" type="text/css" href="skin/css/base.css">
    <script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/eacharjs/echarts.common.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/date/WdatePicker.js"></script>
    <script type="text/javascript">
        var dateSkin = "blue";
        $(document).ready(function () {
            $("#st").focus(function () {
                WdatePicker({skin: dateSkin, readOnly: true, dateFmt: 'yyyy-MM-dd'})
            });
            $("#et").focus(function () {
                WdatePicker({skin: dateSkin, readOnly: true, dateFmt: 'yyyy-MM-dd'})
            });
        });

    </script>
</head>
<body leftmargin="8" topmargin="8" background='skin/images/allbg.gif'>
<%--检索条件--%>
<form method="post">
    <table width='98%' border='0' cellpadding='1' cellspacing='1' bgcolor='#CBD8AC' align="center"
           style="margin-top:8px">
        <tr bgcolor='#EEF4EA'>
            <td background='skin/images/wbg.gif' align='center'>
                <table border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td width='90' align='center'>搜索条件：</td>
                        <td width='100'>
                            <input type="hidden" value="1" name="pageNO" id="pn">
                            <select name="dname" id="dname" class="style='width:120px'">
                                <option value="0">选择企业</option>
                            </select>
                        </td>
                        <td width='70'>
                            时间段：
                        </td>
                        <td width='300'>
                            <input type="text" id="st" name="startTime" style='width:120px'>---
                            <input type="text" id="et" name="endTime" style='width:120px'>
                        </td>
                        <td>
                            &nbsp;&nbsp;&nbsp;<input type="button" onclick="sear()" value="查询" class="np">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
    <tr>
        <td height="26" background="skin/images/newlinebg3.gif">
            <table width="58%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        当前位置:对标管理>>对标分析
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<div>
    <div id="box" style="width:600px;height:600px"></div>
</div>

<script type="text/javascript">
    //回显对标企业下拉框
    $(function () {
        $.ajax({
            url: '${pageContext.request.contextPath}/duibiao/addIndexvalue',
            type: 'post',
            dataType: 'json',
            success: function (obj) {
                if (obj.length > 0) {
                    $.each(obj, function (inedx) {
                        var proobj = "<option value='" + obj[inedx].dacname + "'>" + obj[inedx].dacname + "</option>";
                        $("#dname").append(proobj);
                    })
                }
            },
            error: function (xhr) {
                alert("错误");
            }
        })
    })//

    //提交
    function sear() {
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('box'));
        var year = [];
        var money = [];
        var dname = $("#dname").val();
        var startTime = $("#st").val();
        var endTime = $("#et").val();
        $.ajax({
            url: '${pageContext.request.contextPath}/duibiao/getDatacollectSearch',
            data: {"dname": dname, "startTime": startTime, "endTime": endTime},
            type: 'post',
            dataType: 'json',
            success: function (obj) {
                $.each(obj, function (index) {
                    var d = new Date(obj[index].datime);
                    year.push(d.getFullYear());
                    money.push(obj[index].daturnover);

                    // 指定图表的配置项和数据
                    var option = {
                        title: {
                            text: '营业额柱状图'
                        },
                        tooltip: {},
                        legend: {
                            data: ['营业额']
                        },
                        xAxis: {
                            data: year
                        },
                        yAxis: {},
                        series: [{
                            name: '销量',
                            type: 'bar',
                            data: money
                        }]
                    };
                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);
                })
            },
            error: function (xhr) {
                alert("错误");
            }
        })

    }
</script>
</body>
</html>