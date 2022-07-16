<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>车牌识别停车场管理系统</title>
		<jsp:include page="/IncludeJS.jsp"></jsp:include>
		<script type="text/javascript">
			function check(){
				$("#message").text("");
				var carNo=$("#carNo").val();
				var userName = $("#userName").val();
				var mobile = $("#mobile").val();
				if(carNo==""){
					alert("请输入车牌号码，必须唯一");
					$("#carNo").focus();
					return false;
				}			
				if(userName==""){
					alert("请输入车主姓名");
					$("#userName").focus();
					return false;
				}			
				if(mobile==""){
					alert("请输入手机号码");
					$("#mobile").focus();
					return false;
				}			
				return true;	
			}
			if("${msg}"!=""){
				alert("${msg}");
			}
		</script>
	</head>
	<body class="bg_all">
		<div class="face_header">
			<div class="face_header_con">
				<p class="face_header_lf">车牌识别停车场管理系统</p>
				<a class="face_header_rg" href="javascript:void(0);"><span class="headsp"><img src="${pageContext.request.contextPath }/images/icon-user.png" ></span></a>
			</div>
		</div>
		<form action="${pageContext.request.contextPath }/car/carAdd" method="post" onsubmit="return check();">
		<input type="hidden" name="carInfoId" id="carInfoId" value="${carInfo.carInfoId}">
		<div class="exam_content">
			<div class="exam_con">
				<div class="person_right">
					<ul>
						<li><span>&nbsp;</span><h2>新增/修改车辆信息</h2></li>
						<li><font color="red" id="message"></font></li>
						<li><span>车牌号码:</span><input type="text" name="carNo" id="carNo" class="iptxs"  value="${carInfo.carNo}"></li>
						<li><span>车主姓名:</span><input type="text" name="userName" id="userName" class="iptxs" value="${carInfo.userName}"></li>
						<li><span>手机号码:</span><input type="text" name="mobile" id="mobile" class="iptxs" value="${carInfo.mobile}"></li>
						<li><span>开始日期:</span><input type="date" name="startDate" id="startDate" class="iptxs" value="${carInfo.startDate}"></li>
						<li><span>截止日期:</span><input type="date" name="expireDate" id="expireDate" class="iptxs" value="${carInfo.expireDate}"></li>
						<li><span>身份证:</span><input type="text" name="remark" id="remark" class="iptxs" value="${carInfo.remark}"></li>
						<li><span>&nbsp;</span><input type="submit" class="kaoshi_btn" value="保存"></li>
					</ul>
				</div>
			</div>
		</div>
		</form>
	</body>
</html>
	