<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>物业结算</title>
	<%@include file="/common/css.jsp" %>
</head>
<body>
	<div class="widget-box">
		<div class="widget-title">
			<span class="icon"><i class="icon-th"></i></span>
			<h5>物业结算&nbsp;&nbsp;</h5>
		</div>
		<div class="panel panel-default">
		   <div class="panel-body" style="padding-top:20px;">
		   		<form role="form">
				      物业公司：<input type="text" id="companyName" name="companyName" placeholder="请输入名称" value=""/>
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
<script type="text/javascript" src="${basePath}profitper/index.js"></script>
<script type="text/javascript" src="${basePath}profitper/profitperEdit.js"></script>
</html>