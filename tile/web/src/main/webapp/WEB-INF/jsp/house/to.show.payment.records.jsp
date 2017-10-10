<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
function submitForm(){
	//检查时间条件
	var timeType = "";
	$(".time-flag-type").each(function(){
		if($(this).hasClass("cur")) {
			timeType = $(this).attr("value");
			return;
		}
	});

	if(timeType == "") {
		$("#time_flag_hidden").val("1");
		$("#time_start_hidden").val($.trim($("#time_start").val()));
		$("#time_end_hidden").val($.trim($("#time_end").val()));
		$("#time_type_hidden").val("");
	} else {
		$("#time_flag_hidden").val("2");
		$("#time_start_hidden").val("");
		$("#time_end_hidden").val("");
		$("#time_type_hidden").val(timeType);
	}

	//检查报修状态
	var status = "";
	$(".s_status").each(function(){
		if($(this).hasClass("cur")) {
			status = $(this).attr("value");
			return;
		}
	});
	$("#status_hidden").val(status);
	$("#search_form").submit();
}

$(document).ready(function() {
	$(".btn-submit").on("click", submitForm);

	//如果用户选择具体时间段，则时间类型("今天"，"最近。。。。")失效
	$("#time_start, #time_end").on("click", function(){
		$(".time-flag-type").each(function(){
			$(this).removeClass('cur');
		});
		WdatePicker();
	});
	
	//查询时间若是选择了时间类型("今天"，"最近。。。。")
	$(".time-flag-type").on("click", function(){
		var atag = $(this);
		atag.closest("span").find('.time-flag-type').each(function(){
			$(this).removeClass('cur');
		});
		atag.addClass('cur');
		submitForm();
	});

	$(".s_status").on("click", function(){
		var atag = $(this);
		atag.closest("div").find('.s_status').each(function(){
			$(this).removeClass('cur');
		});
		atag.addClass('cur');
		submitForm();
	});
	
	$('.update-bill-status-jf').on('click', function(){
		var pcId = $(this).closest("tr").attr("id");
		$(".dialog-update-bill-status").attr("params", pcId);
		$(".dialog-update-bill-status").attr("opt", "jf");
		$('.dialog-update-bill-status, .black-opacity').fadeIn();
	});
	
	$('.update-bill-status-kp').on('click', function(){
		var pcId = $(this).closest("tr").attr("id");
		$(".dialog-update-bill-status").attr("params", pcId);
		$(".dialog-update-bill-status").attr("opt", "kp");
		$('.dialog-update-bill-status, .black-opacity').fadeIn();
	});
	
	$('.update-bill-status-batch-jf').on('click', function(){
		if($('#data-list-table td input[type="checkbox"]:checked').length == 0) {
			alert("请至少选择一条记录");
			return false;
		}

		var checkedNum = "";
		$('#data-list-table td input[type="checkbox"]:checked').each(function(i){
			checkedNum += $(this).closest('tr').attr("id") + ',';
			return(checkedNum);
		});
		var pcIds = checkedNum.substring(0, checkedNum.length - 1);
		
		$(".dialog-update-bill-status").attr("params", pcIds);
		$(".dialog-update-bill-status").attr("opt", "jf");
		$('.dialog-update-bill-status, .black-opacity').fadeIn();
	});
	
	$('.update-bill-status-batch-kp').on('click', function(){
		if($('#data-list-table td input[type="checkbox"]:checked').length == 0) {
			alert("请至少选择一条记录");
			return false;
		}

		var checkedNum = "";
		$('#data-list-table td input[type="checkbox"]:checked').each(function(i){
			checkedNum += $(this).closest('tr').attr("id") + ',';
			return(checkedNum);
		});
		var pcIds = checkedNum.substring(0, checkedNum.length - 1);
		
		$(".dialog-update-bill-status").attr("params", pcIds);
		$(".dialog-update-bill-status").attr("opt", "kp");
		$('.dialog-update-bill-status, .black-opacity').fadeIn();
	});
	
	
	
	
	$('[js="updateBillStatus"]').click(function(){
		var pcIds = $(this).closest(".dialog-update-bill-status").attr("params");
		var opt = $(this).closest(".dialog-update-bill-status").attr("opt");
		var tag = $(this);
		tag.attr("disabled", "disabled");
		$.ajax({
			url: "/house/payment/new/status",
            type: "post",
            data: {"pcIds": pcIds , "opt":opt},
            dataType: "text",
            success: function(data){
                if(data == 1) {
					location.href = location.href;
                } else {
                    alert('接口调用失败！');
                	return false;
                }
		    },
		    error: function () {
                alert('接口调用失败！');
            }
		});
		return false;
	});
	

	$('.send-bill-notice').on('click', function(){
		if($('#data-list-table td input[type="checkbox"]:checked').length == 0) {
			alert("请至少选择一条记录");
			return false;
		}

		var checkedNum = "";
		$('#data-list-table td input[type="checkbox"]:checked').each(function(i){
			checkedNum += $(this).closest('tr').attr("id") + ',';
			return(checkedNum);
		});
		var pcIds = checkedNum.substring(0, checkedNum.length - 1);
		
		$(".dialog-send-bill-notice").attr("params", pcIds);
		$('.dialog-send-bill-notice, .black-opacity').fadeIn();
	});
	
	
	$('[js="sendBillNotice"]').click(function(){
		var pcIds = $(this).closest(".dialog-send-bill-notice").attr("params");
		var tag = $(this);
		tag.attr("disabled", "disabled");
		$.ajax({
			url: "/house/payment/notice",
            type: "post",
            data: {"pcIds": pcIds},
            dataType: "text",
            success: function(data){
                if(data == 1) {
					location.href = location.href;
                } else {
                    alert('接口调用失败！');
                	return false;
                }
		    },
		    error: function () {
                alert('接口调用失败！');
            }
		});
		return false;
	});
	
});
</script>

