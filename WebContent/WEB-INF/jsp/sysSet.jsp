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
			//修改系统设置
			function updSet(){
				var mianfeiTime = $('#mianfeiTime').val();
				var shoufeiTime = $('#shoufeiTime').val();
				var shoufeiMoney = $('#shoufeiMoney').val();
				if(mianfeiTime==""){
					alert("请输入免费停车时长");
					$("#mianfeiTime").focus();
					return ;
				}
				
				if(shoufeiTime==""){
					alert("请输入收费时长");
					$("#shoufeiTime").focus();
					return ;
				}
				if(shoufeiMoney==""){
					alert("请输入收费金额");
					$("#shoufeiMoney").focus();
					return ;
				}
				
				var url="${pageContext.request.contextPath}/user/updSet";
				$.post(
					url,
					{
						"mianfeiTime":mianfeiTime,
						"shoufeiTime":shoufeiTime,
						"shoufeiMoney":shoufeiMoney
					},
					function(data){
						alert(data.msg);
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
				<h2 class="exam_con_t">系统设置</h2>
					<ul>
						<li><span>免费时长（分钟）:</span><input type="text" name="mianfeiTime" id="mianfeiTime" class="iptxs" value="${sysSet.mianfeiTime}"></li>
						<li><span>收费基数（分钟）:</span><input type="text" name="newPassword" id="shoufeiTime" class="iptxs" value="${sysSet.shoufeiTime}"></li>
						<li><span>收费金额（基数）:</span><input type="text" name="shoufeiMoney" id="shoufeiMoney" class="iptxs" value="${sysSet.shoufeiMoney}"></li>
						<li><span>&nbsp;</span><a class="kaoshi_btn" href="javascript:void(0);" onclick="updSet();">修改设置</a></li>
					</ul>
				</div>
			</div>			
		</div>
	</body>
</html>
	