<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
    <title>main</title>
    <base target="_self">
    <link rel="stylesheet" type="text/css" href="skin/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="skin/css/main.css"/>
    <script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript">
        //通知公告
        $(function () {
            $.ajax({
                url: '${pageContext.request.contextPath}/noc/getNdate4',
                type: 'post',
                dataType: 'json',
                success: function (obj) {
                    if (obj.length > 0) {
                        $.each(obj, function (inedx) {
                            var ntitle = obj[inedx].ntitle;
                            var remark = obj[inedx].remark;
                            var d = new Date(obj[inedx].ndate);
                            var newdate = d.getFullYear() + "-" + d.getMonth() + "-" + d.getDate();
                            var proobj = "<li class='ue-clear'>" +
                                "<span>" + newdate + "</span>&nbsp;&nbsp;&nbsp;" +
                                "<a href='javascript:showWindow(\"" + ntitle + "\",\"" + remark + "\")' class='notice-title'>" + obj[inedx].ntitle + "</a></li> <p>";
                            $("#notices").append(proobj);
                        })
                    }
                },
                error: function (xhr) {
                    alert("错误");
                }

            })
        })


        //未完成任务
        $(function () {
            // alert("kkkkkk");

            $.ajax({
                url: '${pageContext.request.contextPath}/noc/getNoTask?status=1',
                type: 'post',
                dataType: 'json',
                success: function (obj) {
                    if (obj.length > 0) {
                        $("#notask").html("您有<a href='${pageContext.request.contextPath}/task?status=1'><font color='red'>" + obj.length + "</font></a>个任务未完成……&nbsp;");
                    }
                },
                error: function (xhr) {
                    alert("错误");
                }

            })
        })


        //未读消息
        $(function () {
            $.ajax({
                url: '${pageContext.request.contextPath}/msg/getUnreadMsg',
                type: 'post',
                dataType: 'json',
                success: function (obj) {
                    if (obj.length > 0) {
                        $("#unreadMsg").html("您有<a href='${pageContext.request.contextPath}/msg/getMyMsgList?flag=1'><font  color='red'>" + obj.length + "</font></a>条未读消息……&nbsp;");
                    } else {
                        $("#unreadMsg").html("您没有未读消息;");
                    }
                },
                error: function (xhr) {
                    alert("错误");
                }

            })
        })


        //员工论坛
        $(function () {
            $.ajax({
                url: '${pageContext.request.contextPath}/forum/getForumList',
                type: 'post',
                dataType: 'json',
                success: function (obj) {
                    var str = "";
                    if (obj.length > 0) {
                        $.each(obj, function (inedx) {
                            var forumtitle = obj[inedx].forumtitle;
                            var d = new Date(obj[inedx].createtime);
                            var newdate = d.getFullYear() + "-" + d.getMonth() + 1 + "-" + d.getDate();
                            if (inedx % 3 == 0) {
                                str += "<tr bgcolor='#FFFFFF'>";
                            }
                            str += "<td>" +
                                     "<ul class='notice-list'>" +
                                          "<li class='ue-clear'>" +
                                                  "<span><img src='${pageContext.request.contextPath}/skin/images/tbg.gif' height='50px' width='50px'/></span>" +
                                                 "<span id='issueTime'>发布时间：" + newdate + "</span>" +
                                             "<a id='forumMsg' href='${pageContext.request.contextPath}/forum/getByForumID?forumid="+obj[inedx].forumid+
                                                "'class='notice-title'>" + forumtitle + "</a>" +
                                          "</li>" +
                                      "</ul>" +
                                   "</td>"
                            if (inedx%3 == 2){
                                str += "</tr>";
                            }

                        });
                        $("#tb").append(str);
                    }
                },
                error: function (xhr) {
                    alert("错误");
                }

            })
        })


        function showWindow(nt, rk) {
            $("#showdiv").css("display", "block");
            $("#ntitle").html(nt);
            $("#content").html(rk);
        }

        function closeWindow() {
            $("#showdiv").css("display", "none");
        }

    </script>
