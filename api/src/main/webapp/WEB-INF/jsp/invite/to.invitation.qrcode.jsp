<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>邀约</title>
<style type="text/css">
table{
	margin:0 auto;
}
.appico{
	width:61px;
	height: 25px;
}
dt,dl{
	margin-left:5px;
	text-align: left;
}
canvas{
	border:3px solid #12a8e7;
}
</style>
<script type="text/javascript">
	$(function(){
		$(".leftnavbg").removeClass("leftnavbg");
		$("body").addClass("text-center");
		$("dt").css("width", "auto")
		$("dd").css("margin-left", "auto")
		
		$(".download").attr("href", "http://www.doubletuan.com");
	});
</script>
</head>
<body>
        <h3 class="title ui-border-b" id="logo">点击二维码<a href="" style="color:blue" class="download">下载i家园App</a><br/>
        	畅享小区精彩生活！</h3>
        <div style="color: gray;font-size: 18px;"><span><img class="appico" alt="" src="/static/images/invite/ic_msg_01.png"></span> &nbsp;&nbsp;${invitation.createTime}&nbsp;&nbsp;${invitation.userName}</div>
		<div class="ui-center" style="height:300px;padding-top: 20px;">
			<a href="" class="download"><img style="border:3px solid #12a8e7;" alt="点击下载i家园App" width="260px" height="260px;" src="${requestPath}app/qrcode?msg=${invitation.qrCode}"/></a>
		</div>
		<div class="text:left" style="font-size: 16px;">
			<dl class="dl-horizontal">
				<dt>
					<img src="/static/images/invite/ic_msg_03.png" style="width: 17px; height: 17px;"/>
					<strong>到访时间:</strong>
				</dt>
				<dd>
					<div><ins>${invitation.visitTime}</ins></div>
				</dd>
			</dl>
			<dl class="dl-horizontal">
				<dt>
					<img src="/static/images/invite/ic_msg_04.png" style="width: 17px; height: 17px;"/>
					<strong>到访地址:</strong>
				</dt>
				<dd>
					<div><ins>${invitation.visitAddress}</ins></div>
				</dd>
			</dl>
			<dl class="dl-horizontal">
				<dt>
					<img src="/static/images/invite/ic_msg_05.png" style="width: 17px; height: 17px;"/>
					<strong>消息内容:</strong>
				</dt>
				<dd>
					<div><ins>${invitation.message}</ins></div>
				</dd>
			</dl>
		</div>
		<div id="mapdiv"></div>      
</body>
</html>