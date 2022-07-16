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
				<form name="form1" action="${pageContext.request.contextPath }/car/stopCar" method="post">
				<h2 class="exam_con_t">
					<a href="javascript:void(0)">停车信息</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					入场时间<input type="date" name="inTime" id="inTime" style="height:30px;width:120px" value="${carVo.inTime}"/>
					到<input type="date" name="outTime" id="outTime" style="height:30px;width:120px" value="${carVo.outTime}"/>
					<input type="text" name="cardNo" id="cardNo" style="height:30px;width:200px" value="${carVo.cardNo}"/>
					<input type="submit"  value=" 查 找  "  style="height:30px;width:100px">
				</h2>
				</form>
				<table  cellspacing="0" border="1" class="kaoshi_table">
					<tr height="30">
						<td><a href="${pageContext.request.contextPath}/car/stopCar?cur_page=1">首页</a></td>
						<td><a href="${pageContext.request.contextPath}/car/stopCar?cur_page=${pager.cur_page-1}">上一页</a></td>
						<td><a href="${pageContext.request.contextPath}/car/stopCar?cur_page=${pager.cur_page+1}">下一页</a></td>
						<td><a href="${pageContext.request.contextPath}/car/stopCar?cur_page=${pager.pageCount}">末页</a></td>
						<td>当前${pager.cur_page}/共${pager.pageCount}页</td>
						<td>总记录数${pager.totalRows}</td>
					</tr>
				</table>
				<table  cellspacing="0" border="1" class="kaoshi_table">
				  <tr style="font-weight:bold" >
				    <td height="30">车牌号码</td>
				    <td>入场时间</td>
				    <td>出场时间</td>
				    <td>收费金额</td>
				    <td>收费类别</td>
				    <td>车辆状态</td>
				    <td>收费员</td>
				    <td>入场图片</td>
				    <td>出场图片</td>
				  </tr>
				  <c:forEach items="${carList}" var="d">
					  <tr>
					    <td height="30">${d.cardNo }</td>
					    <td>${d.inTime }</td>
					    <td>${d.outTime }</td>
					    <td>${d.carFee }</td>
					    <td>
					    <c:if test="${d.financeType==1}">停车</c:if>
					    <c:if test="${d.financeType==2}">停车</c:if>
					    </td>
					    <td>
					    <c:if test="${d.status==0}">未出场</c:if>
					    <c:if test="${d.status==1}">临时车出场</c:if>
					    <c:if test="${d.status==2}">包月车出场</c:if>
					    </td>
					    <td>${d.userName}</td>
					    <td><img src="${pageContext.request.contextPath }/attached/face/${d.inPic}" height="50px"></td>
					    <td><img src="${pageContext.request.contextPath }/attached/face/${d.outPic}" height="50px"></td>
					  </tr>
				  </c:forEach>
				</table>
			</div>
		</div>
	</body>
</html>
	