</head>
<body leftmargin="8" topmargin='8'>
<!-- 遮罩层 -->
<div id="cover"
     style="background: #000; position: absolute; left: 0px; top: 0px; width: 100%; filter: alpha(opacity=30); opacity: 0.3; display: none; z-index: 2 ">

</div>
<!-- 弹窗 -->
<div id="showdiv"
     style="width: 60%; margin: 0 auto; height:500px; border: 1px solid #999; display: none; position: absolute; top: 20%; left: 20%; z-index: 3; background: #fff">
    <!-- 标题 -->
    <div id="ntitle"
         style="background: #F8F7F7; width: 100%; height: 2rem; font-size: 0.65rem; line-height: 2rem; border: 1px solid #999; text-align: center;">

    </div>
    <!-- 内容 -->
    <div id="content" style="text-indent: 50px; height: 4rem; font-size: 0.5rem; padding: 0.5rem; line-height: 1rem; ">

    </div>
    <!-- 按钮 -->
    <div style="background: green; width: 10%; margin: 0 auto; height: 1.5rem; line-height: 1.5rem; text-align: center;color: #fff;margin-top: 28rem; -moz-border-radius: .128rem; -webkit-border-radius: .128rem; border-radius: .128rem;font-size: .59733rem;"
         onclick="closeWindow()">
        关闭
    </div>
</div>


<table width="98%" border="0" align="center" cellpadding="0"
       cellspacing="0">
    <tr>
        <td>
            <div style='float: left'>
                <img height="14" src="skin/images/frame/book1.gif" width="20"/>&nbsp;欢迎使用项目平台管理系统
            </div>
            <div style='float: right; padding-right: 8px;'>
                <!--  //保留接口  -->
            </div>
        </td>
    </tr>
    <tr>
        <td height="1" background="${pageContext.request.contextPath}/skin/images/frame/sp_bg.gif"
            style='padding: 0px'></td>
    </tr>
</table>
<br>
<table width="98%" align="center" border="0" cellpadding="4"
       cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom: 8px">
    <tr>
        <td colspan="2" background="${pageContext.request.contextPath}/skin/images/frame/wbg.gif"
            bgcolor="#EEF4EA" class='title'>
            <div style='float: left'>
                <span>快捷操作</span>
            </div>
            <div style='float: right; padding-right: 10px;'></div>
        </td>
    </tr>
    <tr bgcolor="#FFFFFF">
        <td height="30" colspan="2" align="center" valign="bottom">
            <table
                    width="100%" border="0" cellspacing="1" cellpadding="1">
                <tr>
                    <td width="15%" height="31" align="center"><img
                            src="skin/images/frame/qc.gif" width="90" height="30"/></td>
                    <td width="85%" valign="bottom">
                        <div class='icoitem'>
                            <div class='ico'>
                                <img src='${pageContext.request.contextPath}/skin/images/frame/addnews.gif' width='16' height='16'/>
                            </div>
                            <div class='txt'>
                                <a href='${pageContext.request.contextPath}/pro'><u>查看项目信息</u></a>
                            </div>
                        </div>
                        <div class='icoitem'>
                            <div class='ico'>
                                <img src='${pageContext.request.contextPath}/skin/images/frame/menuarrow.gif' width='16'
                                     height='16'/>
                            </div>
                            <div class='txt'>
                                <a href='task-my.html'><u>查看任务</u></a>
                            </div>
                        </div>
                        <div class='icoitem'>
                            <div class='ico'>
                                <img src='${pageContext.request.contextPath}/skin/images/frame/manage1.gif' width='16' height='16'/>
                            </div>
                            <div class='txt'>
                                <a href='${pageContext.request.contextPath}/forum/getMyForumList?eid=${sessionScope.usr.eid}'><u>我的帖子</u></a>
                            </div>
                        </div>
                        <div class='icoitem'>
                            <div class='ico'>
                                <img src='${pageContext.request.contextPath}/skin/images/frame/file_dir.gif' width='16'
                                     height='16'/>
                            </div>
                            <div class='txt'>
                                <a href='message-give.html'><u>收件箱</u></a>
                            </div>
                        </div>
                        <div class='icoitem'>
                            <div class='ico'>
                                <img src='${pageContext.request.contextPath}/skin/images/frame/part-index.gif' width='16'
                                     height='16'/>
                            </div>
                            <div class='txt'>
                                <a href='info.html'><u>个人信息</u></a>
                            </div>
                        </div>
                        <div class='icoitem'>
                            <div class='ico'>
                                <img src='${pageContext.request.contextPath}/skin/images/frame/manage1.gif' width='16' height='16'/>
                            </div>
                            <div class='txt'>
                                <a href='modpassword.html'><u>修改密码</u></a>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<br>

