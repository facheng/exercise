<%@page trimDirectiveWhitespaces="true"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	//查询
	$(".search-pout").on("click", function(){
		var status = $("#status-slt").val();

		if(status != "") {
			location.href = "/admin/profit/list?status=" + status;
		} else {
			location.href = "/admin/profit/list";
		}
		$('.black-opacity').fadeIn();
	});


	//弹出“申请结算”确认提示
	$(".apply-profit-btn").on("click", function(){
		var balanceOutId = $(this).closest("tr").attr("id");
		$("#balanceOutId").val(balanceOutId);
		$('.dialog-confirm-alert, .black-opacity').fadeIn();
	});
	
	//查看详细
	$(".detail-profit-btn").on("click", function(){
		var balanceOutId = $(this).closest("tr").attr("id");
		window.location.href = "/admin/profit/rec/"+balanceOutId+"/unitprofit";
		$('.black-opacity').fadeIn();
	});

	//提交“申请结算”
	$('[js="applyProfit"]').on("click", function(){
		var balanceOutId = $("#balanceOutId").val();
		$('.dialog-confirm-alert').fadeOut();
		$('.black-opacity').fadeIn();
		
		$.ajax({
			url: "/admin/profit/out/" + balanceOutId + "/apply",
			type: "post",
			data: {"_method": "put"},
			dateType: "text",
			success: function(data){
                if(data == 1) {
					location.href = location.href;
                } else {
            		$('.black-opacity').fadeOut();
                    alert('只能申请“未结算”状态的记录！');
                }
			},
		    error: function(){
        		$('.black-opacity').fadeOut();
                alert('接口调用失败！');
            }
		});
		return false;
	});
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">物业结算</h2>
		<div class="addbtn"></div>
	</div>

	<div class="cont_box_wrap">
		<div class="category ctop mt10">
			<ul class="searchfm clear">
				<li>
					<span class="zw">状态：</span>
					<select id="status-slt" class="guest-num" style="height:32px;">
						<option value="">全部</option>
						<c:forEach items="${statusMap}" var="sta">
							<option <c:if test="${sta.key == status}">selected="selected"</c:if> value="${sta.key}">${sta.value}</option>
						</c:forEach>
					</select>
				</li>
				<li>
					<span>&nbsp;</span>
					<a href="javascript:void(0);" title="查询" class="btn bntbgGreen search-pout">查询</a>
				</li>
			</ul>
		</div>
		
		<table width="100%" class="list-table mt10">
			<colgroup>
				<col width="3%">
				<col width="5%">
				<col width="18%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="9%">
				<col width="25%">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>序号</th>
					<th>电商名称</th>
					<th>开始时间</th>
					<th>结束时间</th>
					<th>消费金额</th>
					<th>反润总金额</th>
					<th>反润金额</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:if test="${not empty resultList}">
				<tbody>
					<c:forEach items="${resultList}" var="result" varStatus="p">
						 <tr id="${result.id}">
							<td><input type="checkbox" /></td>
						    <td>${p.count}</td>
						    <td>${result.ecomName}</td>
						    <td>${result.startTime}</td>
						    <td>${result.endTime}</td>
			                <td>${result.consumeAmount}</td>
			                <td>${result.totalProfitAmount}</td>
			                <td>${result.profitAmount}</td>
						    <td>${result.statusName}</td>
			                <td>
			                	<!--btn-success bntbgBrown btn-primary btn-warning-->
			                	<c:if test="${result.status == 0}">
			                		<a class="btn_smalls btn-success apply-profit-btn" href="javascript:void(0);">申请结算</a>
			                	</c:if>
			                	<c:if test="${result.isDetail == 1}">
			                		<a class="btn_smalls areaNumber-info  detail-profit-btn" href="javascript:void(0);">详情</a>
			                	</c:if>
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



<div class="dialog dialog-confirm-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定提交申请？</p>
        </div>
        <div class="winBtnBox mt20">
        	<input type="hidden" id="balanceOutId" value=""/>
            <a href="javascript:void(0);" title="确定" js="applyProfit" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity click-disappear"></div>

