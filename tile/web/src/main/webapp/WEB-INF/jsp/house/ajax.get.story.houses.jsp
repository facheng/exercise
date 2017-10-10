<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>



<c:if test="${not empty trees}">
	[
	<c:forEach items="${trees}" var="node" varStatus="stat">
		{"id": "${node.id}", "pId": "${node.pId}", "name": "${node.name}", "open": "${node.open}", "valid": "${node.valid}"}<c:if test="${!stat.last}">,</c:if>
	</c:forEach>
	]
</c:if>