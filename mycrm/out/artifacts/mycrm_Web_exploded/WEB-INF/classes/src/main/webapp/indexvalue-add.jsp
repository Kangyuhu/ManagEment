<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加对标信息</title>
<link rel="stylesheet" type="text/css" href="skin/css/base.css">
	<script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
	<link type="text/css" href="http://code.jquery.com/ui/1.9.1/themes/smoothness/jquery-ui.css" rel="stylesheet" />

	<link href="${pageContext.request.contextPath}/datejs/jQuery-Timepicker-Addon/jquery-ui-timepicker-addon.css" type="text/css" />
	<link href="${pageContext.request.contextPath}/datejs/jQuery-Timepicker-Addon/demos.css" rel="stylesheet" type="text/css" />

	<script src="http://code.jquery.com/jquery-1.8.2.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="http://code.jquery.com/ui/1.9.1/jquery-ui.min.js"></script>
	<script src="${pageContext.request.contextPath}/datejs/jQuery-Timepicker-Addon/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
	<!--中文-->
	<script src="${pageContext.request.contextPath}/datejs/js/jquery.ui.datepicker-zh-CN.js.js" type="text/javascript" charset="UTF-8"></script>
	<script src="${pageContext.request.contextPath}/datejs/js/jquery-ui-timepicker-zh-CN.js" type="text/javascript" charset="UTF-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/date/WdatePicker.js"></script>
	<script type="text/javascript">
