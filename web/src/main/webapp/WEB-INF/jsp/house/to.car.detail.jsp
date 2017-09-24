<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">车辆详情</h2>
		<div class="rightNav-sub">
			<a href="/house/car/list" title="返回" class="cur">返回</a>
		</div>
	</div>

	<div class="cont_box_wrap">                    
		<div class="detail-box">
			<div class="owner-tab">
				<c:if test="${empty map}">
					车辆信息不存在
				</c:if>
				<c:if test="${not empty map}">
					<h3 class="h3tit">车辆信息</h3>
					<table width="100%" class="inv-table detail-table" style="width:100%;">
						<tbody>
							<tr>
								<th><label>车牌号</label></th>
								<td>${map.plateNo}</td>
							</tr>
						</tbody>
					</table>
						<h3 class="h3tit mt20">车主信息</h3>
						<div class="fcInfoBox">
							<div class="fcInfoCon">
								<table width="100%" class="inv-table detail-table" style="width:100%;">
									<tbody>
										<tr>
											<th><label>车主姓名</label></th>
											<td>${map.residentName}</td>
										</tr>
										<tr>
											<th><label>身份证号</label></th>
											<td>${map.idCard}</td>
										</tr>
										<tr>
											<th><label>手机号码</label></th>
											<td>${map.phoneNum}</td>
										</tr>
									</tbody>
								</table>
		                        <div class="fcInfoBtn"></div>
							</div>
							<div class="clear"></div>
						</div>
					</c:if>
			</div>
		</div>
	</div>
</div>

<div class="black-opacity click-disappear"></div>