<table width="98%" align="center" border="0" cellpadding="3"
       cellspacing="1" bgcolor="#CBD8AC"
       style="margin-bottom: 8px; margin-top: 8px;">
    <tr>
        <td background="${pageContext.request.contextPath}/skin/images/frame/wbg.gif" bgcolor="#EEF4EA"
            class='title'><span>待完成任务</span></td>
    </tr>
    <tr bgcolor="#FFFFFF">
        <td id="notask">
        </td>
    </tr>
</table>

<br>

<table width="98%" align="center" border="0" cellpadding="3"
       cellspacing="1" bgcolor="#CBD8AC"
       style="margin-bottom: 8px; margin-top: 8px;">
    <tr>
        <td background="${pageContext.request.contextPath}/skin/images/frame/wbg.gif" bgcolor="#EEF4EA"
            class='title'><span>未读消息</span></td>
    </tr>
    <tr bgcolor="#FFFFFF">
        <td id="unreadMsg">
            您有<a href=""><font color="red"></font></a>条未读消息……&nbsp;
        </td>
    </tr>
</table>


<br>


<table width="98%" align="center" border="0" cellpadding="3"
       cellspacing="1" bgcolor="#CBD8AC"
       style="margin-bottom: 8px; margin-top: 8px;">
    <tr>
        <td background="${pageContext.request.contextPath}/skin/images/frame/wbg.gif" bgcolor="#EEF4EA"
            class='title'><span>通知公告</span>
            <a href='${pageContext.request.contextPath}/noc' style='padding-left: 260px'>查看更多...</a></td>
    </tr>
    <tr bgcolor="#FFFFFF">
        <td>
            <ul class="notice-list" id="notices">

                <%--<li class="ue-clear">
                <span>12-15</span>&nbsp;&nbsp;&nbsp;<a href="javascript:showWindow()"class="notice-title">中国移动关于设立作风建设监督举报电话的公告</a>
                </li>
                <p>--%>


            </ul>
        </td>
    </tr>
</table>

<br>


<table id="tb" width="98%" align="center" border="0" cellpadding="3"
       cellspacing="1" bgcolor="#CBD8AC"
       style="margin-bottom: 8px; margin-top: 8px;">
    <tr>
        <td colspan="3" background="${pageContext.request.contextPath}/skin/images/frame/tbg.gif" bgcolor="#EEF4EA"
            class='title'>
            <span>员工论坛</span><a href='forum.jsp' style='padding-left: 260px'>查看更多...</a>
        </td>
    </tr>

    <%--<% for (int i = 0; i < 12; i++) {
        if (i % 3 == 0) {%>
    <tr bgcolor='#FFFFFF'>
        <%}%>

        <td>
            <ul class="notice-list">
                <li class="ue-clear">
                    <span><img src="${pageContext.request.contextPath}/images/tx.png" height="50px"
                               width="50px"/></span>
                    <span id="issueTime">发布时间：2018-12-25</span>
                    <a id="forumMsg" href="role.jsp" class="notice-title">招租信息</a>
                </li>
            </ul>
        </td>
        <%} %>
    </tr>--%>

</table>

</body>
</html>