<%--        时间插件--%>
        var dateSkin = "blue";
        $(document).ready(function () {
            //开始时间
            $("#inStarttime").focus(function () {
                WdatePicker({skin: dateSkin, readOnly: true, dateFmt: 'yyyy-MM-dd'})
            });
            //截止时间
            $("#inEndtime").focus(function () {
                WdatePicker({skin: dateSkin, readOnly: true, dateFmt: 'yyyy-MM-dd'})
            });

        });

		//回显对标企业下拉框
		$(function () {
			//alert("kkkkkk");
			$.ajax({
				url: '${pageContext.request.contextPath}/duibiao/addIndexvalue',
				type: 'post',
				dataType: 'json',
				success: function (obj) {
					// console.log(obj);
					if (obj.length > 0) {
						$.each(obj, function (inedx) {
							var proobj = "<option value='" + obj[inedx].dacname + "'>" + obj[inedx].dacname + "</option>";
							$("#comnameFk1").append(proobj);
						})
					}
				},
				error: function (xhr) {
					alert("错误");
				}

			})
		})

		//回显对标企业数据
		function showInfo(dacname){
			$("#anid").empty();
			$.ajax({
				url: '${pageContext.request.contextPath}/duibiao/getDatacollectByDacname?dacname='+dacname,
				type: 'post',
				dataType: 'json',
				success: function (obj) {
					console.log(obj);
					if (null != obj) {
						//公司名称
						$("#cname1").val(obj.dacname);
						//目标公司
						$("#pname").val(obj.dacname);
						//向后台传递的关联外键
						$("#comnameFk").val(obj.daid);
						//营业额
						$("#money1").val(obj.daturnover);
						//年份
                        var d = new Date(obj.datime);
                        var newdate = d.getFullYear()+"-"+d.getMonth()+1+"-"+d.getDate();
						$("#year1").val(newdate);
						//主要业务
						$("#maindo1").val(obj.dabusiness);
						//优势
						$("#good1").val(obj.dasuperiority);
						//劣势
						$("#nogood1").val(obj.dainforiority);
						//行业地位
						$("#po1").val(obj.dasort);
						//员工数量
						$("#count1").val(obj.empcount);
						//创建时间
						$("#build1").val(obj.buildtime);
						//简单描述
						$("#remark1").val(obj.remark);
						//附件下载
						$("#attachment").html(obj.daother)
						$("#attachment").attr("href","${pageContext.request.contextPath}/duibiao/download");

					}else {
						alert("请选择项目");
					}
				},
				error: function (xhr) {
					alert("错误2");
				}

			})
		}

	//	提交
        function commit() {
            $("#form17").submit();
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
  <td >
    当前位置:对标管理>>添加对标基本信息
 </td>
 </tr>
</table>
</td>
</tr>
</table>

<div>

	<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
		<tr bgcolor="#E7E7E7">
			<td height="40" colspan="12" background="skin/images/tbg.gif">
				<h1>选择对标企业：</h1>
				<select id="comnameFk1" onchange="showInfo(this.value)">
					<option value=0>选择对标企业</option>
				</select>

			</td>
		</tr>
	</table>


	<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
		<tr bgcolor="#E7E7E7">
			<td height="24" colspan="12" background="skin/images/tbg.gif">&nbsp;<font color="red">对标企业信息如下</font>&nbsp;</td>
		</tr>
		<tr >

			<td align="right" bgcolor="#FAFAF1" height="22">公司名称：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<input type="text" name="pname" id="cname1" readonly/>
			</td>

			<td align="right" bgcolor="#FAFAF1" height="22" >营业额：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<input type="text" id="money1" readonly/>
			</td>
		</tr>
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22">年份：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<input type="text"  id="year1" name="comper" readonly/>
			</td>
			<td align="right" bgcolor="#FAFAF1" height="22">主要业务：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				  <textarea rows="3" cols="18" id="maindo1" readonly></textarea>
			</td>
		</tr>
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22" >优势：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<textarea rows="3" cols="18" id="good1" readonly></textarea>
			</td>
			<td align="right" bgcolor="#FAFAF1" height="22">劣势：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<textarea rows="3" cols="18" id="nogood1" readonly></textarea>
			</td>
		</tr>
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22">行业地位：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<input type="text" name="buildtime" id="po1" readonly/>
			</td>
			<td align="right" bgcolor="#FAFAF1" height="22">员工数量：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<input type="text" name="cost" id="count1" readonly/>
			</td>
		</tr>
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22">创建时间：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<input type="text" name="cost" id="build1" readonly/>
			</td>
			<td align="right" bgcolor="#FAFAF1" height="22"></td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">

			</td>
		</tr>

		<tr >
			<td align="right" bgcolor="#FAFAF1" >简单描述：</td>
			<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
				<textarea type="text" rows=15 cols=130 id="remark1" readonly></textarea>
			</td>
		</tr>

		<tr >
			<td align="right" bgcolor="#FAFAF1" >附件下载：</td>
			<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
				<a href="" id="attachment" ></a>
			</td>
		</tr>

	</table>

</div>




<!-- 添加指标 -->



<form name="form2" id="form17" action="${pageContext.request.contextPath}/duibiao/saveIndexValueInfo" method="POST" enctype="multipart/form-data">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="12" background="skin/images/tbg.gif">&nbsp;<font color="red">添加对标信息</font>&nbsp;</td>
</tr>
  <tr >
	<td align="right" bgcolor="#FAFAF1" height="22">目标公司：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input type="text" id="pname" readonly/>
        <!-- 向后台传递的关联外键 -->
        <input type="hidden" id="comnameFk"  name="comnameFk">
	</td>

	<td align="right" bgcolor="#FAFAF1" height="22" >目标营业额：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input type="text" name="inTurnover"/>
	</td>

</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">业务方向：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input type="text"  id="cp" name="inBusiness"/>
	</td>
	<td align="right" bgcolor="#FAFAF1" height="22">开始时间：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input type="datetime" class="time" id="inStarttime" name="inStarttime"/>
	</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22" >截止时间：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input type="datetime" class="time" id="inEndtime" name="inEndtime"/></td>
	<td align="right" bgcolor="#FAFAF1" height="22"></td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22"></td>
</tr>


<tr >
	<td align="right" bgcolor="#FAFAF1" >备注：</td>
	<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
		<textarea type="text" rows=15 cols=130 name="inRemark"></textarea><span id="number"></span>
	</td>
</tr>
	<tr >
		<td align="right" bgcolor="#FAFAF1" >上传详细计划书：</td>
		<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
			<input type="file" name="files" >
		</td>
	</tr>

<tr bgcolor="#FAFAF1">
<td height="28" colspan=4 align=center>
	&nbsp;
	<A class="coolbg" onclick="commit()" >保存</A>
	<a href="${pageContext.request.contextPath}/duibiao/getIndexvalueList" class="coolbg">返回</a>
</td>
</tr>
</table>

</form>
  

</body>
</html>