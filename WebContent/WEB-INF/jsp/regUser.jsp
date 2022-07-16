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
				var userId=$("#userId").val();
				var userName = $("#userName").val();
				var mobile = $("#mobile").val();
				var password = $("#password").val();
				var confirmPwd = $("#confirmPwd").val();
				if(userId==""){
					alert("请输入登录名称,登录名称是你的身份标识，不能修改");
					$("#userId").focus();
					return;
				}			
				if(userName==""){
					alert("请输入用户名称");
					$("#userName").focus();
					return;
				}			
				if(mobile==""){
					alert("请输入手机号码");
					$("#mobile").focus();
					return;
				}			
				if(password==""){
					alert("请输入登录密码");
					$("#password").focus();
					return;
				}			
				if(confirmPwd!=password){
					alert("登录密码与确认密码不一致");
					$("#confirmPwd").focus();
					return;
				}			
				var url="${pageContext.request.contextPath }/user/reg";
		       	$.post(
		       		url,
		       		{
		       			"userId":userId,
		       			"mobile":mobile,
		       			"userName":userName,
		       			"password":password
		       		},
					function(data){
						$("#message").text(data.msg);
						alert(data.msg);
						if(data.code=="0"){
							//注册成功，返回登录界面重新登录
							location.href="${pageContext.request.contextPath }/user/login";
						}
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
				<a class="face_header_rg" href="javascript:void(0);"><span class="headsp"><img src="${pageContext.request.contextPath }/images/icon-user.png" ></span></a>
			</div>
		</div>
		<div class="exam_content">
			<div class="exam_con">
				
				<div class="person_right">
					<ul>
						<li><span>&nbsp;</span><h2>新增管理员信息</h2></li>
						<li><font color="red" id="message">&nbsp;</font></li>
						<li><span>登录名称:</span><input type="text" name="userId" id="userId" class="iptxs"></li>
						<li><span>用户姓名:</span><input type="text" name="userName" id="userName" class="iptxs"></li>
						<li><span>手机号码:</span><input type="text" name="mobile" id="mobile" class="iptxs"></li>
						<li><span>登录密码:</span><input type="password" name="password" id="password" class="iptxs"></li>
						<li><span>确认密码:</span><input type="password" name="confirmPwd" id="confirmPwd" class="iptxs"></li>
						<li><span>&nbsp;</span><a class="kaoshi_btn" href="javascript:void(0);" onclick="check();">保存</a></li>
					</ul>
					
				</div>
			</div>
		</div>
	</body>
</html>
	