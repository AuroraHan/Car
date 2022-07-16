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
				<form name="form1" action="${pageContext.request.contextPath }/car/finance" method="post">
				<h2 class="exam_con_t">
					<a href="javascript:void(0)">缴费记录</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" name="carNo" id="carNo" style="height:30px;width:200px"/>
					<input type="submit"  value=" 查 找  "  style="height:30px;width:100px">
				</h2>
				</form>
				<table  cellspacing="0" border="1" class="kaoshi_table">
				  <tr style="font-weight:bold" >
				    <td height="30">车牌号码</td>
				    <td>收费类型</td>
				    <td>收费金额</td>
				    <td>收费员</td>
				    <td>收费时间</td>
				    <td>备注信息</td>
				  </tr>
				  <c:forEach items="${financeList}" var="d">
					  <tr>
					    <td height="30">${d.carNo }</td>
					    <td>
					    <c:if test="${d.financeType==1}">充值</c:if>
					    <c:if test="${d.financeType==2}">停车费</c:if>
					    </td>
					    <td>${d.totalMoney }</td>
					    <td>${d.userName }</td>
					    <td><fmt:formatDate value="${d.oprTime }" pattern="yyyy-MM-dd HH:mm"/> </td>
					    <td>${d.remark }</td>
					  </tr>
				  </c:forEach>
				</table>
			</div>			
		</div>
	</body>
</html>
	