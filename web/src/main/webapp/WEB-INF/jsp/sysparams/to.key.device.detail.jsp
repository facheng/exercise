<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">设备钥匙信息</h2>
		<div class="rightNav-sub">
			<a href="/sys/params/key/device" title="返回" class="cur">返回</a>
		</div>
	</div>
   
	<div class="cont_box_wrap">
		<div class="detail-box">
			<div class="owner-tab">
				<c:if test="${empty detail}">
					该钥匙设备不存在
				</c:if>
				<c:if test="${not empty detail}">
					<h3 class="h3tit">钥匙信息</h3>
					<table width="100%" class="inv-table detail-table" style="width:100%;">
						<tbody>
							<tr>
								<th><label>钥匙名称：</label></th>
								<td>${detail.keyName}</td>
							</tr>
							<tr>
								<th><label>钥匙类型：</label></th>
								<td>${detail.keyTypeName}</td>
							</tr>
							<tr>
								<th><label>设备名称：</label></th>
								<td>${detail.deviceName}</td>
							</tr>
							<tr>
								<th><label>设备类型：</label></th>
								<td>${detail.deviceTypeName}</td>
							</tr>
							<tr>
								<th><label>设备UUID：</label></th>
								<td>${detail.uuid}</td>
							</tr>
							<tr>
								<th><label>设备地址：</label></th>
								<td>${detail.address}</td>
							</tr>
							<tr>
								<th><label>楼栋编号：</label></th>
								<td>${detail.storyNo}</td>
							</tr>
							<tr>
								<th><label>所在区块：</label></th>
								<td>${detail.partitionNo}</td>
							</tr>
							<tr>
								<th><label>备注：</label></th>
								<td>${detail.remark}</td>
							</tr>
						</tbody>
					</table>
				</c:if>
			</div>
		</div>
	</div>
</div>




