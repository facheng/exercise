<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>用户意见反馈</title>
	<%@include file="/common/css.jsp" %>
</head>
<body>
	<div class="widget-box">
		<div class="widget-title">
			<span class="icon"><i class="icon-th"></i></span>
			<h5> 用户意见反馈列表   </h5>
		</div>
		<div class="panel panel-default">
		   <div class="panel-body" style="padding-top:20px;">
		   <form role="form">
		   		      反馈起始时间：<input type="text" id="startTimes" name="startTimes" placeholder="请选择起始时间" value="" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>
				      反馈结束时间：<input type="text" id="endTimes" name="endTimes" placeholder="请选择结束时间" value="" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>
				      
				   <a href="javascript:void(0);" class="search"><i class="icon-search"></i>查询</a>
			   </form>
		   </div>
		</div>
		<div class="widget-content nopadding">
			<table class="table table-bordered data-table">
				
			</table>
		</div>
	</div>
</body>
<%@include file="/common/js.jsp" %>
<script type="text/javascript" src="${basePath}defaultEdit.js"></script>
<script type="text/javascript" src="${basePath}feedback/index.js"></script>
</html>