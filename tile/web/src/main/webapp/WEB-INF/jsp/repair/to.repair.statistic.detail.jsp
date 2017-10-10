<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">报修统计</h2>
		<div class="rightNav-sub">
			<a href="javascript:history.go(-1);" title="返回" class="cur">返回</a>
		</div>
	</div>
	
	<table class="list-table mt10" id="roleList" width="100%">
		<colgroup>
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
				<th>报修内容</th>
				<th>报修人</th>
				<th>响应速度</th>
				<th>上门速度</th>
				<th>服务态度</th>
				<th>维修质量</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${resultList}" var="result" varStatus="stat">
				<tr id="${result.repairId}">
					<td>
						<input type="checkbox" />
					</td>
					<td>${result.remark}</td>
					<td>${result.residentName}</td>
					<td>${result.scoreResponse}</td>
					<td>${result.scoreDoor}</td>
					<td>${result.scoreService}</td>
					<td>${result.scoreQuality}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
</div>


