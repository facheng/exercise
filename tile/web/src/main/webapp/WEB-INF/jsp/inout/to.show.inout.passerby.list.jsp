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

	$("#search_form").submit();
}

function clearParams(){
	$("#residentId").attr("value",'');
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
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">行人出入统计</h2>
		<div class="addbtn">
			<a class="btn areaNumber-info" title="行人出入统计" href="/inout/passerby/statistics?timeType=1">行人出入统计</a>
		</div>
	</div>

	<div class="cont_box_wrap full-width">
		<form action="/inout/passerby" method="get" id="search_form">
			<div class="category ctop mt10">
				<div class="cate-link">
					<b>起止日期：</b> 
					<input value="${searchVo.timeStart}" class="timeinput clear-data" id="time_start" readonly="readonly" /> - 
					<input value="${searchVo.timeEnd}" class="timeinput clear-data" id="time_end" readonly="readonly" />
					<span class="quick-link-date">
						<a href="javascript:void(0);" value="1" title="今天" id="time_today" class='time-flag-type <c:if test="${searchVo.timeFlag == 2 and searchVo.timeType == 1}">cur</c:if>'>今天</a>
						<a href="javascript:void(0);" value="2" title="最近10天" id="time_days10" class='time-flag-type <c:if test="${searchVo.timeFlag == 2 and searchVo.timeType == 2}">cur</c:if>'>最近10天</a>
						<a href="javascript:void(0);" value="3" title="最近1个月" id="time_months1" class='time-flag-type <c:if test="${searchVo.timeFlag == 2 and searchVo.timeType == 3}">cur</c:if>'>最近1个月</a>
						<a href="javascript:void(0);" value="4" title="最近3个月" id="time_months3" class='time-flag-type <c:if test="${searchVo.timeFlag == 2 and searchVo.timeType == 4}">cur</c:if>'>最近3个月</a>	
						<a href="javascript:void(0);" value="0" title="不限" id="time_all" class='time-flag-type <c:if test="${searchVo.timeFlag == 2 and searchVo.timeType == 0}">cur</c:if>'>不限</a>					
					</span>
					<input type="hidden" id="time_flag_hidden" name="timeFlag" value=""/>
					<input type="hidden" id="time_start_hidden" name="timeStart" value=""/>
					<input type="hidden" id="time_end_hidden" name="timeEnd" value=""/>
					<input type="hidden" id="time_type_hidden" name="timeType" value=""/>
				</div>
			</div>
			
			<div class="category no-border-top">
				<ul class="searchfm clearfix">
				<input type="hidden" name="residentId" id="residentId" value="${searchVo.residentId}" />
					<li><span class="zw">人员姓名：</span><input type="text" name="rname" value="${searchVo.rname}" placeholder="请输入人员姓名" class="textinput" onchange="clearParams();"/></li>					
					<li><span>&nbsp;</span><a href="javascript:void(0);" title="查询" class="btn bntbgGreen btn-submit">查询</a></li>
				</ul>
			</div>
		</form>

		<table width="100%" class="list-table mt10">
			<colgroup>
				<col width="5%">
				<col width="5%">
				<col width="22%">
				<col width="22%">
				<col width="23%">
				<col width="23%">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>序号</th>
					<th>人员姓名</th>
					<th>手机号码</th>
					<th>钥匙名称</th>
					<th>开门时间</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${resultList}" var="result" varStatus="stat">
					<tr id="${result.inoutId}">
						<td><input type="checkbox" /></td>
						<td>${stat.count}</td>
						<td>${result.residentName}</td>
						<td>${result.phoneNum}</td>
						<td>${result.keyName}</td>
						<td>${result.inoutTime}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>

<div class="black-opacity click-disappear"></div>

