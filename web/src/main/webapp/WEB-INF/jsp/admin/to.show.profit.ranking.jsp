<%@page trimDirectiveWhitespaces="true"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">住户消费排名</h2>
		<div class="rightNav-sub">
			<a href="javascript:history.go(-1);" title="返回" class="cur">返回</a>
		</div>
	</div>

	<div class="cont_box_wrap">
		
		<table width="100%" class="list-table mt10">
			<colgroup>
				<col width="20%">
				<col width="30%">
				<col width="25%">
				<col width="25%">
			</colgroup>
			<thead>
				<tr>
					<th>名次</th>
					<th>住户姓名</th>
					<th>手机号</th>
					<th>消费金额</th>
				</tr>
			</thead>
			<c:if test="${not empty resultList}">
				<tbody>
					<c:forEach items="${resultList}" var="result" varStatus="p">
						 <tr id="${result.id}">
						    <td>${p.count}</td>
						    <td>${result.userName}</td>
						    <td>${result.phoneNum}</td>
			                <td>${result.consumeAmount}</td>
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

