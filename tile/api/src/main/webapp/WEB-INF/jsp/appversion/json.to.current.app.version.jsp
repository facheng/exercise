<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


{
	"status": "${map.status}",
	"msg": "${map.msg}",
	"data": {
		"forceUpdate": "${map.forceUpdate}",
		"updateUrl": "${map.updateUrl}",
		"updateContent": [
			<c:if test="${not empty map.contentList}">
				<c:forEach items="${map.contentList}" var="ctt" varStatus="stat">
					${ctt.content}<c:if test="${!stat.last}">,</c:if>
				</c:forEach>
			</c:if>
		],
		"updateVersion": "${map.updateVersion}"
	}
}
