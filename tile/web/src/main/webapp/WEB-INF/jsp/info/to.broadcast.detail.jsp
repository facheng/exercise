<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">公告详情</h2>
		<div class="rightNav-sub">
			<a href="/info/broadcast/list" title="返回" class="cur">返回</a>
			<a href="/info/broadcast?id=${broadcastId}" title="修改公告信息">修改公告信息</a>
		</div>
	</div>
	
	<div class="cont_box_wrap">
		<div class="detail-box">
			<div class="owner-tab">
				<h3 class="h3tit">公告详情</h3>
				<c:if test="${empty map}">
					公告不存在
				</c:if>
				<c:if test="${not empty map}">
					<table width="100%" class="inv-table detail-table" style="width:100%;">
						<tbody>
							<tr>
								<th><label>公告类别：</label></th>
								<td>${map.typeName}</td>
							</tr>
							<tr>
								<th><label>发送人：</label></th>
								<td>${map.createUserName}</td>
							</tr>
							<tr>
								<th><label>公告标题：</label></th>
								<td>${map.title}</td>
							</tr>
							<tr>
								<th><label>公告内容：</label></th>
								<td>${map.content}</td>
							</tr>
						</tbody>
					</table>
				</c:if>
			</div>
		</div>
	</div>
</div>