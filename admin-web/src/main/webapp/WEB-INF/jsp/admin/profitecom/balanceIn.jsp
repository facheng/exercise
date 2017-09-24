<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>反润结算记录</title>
	<%@include file="/common/css.jsp" %>
	<%@include file="/common/js.jsp" %>
	<script type="text/javascript">

	$(document).ready(function() {
		
	});
	
	</script>
	
</head>
<body>
	<div class="widget-box">
		<div class="widget-title">
			<span class="icon"><i class="icon-th"></i></span>
			<h5>反润结算记录</h5>
		</div>
		<div class="panel panel-default">
		   <div class="panel-body" style="padding-top:20px;">
		   <form role="form" id="consumerec_form">
		   		    对账时间：<input type="text"  id="startTime" name="startTime" placeholder="开始时间" value="${startTime }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
		   		     	-<input type="text"  id="endTime" name="endTime" placeholder="结束时间" value="${endTime }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
				       结算状态：<select id="status" name="status" style="width: 200px">
					      			<option value=" "> ---请选择--- </option>
					      			<option value="0"> 未结算  </option>
					      			<option value="1"> 结算中 </option>
					      			<option value="2"> 已结算  </option>
					     </select>		
				   <a href="javascript:void(0);" id="search_a" class="search"><i class="icon-search"></i>查询</a>
				   
				   <input type="hidden" id="ecomId" name="ecomId" value="${ecomId}"/>
			   </form>
		   </div>
		</div>
		<div class="widget-content nopadding">
			<table class="table table-bordered data-table " >
				
			</table>
		</div>
	</div>
</body>

<script type="text/javascript" src="${basePath}profitecom/profitEcomEdit.js"></script>
<script type="text/javascript" src="${basePath}profitecom/balanceIn.js"></script>
</html>