<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">缴费管理</h2>
	</div>
  
	<div class="cont_box_wrap full-width">
		<form action="/house/payment" method="get" id="search_form">
		<div class="category ctop mt10">
				<div class="cate-link">
					<b>起止日期：</b> 
					<input value="${pbSearchVo.timeStart}" class="timeinput clear-data" id="time_start" readonly="readonly" /> - 
					<input value="${pbSearchVo.timeEnd}" class="timeinput clear-data" id="time_end" readonly="readonly" />
					<span class="quick-link-date">
						<a href="javascript:void(0);" value="1" title="今天" id="time_today" class='time-flag-type <c:if test="${pbSearchVo.timeFlag == 2 and pbSearchVo.timeType == 1}">cur</c:if>'>今天</a>
						<a href="javascript:void(0);" value="2" title="最近10天" id="time_days10" class='time-flag-type <c:if test="${pbSearchVo.timeFlag == 2 and pbSearchVo.timeType == 2}">cur</c:if>'>最近10天</a>
						<a href="javascript:void(0);" value="3" title="最近1个月" id="time_months1" class='time-flag-type <c:if test="${pbSearchVo.timeFlag == 2 and pbSearchVo.timeType == 3}">cur</c:if>'>最近1个月</a>
						<a href="javascript:void(0);" value="4" title="最近3个月" id="time_months3" class='time-flag-type <c:if test="${pbSearchVo.timeFlag == 2 and pbSearchVo.timeType == 4}">cur</c:if>'>最近3个月</a>	
						<a href="javascript:void(0);" value="0" title="不限" id="time_all" class='time-flag-type <c:if test="${pbSearchVo.timeFlag == 2 and pbSearchVo.timeType == 0}">cur</c:if>'>不限</a>					
					</span>
					<input type="hidden" id="time_flag_hidden" name="timeFlag" value=""/>
					<input type="hidden" id="time_start_hidden" name="timeStart" value=""/>
					<input type="hidden" id="time_end_hidden" name="timeEnd" value=""/>
					<input type="hidden" id="time_type_hidden" name="timeType" value=""/>
				</div>
		</div>
			
			<div class="category no-border-top">
					<div class="cate-link">
					<span>缴费状态：</span>
					<a href="javascript:void(0);" title="全部" class="s_status <c:if test="${empty pbSearchVo.status}">cur</c:if>">全部</a>
					<a href="javascript:void(0);" value="0" title="未缴费" class="s_status <c:if test="${pbSearchVo.status == 0}">cur</c:if>">未缴费</a>
					<a href="javascript:void(0);" value="1" title="已缴费" class="s_status <c:if test="${pbSearchVo.status == 1}">cur</c:if>">已缴费</a>
					<a href="javascript:void(0);" value="2" title="已开发票" class="s_status <c:if test="${pbSearchVo.status == 2}">cur</c:if>">已开发票</a>
					<input type="hidden" name="status" id="status_hidden">
				</div>
			</div>
			<div class="category no-border-top">
				<ul class="searchfm clear">
					<li><span class="zw">房屋编号(室)：</span><input type="text" class="textinput" id="roomNum" name="roomNum" value="${pbSearchVo.roomNum}" placeholder="房屋编号"></li>
					<li><span>&nbsp;</span>
					<a href="javascript:void(0);" title="查询" class="btn bntbgGreen btn-submit">查询</a>
					</li>
					<li>
						<span>&nbsp;</span>
						<a href="javascript:void(0);" title="批量缴费" opt ="jf" class="btn btnbgViolet update-bill-status-batch-jf">批量缴费</a>
					</li>
					<li>
						<span>&nbsp;</span>
						<a href="javascript:void(0);" title="批量开票" opt ="kp" class="btn btnbgViolet update-bill-status-batch-kp">批量开票</a>
					</li>
					
					<li>
						<span>&nbsp;</span>
						<a href="javascript:void(0);" title="发送缴费通知" class="btn btnbgViolet send-bill-notice">发送缴费通知</a>
					</li>
				</ul>
			</div>
		</form>
	
		<table width="100%" class="list-table mt10" id="data-list-table">
			<colgroup>
				<col width="5%">
				<col width="5%">
				<col width="8%">
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="10%">
				<col width="">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>序号</th>
					<th>门牌号</th>
					<th>起始日期</th>
					<th>截止日期</th>
					<th>账单日期</th>
					<th>催缴次数</th>
					<th>金额</th>
					<th>缴费状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:if test="${not empty propertyChargeList}">
				<tbody>
					<c:forEach var="pcl" items="${propertyChargeList}" varStatus="index">
						<tr id="${pcl.id}">
							<td><input type="checkbox" /></td>
							<td>${index.count}</td>
							<td>${pcl.roomNum}</td>
							<td>${pcl.startDate}</td>
							<td>${pcl.endDate}</td>
							<td>${pcl.createtime}</td>
							<td>${pcl.remindTimes}</td>
							<td>${pcl.amount}</td>
							<td>
								<c:if test="${pcl.status == 0}">
									未缴费
								</c:if>
								<c:if test="${pcl.status == 1}">
									已缴费
								</c:if>
								<c:if test="${pcl.status == 2}">
									已开发票
								</c:if>
							</td>
							
							<td class="action">
								<c:if test="${pcl.status == 0}">
									 <a class="btn_smalls btn-warning update-bill-status-jf" opt ="jf" href="javascript:void(0);">缴费</a>
								</c:if>
								<c:if test="${pcl.status == 1}">
									 <a class="btn_smalls btn-warning update-bill-status-kp" opt ="kp" href="javascript:void(0);">开票</a>
								</c:if>
							</td>
							
						</tr>
					</c:forEach>
				</tbody>
			</c:if>
			<c:if test="${empty propertyChargeList}">
				<tr>
					<td colspan="10"><h3 class="clearfix mt10" style="text-align:center;"> 没有结果！</h3></td>
				</tr>
			</c:if>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>

<!--更新-->
<div class="dialog dialog-update-bill-status" params="" opt="">
    <div class="dialog-container ">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确认更新缴费状态？</p>
        </div>
        <div class="winBtnBox mt20">
            <a href="javascript:void(0);" title="确定" js="updateBillStatus" class="btn bntbgBrown dialog-confirm-btn">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<!--更新-->

<!--更新-->
<div class="dialog dialog-send-bill-notice" params="">
    <div class="dialog-container ">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确认发送缴费通知？</p>
        </div>
        <div class="winBtnBox mt20">
            <a href="javascript:void(0);" title="确定" js="sendBillNotice" class="btn bntbgBrown dialog-confirm-btn">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<!--更新-->
<div class="black-opacity click-disappear"></div>

