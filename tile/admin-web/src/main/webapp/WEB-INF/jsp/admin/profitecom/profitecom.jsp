<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>电商详细资料</title>
	<%@include file="/common/css.jsp" %>
	<script type="text/javascript">

	$(document).ready(function() {
		
	});
	
	</script>
</head>
<body>
	<div class="widget-box">
		<div class="widget-title">
			<span class="icon"><i class="icon-th"></i></span>
			<h5>电商详细资料 </h5>
		</div>
		<div class="panel panel-default">
		   <!--<div class="panel-body" style="padding-top:20px;">
		    <form role="form">
		       	 是否领取：<select id="isReceived" name="isReceived" style="width: 200px">
					      			<option value="" > 未选择 </option>
					      			<option value="0"> 未领取  </option>
					      			<option value="1"> 已领取  </option>
					     </select>		
		   		      优惠劵编码：<input type="text" id="code" name="code" placeholder=" 优惠劵编码" value=""/>
				      领取人手机号码：<input type="text" id="phoneNum" name="phoneNum" placeholder="领取人手机号码" value=""/>
				      
				   <a href="javascript:void(0);" class="search"><i class="icon-search"></i>查询</a>
				   
				   <input type="hidden" id="typeId" name="typeId" value="${typeId}"/>
			   </form> 
		   </div>-->
		</div>
		<div class="widget-content nopadding">
			<table class="table table-bordered data-table " >
				
			</table>
		</div>
	</div>
</body>
<%@include file="/common/js.jsp" %>
<script type="text/javascript" src="${basePath}profitEcom/profitEcomEdit.js"></script>
<script type="text/javascript" src="${basePath}profitEcom/profitEcom.js"></script>
</html>