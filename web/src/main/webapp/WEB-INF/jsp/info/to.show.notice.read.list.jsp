<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">通知已阅记录</h2>
		<div class="rightNav-sub">
			<a href="/info/notice/list" title="返回" class="cur">返回</a>
		</div>
	</div>
	<table width="100%" class="list-table mt10">
		<colgroup>
			<col width="30%">
			<col width="70%"> 
		</colgroup>
		<thead>
			<tr>
				<th>查看人</th>					
				<th>查看时间</th>
			</tr>
		</thead>
		<c:if test="${not empty mapList}">
			<tbody>
				<c:forEach items="${mapList}" var="map">
					<tr>
						<td>${map.residentName}</td>
						<td>${map.readTime}</td>
					</tr>
				</c:forEach>
			</tbody>
		</c:if>
	</table>
	<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
</div>