<%@page trimDirectiveWhitespaces="true"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	//查询
	$(".search-pout").on("click", function(){
		var unitName = $("#unitName").val();
		var id = $("#balanceOut_id").val();

		if(unitName != "") {
			location.href = "/admin/profit/rec/"+id+"/unitprofit?unitName=" + unitName;
		} else {
			location.href = "/admin/profit/rec/"+id+"/unitprofit";
		}
		$('.black-opacity').fadeIn();
	});

});

function profitRank(obj){
	$('#ecomId').val(obj.ecomId);
	$('#unitId').val(obj.unitId);
	$('#startTime').val(obj.startTime);
	$('#endTime').val(obj.endTime);
	$('#profit_ranking_form').submit();
	$('.black-opacity').fadeIn();
}
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">物业结算详情</h2>
		<div class="addbtn"></div>
	</div>

	<div class="cont_box_wrap">
		<div class="category ctop mt10">
			<ul class="searchfm clear">
				<li>
					<span class="zw">小区名称：</span>
					<input type="text" id="unitName" name="unitName" value="${unitName}" class="textinput" placeholder="请输入小区名称"/>
					<input type="hidden" id="balanceOut_id" name="id" value="${balanceOutId}"/>
				</li>
				<li>
					<span>&nbsp;</span>
					<a href="javascript:void(0);" title="查询" class="btn bntbgGreen search-pout">查询</a>
				</li>
			</ul>
		</div>
		
		 <form action="/admin/profit/rec/residentprofit" style="display:inline" method="get" id="profit_ranking_form">
		 	<input type="hidden" name="ecomId" id="ecomId"/>
		 	<input type="hidden" name="unitId" id="unitId"/>
		 	<input type="hidden" name="startTime" id="startTime"/>
		 	<input type="hidden" name="endTime" id="endTime"/>
		 </form>
		
		<table width="100%" class="list-table mt10">
			<colgroup>
				<col width="10%">
				<col width="20%">
				<col width="20%">
				<col width="15%">
				<col width="15%">
				<col width="10%">
				<col width="15%">
			</colgroup>
			<thead>
				<tr>
					<th>序号</th>
					<th>电商名称</th>
					<th>小区名称</th>
					<th>开始时间</th>
					<th>结束时间</th>
					<th>消费金额</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:if test="${not empty resultList}">
				<tbody>
					<c:forEach items="${resultList}" var="result" varStatus="p">
						 <tr id="${result.id}">
						    <td>${p.count}</td>
						    <td>${result.ecomName}</td>
						    <td>${result.unitName}</td>
						    <td>${result.startTime}</td>
						    <td>${result.endTime}</td>
			                <td>${result.consumeAmount}</td>
			                <td>
		                		<a class="btn_smalls btn-success " onclick="profitRank({'ecomId':'${result.ecomId}','unitId':'${result.unitId }','startTime':'${result.startTime }','endTime':'${result.endTime }'})" href="javascript:void(0);">消费排名</a>
			                </td>
						 </tr>
					</c:forEach>
				</tbody>
			</c:if>
			<c:if test="${empty resultList}">
				<tr>
					<td colspan="10"><h3 class="clearfix mt10" style="text-align:center;">没有结果！</h3></td>
				</tr>
			</c:if>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>


<div class="black-opacity click-disappear"></div>

