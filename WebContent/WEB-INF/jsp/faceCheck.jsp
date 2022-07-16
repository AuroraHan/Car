<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
 	<body >
		<div class="face_header">
			<div class="face_header_con"><p class="face_header_lf">车牌识别停车场管理系统</p><a class="face_header_rg" href="javascript:void(0);"><span class="headsp"><img src="${pageContext.request.contextPath }/images/icon-user.png" ></span>${userinfo.userName}</a></div>
		</div>
		<div class="face_con">
			<div class="face_content">
				<div class="face_con_left">
					<h1 class="face_con_tit">请开始车牌识别验证<p>请调整好摄像头，确保摄像头能够拍摄到车牌的位置，开始车牌识别验证</p></h1>
					<div class="face_yanzhen">
						<span>
	        			<img id="userImg" src="${faceBase64}"  width="280" height="230"/>
						<p>&nbsp;&nbsp;&nbsp;&nbsp;<input id="file1" name="file1" accept="image/*" type="file" value="上传车牌"/></p>
						</span>
						<span>
						<video id="video" style='width:100%;height:100%'></video>
						<canvas id="canvas" width="320" height="240" style="display: none;"></canvas>
						<a class="face_yanzhen_btn" id="paizhao">开始车牌识别</a>
						</span>
					</div>
					<p class="yanzhen_con">说明：请调整好摄像头，确保摄像头能够清晰拍摄到车牌号</p>
					<a class="face_login_btn" href="${pageContext.request.contextPath}/car/carInfo" >进入平台</a>
				</div>
				<div class="face_con_right"><h1 class="face_con_tit face_right_tit" >常见问题:</h1>
					<p style="margin-top:0px;">1、建议使用火狐、谷歌、Edge浏览器进行识别</p>
					<p>2、若浏览器顶部出现是否允许调用摄像头，请点击允许</p>
					<p><img src="${pageContext.request.contextPath}/images/cm.png" style="width:100%"></p>
					<p>3、提示获取摄像头失败，请检查你的摄像头是否正确</p>
					<p>4、<a href="${pageContext.request.contextPath}/fire/Firefox.exe">>>>>点击下载火狐游览器</a></p>
				</div>
			</div>
		</div>
		
		
		
		
		<script type="text/javascript">
			var isSuccess=false; //判断车牌识别是否成功
	        var video=document.getElementById("video");  
	        var context=canvas.getContext("2d");  
	
	        //进入平台
			function comein(){
				location.href="${pageContext.request.contextPath}/regUserServlet?action=list";
			}
	
	        var errocb=function(){
	            console.log("sth srong");  
	        }
	
	
	        //调用摄像头
	        if(navigator.webkitGetUserMedia){
	            navigator.webkitGetUserMedia({audio: false,video: true },function(stream){  
	                //video.src=window.URL.createObjectURL(stream);
	                video.srcObject = stream;
	                video.play();  
	            },errocb);
	        }
	        else if(navigator.mediaDevices.getUserMedia) {
	        	//var constraints = { audio: true, video: { width: 1280, height: 720 } };
	        	var constraints = {audio: false,video: true };
				navigator.mediaDevices.getUserMedia(constraints).then(function(stream) {
					//var video = document.querySelector('video');
					video.srcObject = stream;
					video.onloadedmetadata = function(e) {
						video.play();
					};
				});
			}
	        else if(navigator.getUserMedia){
	            navigator.getUserMedia({audio: false,video: true },function(stream){  
	                //video.src = window.webkitURL.createObjectURL(stream);
	                video.srcObject = stream;
	                video.play();  
	            },errocb);  
	        }
	        else {
	        	alert('你的浏览器不支持打开摄像头');
	        }
	        //显示拍照的图片
	        var viewImg = document.getElementById("userImg");
	        //上传车牌
	        document.getElementById("file1").addEventListener("change", function () {
	        	if(this.files.length==0) {
	        		return;
	        	}
	        	facefile = this.files[0];
	        	if(facefile.size>1024*1024) {
	        		alert("图片大小请控制在1M以内");
	        		return;
	        	}
	        	$("#paizhao").html("正在识别......");
	        	var reader = new FileReader();
	        	reader.onload = function( evt ){
	        		//把上传的车牌图片显示到页面的图片控件中
	        		viewImg.src = evt.target.result;
	        		 //删除字符串前的提示信息 "data:image/png;base64,"
	        		var data = evt.target.result;
	        		 //获取图片扩展名
		            var ext = data.substring(data.indexOf('/')+1,data.indexOf(';'));
		           	//$("#extname").val(ext);
					var len = 19+ext.length; //data:image/jpeg;base64,
		            var b64 = data.substring(len);
		            //data:image/jpeg;base64,
		            //$("#faceBase64").val(b64);
		            var url="${pageContext.request.contextPath }/car/paizhao";
			       	$.ajax({
			       		url:url,
			       		data:{"imageData":b64,"extName":ext},
						async:true,
						type:"POST",
						dataType:"json",
						success: function(data){
							$("#paizhao").html(data.msg);
							alert(data.msg);
						},
			       	});
			       	
	        	}
	        	reader.readAsDataURL(facefile);
	        }, false);
	        //实现拍照功能
	        document.getElementById("paizhao").addEventListener("click",function(){  
	        	$("#paizhao").html("正在识别......");
	            context.drawImage(video,0,0,320,240);
	            //
	            //将图像输出为base64压缩的字符串  默认为image/png
	            var data = canvas.toDataURL();    // returns "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAYAAACt..."
	            //console.log(data);
	            //var data = canvas.toDataURL('image/jpeg');  //returns "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAA..."
				//在图片控件中显示拍照后的图片
	            viewImg.src = data;
	            //删除字符串前的提示信息 "data:image/png;base64,"
	            var b64 = data.substring( 22 );
	            //var head = data.substring(0,20);
	            //var ext = head.substring(head.indexOf('/')+1,head.indexOf(';'));
	           
	            //$("#faceBase64").val(b64);
	           	//$("#extname").val(ext);
				var url="${pageContext.request.contextPath }/car/paizhao";
		       	$.ajax({
		       		url:url,
		       		data:{"imageData":b64,"extName":'png'},
					async:true,
					type:"POST",
					dataType:"json",
					success: function(data){
						$("#paizhao").html(data.msg);
						alert(data.msg);
					},
		       	});
	        });
	    </script>  
	</body>
</html>
 