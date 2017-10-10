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

	//检查报修类型
	var repairType = "";
	$(".repair-type").each(function(){
		if($(this).hasClass("cur")) {
			repairType = $(this).attr("value");
			return;
		}
	});
	$("#repair_type_hidden").val(repairType);

	//检查维修类型
	var serviceType = "";
	$(".service-type").each(function(){
		if($(this).hasClass("cur")) {
			serviceType = $(this).attr("value");
			return;
		}
	});
	$("#service_type_hidden").val(serviceType);

	//检查片区
	var unitPartitionId = "";
	$(".unit-partition").each(function(){
		if($(this).hasClass("cur")) {
			unitPartitionId = $(this).attr("value");
			return;
		}
	});
	$("#unit_partition_hidden").val(unitPartitionId);

	//检查报修状态
	var statusId = "";
	$(".r-status").each(function(){
		if($(this).hasClass("cur")) {
			statusId = $(this).attr("value");
			return;
		}
	});
	$("#status_hidden").val(statusId);

	//检查紧急程度
	var urgentState = "";
	$(".urgent-state").each(function(){
		if($(this).hasClass("cur")) {
			urgentState = $(this).attr("value");
			return;
		}
	});
	$("#urgent_state_hidden").val(urgentState);


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

	$(".repair-type").on("click", function(){
		var atag = $(this);
		atag.closest("div").find('.repair-type').each(function(){
			$(this).removeClass('cur');
		});
		atag.addClass('cur');

		submitForm();
	});

	$(".service-type").on("click", function(){
		var atag = $(this);
		atag.closest("div").find('.service-type').each(function(){
			$(this).removeClass('cur');
		});
		atag.addClass('cur');

		submitForm();
	});

	$(".unit-partition").on("click", function(){
		var atag = $(this);
		atag.closest("div").find('.unit-partition').each(function(){
			$(this).removeClass('cur');
		});
		atag.addClass('cur');

		submitForm();
	});

	$(".r-status").on("click", function(){
		var atag = $(this);
		atag.closest("div").find('.r-status').each(function(){
			$(this).removeClass('cur');
		});
		atag.addClass('cur');

		submitForm();
	});

	$(".urgent-state").on("click", function(){
		var atag = $(this);
		atag.closest("div").find('.urgent-state').each(function(){
			$(this).removeClass('cur');
		});
		atag.addClass('cur');

		submitForm();
	});
	
	$('.selectAll').click(function(){
		if ($(this).is(':checked') == true) {
			$(this).closest("table").find('td input[type="checkbox"]').attr("checked", true);
		} else {
			$(this).closest("table").find('td input[type="checkbox"]').attr("checked", false);
		}
	});


	$('.delete-repair-btn').on('click', function(){
		var repairId = $(this).closest("tr").attr("id");
		$("#repair_id").val(repairId);
		$('.dialog-repair-alert, .black-opacity').fadeIn();
	});

	$('[js="deleteRepair"]').click(function(){
		var repairId = $("#repair_id").val();

		var tag = $(this);
		$.ajax({
			url: "/repair/" + repairId,
            type: "post",
            data: {"_method": "delete"},
            dataType: "text",
            success: function(data){
                if(data == 1) {
					location.href = location.href;
                } else {
                    alert('接口调用失败(只能删除“待分派 ”、“已分派待接受 ”和“已拒绝”状态的报修)！');
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
		<h2 class="titIcon wyIcon">未分派的报修</h2>
	</div>

	<div class="cont_box_wrap full-width">
		<form action="/repair/unassigned" method="get" id="search_form">
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
			<c:if test="${not empty repairTypeList}">
				<div class="category no-border-top">
					<div class="cate-link">
						<span>报修类型：</span>
						<a href="javascript:void(0);" title="全部" class='repair-type <c:if test="${empty searchVo.repairType}">cur</c:if>'>全部</a>
						<c:forEach items="${repairTypeList}" var="rt">
							<a href="javascript:void(0);" value="${rt.key}" title="${rt.value}" class="repair-type <c:if test="${searchVo.repairType == rt.key}">cur</c:if>">${rt.value}</a>
						</c:forEach>
						<input type="hidden" id="repair_type_hidden" name="repairType" value="${searchVo.repairType}"/>
					</div>
				</div>
			</c:if>
			
			<div class="category no-border-top">
				<div class="cate-link">
					<span>维修类型：</span>
					<a href="javascript:void(0);" title="全部" class='service-type <c:if test="${empty searchVo.serviceType}">cur</c:if>'>全部</a>
					<c:forEach items="${serviceTypeList}" var="st">
						<a href="javascript:void(0);" value="${st.key}" title="${st.value}" class="service-type <c:if test="${searchVo.serviceType == st.key}">cur</c:if>">${st.value}</a>
					</c:forEach>
					<input type="hidden" id="service_type_hidden" name="serviceType" value="${searchVo.serviceType}"/>
				</div>
			</div>
			<div class="category no-border-top">
				<div class="cate-link">
					<span>片区：</span>
					<a href="javascript:void(0);" title="全部" class='unit-partition <c:if test="${empty searchVo.partitionId}">cur</c:if>'>全部</a>
					<c:forEach items="${partitionList}" var="partit">
						<a href="javascript:void(0);" value="${partit.id}" title="${partit.aliasName}" class="unit-partition <c:if test="${searchVo.partitionId == partit.id}">cur</c:if>">${partit.aliasName}</a>
					</c:forEach>
					<input type="hidden" id="unit_partition_hidden" name="partitionId" value="${searchVo.partitionId}"/>
				</div>
			</div>
			<div class="category no-border-top">
				<div class="cate-link">
					<span>报修状态：</span>
					<a href="javascript:void(0);" title="全部" class='r-status <c:if test="${empty searchVo.status}">cur</c:if>'>全部</a>
					<c:forEach items="${statusList}" var="sta">
						<a href="javascript:void(0);" value="${sta.key}" title="${sta.value}" class="r-status <c:if test="${searchVo.status == sta.key}">cur</c:if>">${sta.value}</a>
					</c:forEach>
					<input type="hidden" id="status_hidden" name="status" value="${searchVo.status}"/>
				</div>
			</div>
			<div class="category no-border-top">
				<div class="cate-link">
					<span>紧急程度：</span>
					<a href="javascript:void(0);" title="全部" class='urgent-state <c:if test="${empty searchVo.urgentState}">cur</c:if>'>全部</a>
					<c:forEach items="${urgentStateList}" var="ust">
						<a href="javascript:void(0);" value="${ust.key}" title="${ust.value}" class="urgent-state <c:if test="${searchVo.urgentState == ust.key}">cur</c:if>">${ust.value}</a>
					</c:forEach>
					<input type="hidden" id="urgent_state_hidden" name="urgentState" value="${searchVo.urgentState}"/>
				</div>
			</div>
			<div class="category no-border-top">
				<ul class="searchfm clearfix">
					<li><span class="zw">门牌号码：</span><input type="text" name="rno" value="${searchVo.rno}" placeholder="请输入门牌号" class="textinput" /></li>
					<li><span class="zw">户主姓名：</span><input type="text" name="rname" value="${searchVo.rname}" placeholder="请输入户主姓名" class="textinput" /></li>					
					<li><span>&nbsp;</span><a href="javascript:void(0);" title="查询" class="btn bntbgGreen btn-submit">查询</a></li>
				</ul>
			</div>
		</form>

		<table width="100%" class="list-table mt10">
			<colgroup>
				<col width="3%">
				<col width="3%">
				<col width="12%">
				<col width="7%">
				<col width="9%">
				<col width="12%">
				<col width="6%">
				<col width="6%">
				<col width="10%">
				<col width="10%">
				<col width="">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>序号</th>
					<th>报修地址</th>
					<th>报修人姓名</th>
					<th>报修人手机号</th>
					<th>描述</th>
					<th>报修类型</th>
					<th>状态</th>
					<th>报修时间</th>
					<th>预约时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${resultList}" var="result" varStatus="stat">
					<tr id="${result.repairId}">
						<td>
							<input type="checkbox" />
						</td>
						<td>${stat.count}</td>
						<td>${result.addr}</td>
						<td>${result.rname}</td>
						<td>${result.phoneNo}</td>
						<td>${result.remark}</td>
						<td>${result.repairTypeName}</td>
						<td>${result.statusName}</td>
						<td>${result.createTime}</td>
						<td>${result.orderTime}</td>
						<td class="action">
							<a class="btn_smalls areaNumber-info" title="查看详情" href="/repair/${result.repairId}/detail">查看详情</a>
							<a class="btn_smalls btn-primary" title="修改与分派" href="/repair/${result.repairId}">修改与分派</a>
							<a class="btn_smalls btn-warning delete-repair-btn" title="删除" href="javascript:void(0);">删除</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>

<div class="dialog dialog-repair-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定删除报修？</p>
        </div>
        <div class="winBtnBox mt20">
        	<input type="hidden" id="repair_id" value=""/>
            <a href="javascript:void(0);" title="确定" js="deleteRepair" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity click-disappear"></div>