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
				<h2 class="exam_con_t">
					<a href="${pageContext.request.contextPath }/user/reg">新增</a>
				</h2>
				<table  cellspacing="0" border="1" class="kaoshi_table">
				  <tr style="font-weight:bold" >
				    <td height="30">登录名称</td>
				    <td>用户姓名</td>
				    <td>手机号码</td>
				    <td>用户状态</td>
				    <td>编辑</td>
				  </tr>
				  <c:forEach items="${userList}" var="d">
					  <tr>
					    <td height="30">${d.userId }</td>
					    <td>${d.userName }</td>
					    <td>${d.mobile }</td>
					    <td>
					    	<c:if test="${d.status==0 }">禁用</c:if>
					    	<c:if test="${d.status==1 }">启用</c:if>
					    </td>
					    <td>
					    <c:if test="${d.status==0 }">
					    	<a href="${pageContext.request.contextPath}/user/updStatus?status=1&userId=${d.userId}">启用</a>
					    </c:if>
					    <c:if test="${d.status==1 }">
					    	<a href="${pageContext.request.contextPath}/user/updStatus?status=0&userId=${d.userId}">禁用</a>
					    </c:if>
					    </td>
					  </tr>
				  </c:forEach>
				</table>
			</div>
		</div>
	</body>
</html>
	