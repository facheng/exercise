<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>物业结算</title>
	<%@include file="/common/css.jsp" %>
	<%@ include file="/common/taglib.jsp" %>
	<%@include file="/common/js.jsp" %>
	<script type="text/javascript">
	$(function(){
		
		if( $('#ecomId').find('option:selected').attr('autoCalc') == '1'){
			$('#closeBalance_span').after('<button type="button" id="clearBalance_btn" title="点击自动清算" class="btn btn-success" style="height:28px">清算</button>');
		}
		
		$('#ecomId').on('change',function(){
			
			$('#consumeAmount').val("");
			$('#totalProfitAmount').val("");
			$('#profitAmount').val("");
			$('#clearBalance_btn').remove();
			var autoCalc = $(this).find('option:selected').attr('autoCalc');
			
			if(autoCalc == '1'){
				$('#closeBalance_span').after('<button type="button" id="clearBalance_btn" title="点击自动清算" class="btn btn-success" style="height:28px">清算</button>');
			} 
			
		});
		$('#clearBalance_btn').live('click',function(){
			var startTime = $('#startTime').val();
			var endTime = $('#endTime').val();
			var ecomId = $('#ecomId').val();
			var companyId = $('#companyId').val();
			
			if(startTime == null || $.trim(startTime) == ""){
				$.alert("请输入开始日期");
				return;
			}
			if(endTime == null || $.trim(endTime) == ""){
				$.alert("请输入结束日期");
				return;
			}
			if(ecomId == null || $.trim(ecomId) == ""){
				$.alert("请选择电商");
				return;
			}
			if(companyId == null || $.trim(companyId) == ""){
				$.alert("未获取物业公司");
				return;
			}
			
			$.ajax({
				url:'amounts',
				type:'POST',
				data:{"startTime":startTime,"endTime":endTime,"ecomId":ecomId,"companyId":companyId},
				dataType:'json',
				success:function(data){
					if(data){
						
						if(data.consumeAmount == null || data.profitAmount==null){
							$.alert("时间段为["+startTime+" 00:00:00]-["+endTime+" 23:59:59]未查询到已对账的交易信息");
							return;
						}
						$('#consumeAmount').val(data.consumeAmount.toFixed(2));
						$('#totalProfitAmount').val(data.profitAmount.toFixed(2));
					}
				}
			});
		});
		
	});
	
		function showprofitAmount(){
			var totalProfitAmount = document.getElementById("totalProfitAmount").value;
			var percent = document.getElementById("percent").value;
			if(totalProfitAmount != "" && totalProfitAmount > 0){
				var profitAmount = totalProfitAmount * percent;
				document.getElementById("profitAmount").value = profitAmount.toFixed(2);
			}else{
				alert("请输入消费金额！");
			}
		}
	</script>
</head>
<body>
	<div class="widget-box">
		<div class="widget-title">
			<span class="icon"> <i class="icon-align-justify"></i>
			</span>
			<h5>物业结算</h5>
		</div>
		<div class="widget-content nopadding">
			<form action="profitBalanceOutSave" method="post" class="form-horizontal" id="ProfitBalanceOutForm">
				<input type="hidden" id="id" name="id" value="${pbovo.id}"/>
				<div class="control-group">
					<label class="control-label">物业公司 :</label>
					<div class="controls">
						<input type="hidden" id="companyId" name="companyId" value="${pbovo.companyId}"/>
						<input type="text" id="companyName" name="companyName" value="${pbovo.companyName}" readonly="readonly" />
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">选择电商 :</label>
					<div class="controls">
					     <select id="ecomId" name="ecomId" style="width: 220px" class="{required:true,messages:{required:'请选择电商!'}}">
									<option value="" autoCalc=""> ---请选择--- </option>
									<c:forEach items="${peList}" var="pe">
										<option value="${pe.id}" autoCalc="${pe.autoCalculate}" <c:if test="${pe.id == pbovo.ecomId}">selected="selected"</c:if>>${ pe.ecomName}</option>
									</c:forEach>
						 </select>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">开始日期 :</label>
					<div class="controls">
						<input type="text" id="startTime" name="startTime" value="${pbovo.startTime}" class="{required:true,messages:{required:'开始日期不能为空!'}}" placeholder="开始日期包含当天" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">结束日期 :</label>
					<div class="controls">
						<input type="text" id="endTime" name="endTime" value="${pbovo.endTime}" class="{required:true,messages:{required:'结束日期不能为空!'}}" placeholder="结束日期包含当天" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">消费金额 :</label>
					<div class="controls">
						<input type="text" id="consumeAmount" name="consumeAmount" value="${pbovo.consumeAmount}" class="{required:true,messages:{required:'消费金额不能为空!'}}" placeholder="该公司所有小区消费总金额" />
						元
						<span id="closeBalance_span"></span>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">返润总金额 :</label>
					<div class="controls">
						<input type="text" id="totalProfitAmount" name="totalProfitAmount" value="${pbovo.totalProfitAmount}" class="{required:true,messages:{required:'消费金额不能为空!'}}" placeholder="该公司所有小区消费总金额" />
						
						元
					</div>
				</div>
				
				
				
				<div class="control-group">
					<label class="control-label">返润比例 :</label>
					<div class="controls">
						<input type="text" id="percent" name="percent" value="${pbovo.percent}" class="{required:true,messages:{required:'返润比例不能为空!'}}" placeholder="返润比例 ，如 0.7 即 70%" readonly="readonly"/>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">反润金额 :</label>
					<div class="controls">
						<input type="text" id="profitAmount" name="profitAmount" value="${pbovo.profitAmount}" class="{required:true,messages:{required:'返润金额不能为空!'}}" placeholder="物业公司返润金额" onmousedown="showprofitAmount();"/>
						元
					</div>
				</div>
				
				<div class="form-actions">
					<button type="submit" id="saveBtn" class="btn btn-success" >保存</button>
					<button type="button" id="backBtn" backUrl="profitperDetailIndex?cId=${pbovo.companyId}"  class="btn btn-danger">返回</button>
				</div>
			</form>
		</div>
	</div>
</body>

<script type="text/javascript" src="${basePath}profitper/profitperEdit.js"></script>
</html>