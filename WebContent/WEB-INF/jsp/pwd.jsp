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
			function updPwd(userid){
				var oldpwd = $('#oldPassword').val();
				var newpwd = $('#newPassword').val();
				var cfgpwd = $('#confirmPwd').val();
				if(oldpwd==""){
					alert("请输入旧密码");
					$("#oldPassword").focus();
					return ;
				}
				if("${userinfo.password}"!=oldpwd){
					alert("旧密码与原密码不一致");
					$("#oldPassword").focus();
					return ;
				}
				if(newpwd==""){
					alert("请输入新密码");
					$("#newPassword").focus();
					return ;
				}
				if(newpwd !=cfgpwd){
					alert("新密码与确认密码不一致");
					$("#confirmPwd").focus();
					return;
				}
				var url="${pageContext.request.contextPath}/user/updPwd";
				$.post(
					url,
					{
						"userId":"${userinfo.userId}",
						"password":newpwd
					},
					function(data){
						alert(data.msg);
						location.href="${pageContext.request.contextPath}/user/login";
					},
					"json"
				);
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
		<div class="exam_content">
			<div class="exam_con">
				<div class="person_right">
				<h2 class="exam_con_t">修改密码</h2>
					<ul>
						<li><span>用户姓名:</span>${userinfo.userName}</li>
						<li><span>登录名称:</span>${userinfo.userId}</li>
						<li><span>手机号码:</span>${userinfo.mobile}</li>
						<li><span>原来密码:</span><input type="password" name="oldPassword" id="oldPassword" class="iptxs"></li>
						<li><span>新的密码:</span><input type="password" name="newPassword" id="newPassword" class="iptxs"></li>
						<li><span>确认新的密码:</span><input type="password" name="confirmPwd" id="confirmPwd" class="iptxs"></li>
						<li><span>&nbsp;</span><a class="kaoshi_btn" href="javascript:void(0);" onclick="updPwd('${userinfo.userId}');">修改密码</a></li>
					</ul>
					
				</div>
			</div>
		</div>
	</body>
</html>
	