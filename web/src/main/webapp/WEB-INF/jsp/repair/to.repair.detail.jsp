<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">报修详情</h2>
		<div class="rightNav-sub">
			<a href="javascript:history.go(-1);" title="返回" class="cur">返回</a>
			<c:if test="${map.canAssign == 1}">
				<a href="/repair/${id}" title="修改与分派">修改与分派</a>
			</c:if>
		</div>
	</div>
	
	<div class="cont_box_wrap">
		<div class="detail-box">
			<div class="owner-tab">
				<c:if test="${empty map}">
					报修信息不存在
				</c:if>
				<c:if test="${not empty map}">
					<h3 class="h3tit">基本信息</h3>
					<table width="100%" class="inv-table detail-table" style="width:100%;">
						<tbody>
							<tr>
								<th><label>报修人姓名：</label></th>
								<td>${map.rname}</td>
							</tr>
							<tr>
								<th><label>报修人电话：</label></th>
								<td class="tel">${map.phoneNo}</td>
							</tr>
							<tr>
								<th><label>报修类型：</label></th>
								<td>${map.repairTypeName}</td>
							</tr>
							<tr>
								<th><label>维修类型：</label></th>
								<td><p>${map.serviceTypeName}</p></td>
							</tr>
							<tr>
								<th><label>报修时间：</label></th>
								<td class="date"><p>${map.createTime}</p></td>
							</tr>
							<tr>
								<th><label>预约时间：</label></th>
								<td class="date"><p>${map.orderTime}</p></td>
							</tr>
							<tr>
								<th><label>报修地址：</label></th>
								<td><p>${map.addr}</p></td>
							</tr>
							<tr>
								<th><label>报修描述：</label></th>
								<td><p>${map.remark}</p></td>
							</tr>
							<tr>
								<th><label>报修状态：</label></th>
								<td><p>${map.statusName}</p></td>
							</tr>
							<c:if test="${not empty map.pictures}">
								<tr>
									<th><label>图片：</label></th>
									<td>
										<c:forEach items="${map.pictures}" var="pict">
											<a href="${pict.accessUrl}" target="_blank"><img src="${pict.accessUrl}" width="180px;" /></a>
										</c:forEach>
									</td>
								</tr>
							</c:if>
						</tbody>
					</table>
					
					<c:if test="${not empty map.progressList}">
						<div class="astimate">
							<h3 class="h3tit mt10">处理进度</h3>
							<c:forEach items="${map.progressList}" var="prog">
								<dl class="mt10 wx-flow">
									<dt>${prog.statusName}</dt>
									<dd>
										<span>${prog.createDateTimeStr}</span>
										<span>${prog.remark}</span>
										<c:if test="${not empty prog.accessUrl}">
											<span class="repair-progess-img"><a href="${prog.accessUrl}" target="_blank">照片</a></span>
										</c:if>
									</dd>
								</dl>
							</c:forEach>
						</div>
					</c:if>
					
					<c:if test="${map.isScored == 1}">
						<div class="astimate">
							<h3 class="h3tit mt10">报修评价</h3>
							<dl class="star clearfix mt20">
								<dt>响应速度：</dt>
								<dd class="appraiseShow appraiseBig">
									<i class="icon-star <c:if test='${map.scoreResponse >= 1}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreResponse >= 2}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreResponse >= 3}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreResponse >= 4}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreResponse >= 5}'>lighten</c:if>"></i>
								</dd>
							</dl>
							<dl class="star clearfix mt20">
								<dt>上门速度：</dt>
								<dd class="appraiseShow appraiseBig">
									<i class="icon-star <c:if test='${map.scoreDoor >= 1}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreDoor >= 2}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreDoor >= 3}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreDoor >= 4}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreDoor >= 5}'>lighten</c:if>"></i>
								</dd>
							</dl>
							<dl class="star clearfix mt20">
								<dt>服务态度：</dt>
								<dd class="appraiseShow appraiseBig">
									<i class="icon-star <c:if test='${map.scoreService >= 1}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreService >= 2}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreService >= 3}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreService >= 4}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreService >= 5}'>lighten</c:if>"></i>
								</dd>
							</dl>
							<dl class="star clearfix mt20">
								<dt>维修质量：</dt>
								<dd class="appraiseShow appraiseBig">
									<i class="icon-star <c:if test='${map.scoreQuality >= 1}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreQuality >= 2}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreQuality >= 3}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreQuality >= 4}'>lighten</c:if>"></i>
									<i class="icon-star <c:if test='${map.scoreQuality >= 5}'>lighten</c:if>"></i>
								</dd>
							</dl>
						</div>
					</c:if>
					
				</c:if>
			</div>
		</div>
	</div>
</div>