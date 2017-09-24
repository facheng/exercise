<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>



<c:if test="${not empty unitList}">
	[
	<c:forEach items="${unitList}" var="unit" varStatus="stat">
		{"id": "${unit.id}", "name": "${unit.name}"}<c:if test="${!stat.last}">,</c:if>
	</c:forEach>
	]
</c:if>