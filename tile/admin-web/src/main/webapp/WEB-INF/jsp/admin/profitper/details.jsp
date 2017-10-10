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
			<h5>${companyName} &nbsp;&nbsp; 结算详情&nbsp;&nbsp;</h5>
		</div>
		<div class="panel panel-default">
		   <div class="panel-body" style="padding-top:20px;">
		   		<form role="form">
		   		<input type="hidden" id="cId" name="cId" value="${cId}"/>
				   结算状态：<select id="status" name="status" style="width: 200px">
					      			<option value=" "> ---请选择--- </option>
					      			<option value="0"> 未结算  </option>
					      			<option value="1"> 申请中  </option>
					      			<option value="2"> 结算中  </option>
					      			<option value="3"> 已结算  </option>
					     </select>		
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
<script type="text/javascript" src="${basePath}profitper/propertyProfitDetails.js"></script>
<script type="text/javascript" src="${basePath}profitper/profitperDetailEdit.js"></script>
</html>