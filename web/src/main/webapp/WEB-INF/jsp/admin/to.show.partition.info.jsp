<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>

<script type="text/javascript">
	
	
</script>

	<div class="rightCon">
		<div class="rightNav">
			<h2 class="titIcon wyIcon">小区期数信息</h2>
			
			<c:if test="${empty unitPartition}">
				<div class="rightNav-sub">
				<a href="/admin/unit/list" title="返回" class="cur">返回</a>
				</div>
			</c:if>
			
			<c:if test="${not empty unitPartition}">
				<div class="rightNav-sub">
				<a href="/admin/partition/list?unitId=${unitPartition.unitId}" title="返回" class="cur">返回</a>
				</div>
			</c:if>
		
		</div>		
		<div class="detail-box">			
			<div class="owner-tab">
			<c:if test="${empty unitPartition}">
					没有期数信息
			</c:if>
			<c:if test="${not empty unitPartition}">
				<h3 class="h3tit">小区期数信息</h3>
				<table style="widht:100%" class="inv-table detail-table">
					<tbody>
						<tr>
							<th><label>小区名称</label></th>
							<td>${unitPartition.unitName}</td>
						</tr>
						
						<tr>
							<th><label>期数</label></th>
							<td>${unitPartition.partitionName}</td>
						</tr>
						
						<tr>
							<th><label>别名</label></th>
							<td>${unitPartition.aliasName}</td>
						</tr>
							
						<tr>
							<th><label>备注</label></th>
							<td>${unitPartition.remark}</td>
						</tr>
					</tbody>
				</table>
				</c:if>
			</div>
		</div>
	</div>
