<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">

</script>


<div class="rightCon">
		<div class="rightNav">
			<h2 class="titIcon wyIcon">小区简介</h2>
		</div>
			<div class="about-box">
			<p>
				<span>小区名字：</span>
					${unitInfo.unitName}
				<br>
				
				<span>小区坐标：</span>
					经度    ： ${unitInfo.longitude}
					纬度    ： ${unitInfo.lantitude}
				<br>
				
				<span>期数信息：</span>
					<c:if test="${not empty storyCounts}">
							<c:forEach var="sc" items="${storyCounts}" varStatus="status">
								${sc.aliasName} 楼栋数 ：${sc.counts}  &nbsp;&nbsp;&nbsp;
							</c:forEach>
					</c:if>
					<c:if test="${empty storyCounts}">
							无
					</c:if>
				<br>
				
				<span>组织架构：</span>
					${unitInfo.branch}
				<br>
				
				<span>物业公司：</span>
					${unitInfo.company}
				<br>
				
				<span>小区地址：</span>
				${unitInfo.address}
				<br>
				
				<span>轨道交通：</span>
				<br>
			</p>
			
				<br>
				<br>
				<br>
			
			<p class="mt30">
				<strong  id="strongtitle">
					周边
				</strong>
				<br>
				<span id="span11">幼儿园：</span>
				<br>
				<span id="span12">中小学：</span>
				<br>
				<span id="span13">大学：</span>
				<br>
				<span id="span14">医院：</span>
				<br>
				<span id="span15">邮局：</span>
				<br>
				<span id="span16">银行：</span>
				<br>
				<span id="span17">其他：</span>
				<br>
			</p>
		</div>
</div>

	

