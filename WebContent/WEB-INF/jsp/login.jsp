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
    	var isSuccess=false;
		function toLogin(){
			var code = $("#loginName").val();
			var pwd = $("#password").val();
			var randCode = $("#randCode").val();
			if(code==""||pwd==""||randCode=="") {
				alert("请填写完整用户名，密码和验证码");
				return false;
			}
			$("#loginForm").submit();
			return true;
		}
		function refresh(){
			document.getElementById("codes").src= '${pageContext.request.contextPath }/enimg.jsp?'+Math.random();
		}
		if("${msg}"!=null&&"${msg}".length>0){
			alert("${msg}");
		}
	</script>
  </head>
<body>
<div class="login_b">
	<div class="header"><!--<div class="header_logo"><img src="images/logo.png" width="140" height="47"></div> -->
	<p class="header_con">车牌识别停车场管理系统</p>
</div>
<div class="lgn_bx">
	<div class="login_con">
		<div class="lgn_con">
			<div class="login_con_bx">
				<div class="login_tit">用户登录</div>
					<div class="login_con_bx_t"><span>账号登录</span></div>
					<div>
						<ul class="login_con_bx_bl">
				  			<form action="${pageContext.request.contextPath}/user/login" id="loginForm" method="post">
								<li style="cursor: hand">
									<span style="cursor: hand"><img src="${pageContext.request.contextPath}/images/login_icon02.png" /></span>
									<div class="lgtel">
										<input type="text" name="loginName" id="loginName" placeholder="请输入您的账号" class="telbt" onfocus="clearvalue(this);"/>
									</div>
								</li>
								<li>
									<span ><img src="${pageContext.request.contextPath}/images/login_icon01.png" /></span>
									<div class="lgtel">
										<input type="password" name="password" id="password" placeholder="请输入密码" class="telbt" onfocus="clearvalue(this);"/>
									</div>
								</li>
								<li style="border:none">
									<div class="lgtel" style="width:50%;border:1px solid #B7B7B7;">
					  					<input type="text" name="randCode" id="randCode" placeholder="输入图形验证码" class="telbt" onfocus="clearvalue(this);" style="width:120px;">
					  				</div>
					  				<div class="rzm_btn">
					  					<img src="${pageContext.request.contextPath }/enimg.jsp" width="70" height="42" id="codes" align="top" alt="点击换一张"  onclick="refresh();">
					  				</div>
								</li>	      
					            <li  style="border:none; background:none">
							    	<a class="login_btn" href="javascript:void(0);" onclick="toLogin();">登录</a>
								</li>
				              	<p class="help_con"><!--<a class="sp1">登录帮助</a> --><a class="sp2" href="${pageContext.request.contextPath}/user/reg">用户注册</a></p>
				              	<p>&nbsp;</p>
							</form>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
