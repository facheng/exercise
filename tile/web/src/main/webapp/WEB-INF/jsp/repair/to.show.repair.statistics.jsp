<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {

	$("#period").click(function(){
		//showCalendar($(this).attr("id"));
		WdatePicker({dateFmt:'yyyy-MM'});
	});
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">报修统计</h2>
	</div>

	<div class="cont_box_wrap full-width">
		<form action="/repair/statistics" method="get" id="search_form">
			<div class="category ctop mt10">
				<div class="cate-link">
					<span>状态：</span>
					<select name="status" class="guest-num">
						<option value="-99"><f:message key="common.select"/></option>
						<c:forEach items="${statusMap}" var="smap">
							<c:if test="${smap.key == status}">
								<option value="${smap.key}" selected="selected">${smap.value}</option>
							</c:if>
							<c:if test="${smap.key != status}">
								<option value="${smap.key}">${smap.value}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="category no-border-top">
				<ul class="searchfm clearfix">
					<li><span class="zw">周期：</span><input type="text" id="period" name="period" value="${period}" readonly="readonly" class="textinput clear-data" /></li>
					<li><span>&nbsp;</span><a href="javascript:void(0);" title="查询" class="btn bntbgGreen btn-submit">查询</a></li>
				</ul>
			</div>
		</form>

		<table width="100%" class="list-table mt10">
			<colgroup>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>姓名</th>
					<th>维修总件数</th>
					<th>总分</th>
					<th>最低分</th>
					<th>最高分</th>
					<th>平均分</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${resultList}" var="result" varStatus="stat">
					<tr id="${result.workerId}">
						<td>
							<input type="checkbox" />
						</td>
						<td>${result.workerName}</td>
						<td>${result.totalCount}</td>
						<td>${result.totalScore}</td>
						<td>${result.minScore}</td>
						<td>${result.maxScore}</td>
						<td>${result.avgScore}</td>
						<td class="action">
							<a class="btn_smalls areaNumber-info" title="详情" href="/repair/statistic/${result.workerId}/detail">详情</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>


<div class="black-opacity click-disappear"></div>
