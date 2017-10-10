<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">快递消息详情</h2>
		<div class="rightNav-sub">
			<a href="/info/delivery/list" title="返回" class="cur">返回</a>
			<a href="/info/delivery?id=${deliveryId}" title="修改快递信息">修改快递信息</a>
		</div>
	</div>
	
	<div class="cont_box_wrap">
		<div class="detail-box">
			<div class="owner-tab">
				<h3 class="h3tit">快递消息详情</h3>
				<c:if test="${empty map}">
					快递消息不存在
				</c:if>
				<c:if test="${not empty map}">
					<table width="100%" class="inv-table detail-table" style="width:100%;">
						<tbody>
							<tr>
								<th><label>发送人：</label></th>
								<td>${map.createUserName}</td>
							</tr>
							<tr>
								<th><label>发送房屋：</label></th>
								<td>${map.houseNo}</td>
							</tr>
							<tr>
								<th><label>签收人：</label></th>
								<td>${map.receiverName}</td>
							</tr>
							<tr>
								<th><label>消息标题：</label></th>
								<td>${map.title}</td>
							</tr>
							<tr>
								<th><label>消息内容：</label></th>
								<td>${map.content}</td>
							</tr>
						</tbody>
					</table>
				</c:if>
			</div>
		</div>
	</div>
</div>




