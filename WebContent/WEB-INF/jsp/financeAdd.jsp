<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
			//修改密码
			function check(){
				var totalMoney = $('#totalMoney').val();
				var expireDate = $('#expireDate').val();
				if(totalMoney==""){
					alert("请输入缴费金额");
					$("#totalMoney").focus();
					return false;
				}
				if(isNaN(totalMoney)){
					alert("缴费金额含有非法字符");
					$("#totalMoney").focus();
					return false;
				}
				if(expireDate==""){
					alert("请选择有效期");
					$("#expireDate").focus();
					return false;
				}
				return true;
			}
		</script>
	</head>
	<body class="bg_all">
		<div class="face_header">
			<div class="face_header_con">
				<p class="face_header_lf">车牌识别停车场管理系统</p>
				<a class="face_header_rg" href="javascript:void(0);"><span class="headsp"><img src="${pageContext.request.contextPath }/images/icon-user.png" ></span>${userinfo.userName }</a>
			</div>
		</div>
		<div class="exam_tit">
			<ul>
				<li><a href="${pageContext.request.contextPath }/car/carInfo">车辆信息</a></li>
				<li><a href="${pageContext.request.contextPath }/car/stopCar">停车信息</a></li>
				<li><a href="${pageContext.request.contextPath }/car/finance">缴费列表</a></li>
				<li><a href="${pageContext.request.contextPath }/car/financeStat?curYear=2020">月度统计</a></li>
				<li><a href="${pageContext.request.contextPath }/user/user">管理员账号</a></li>
				<li><a href="${pageContext.request.contextPath }/user/pwd">修改密码</a></li>
				<li><a href="${pageContext.request.contextPath }/user/sysSet">系统设置</a></li>
				<li><a href="${pageContext.request.contextPath }/user/faceCheck">返回监控</a></li>
				<li><a href="${pageContext.request.contextPath }/user/login">退出系统</a></li>
			</ul>
		</div>
		<form name="form1" action="${pageContext.request.contextPath}/car/financeAdd" method="post" onsubmit="return check()">
		<input type="hidden" name="carInfoId" id="carInfoId" value="${carInfo.carInfoId}">
		<input type="hidden" name="carNo" id="carNo" value="${carInfo.carNo}">
		<div class="exam_content">
			<div class="exam_con">
				<div class="person_right">
				<h2 class="exam_con_t">包月车缴费</h2>
					<ul>
						<li><span>车牌号码:</span>${carInfo.carNo}</li>
						<li><span>车主姓名:</span>${carInfo.userName}</li>
						<li><span>手机号码:</span>${carInfo.mobile}</li>
						<li><span>登记日期:</span>${carInfo.startDate}</li>
						<li><span>截止日期:</span>${carInfo.expireDate}</li>
						<li><span>缴费金额:</span><input type="text" name="totalMoney" id="totalMoney" class="iptxs"></li>
						<li><span>有效期止:</span><input type="date" name="expireDate" id="expireDate" class="iptxs" value="${carInfo.expireDate}"></li>
						<li><span>&nbsp;</span><input type="submit" class="kaoshi_btn" value="缴费"></li>
					</ul>
				</div>
			</div>
		</div>
		</form>
	</body>
</html>
	