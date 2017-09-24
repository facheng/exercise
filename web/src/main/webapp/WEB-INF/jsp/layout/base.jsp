<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<!doctype html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>
			<c:if test="${not empty _title}">${_title}</c:if>
			<c:if test="${empty _title}"><tiles:insertAttribute name="page.title" ignore="true"/></c:if>
		</title>
		<tiles:insertAttribute name="head.css" ignore="true"/>
		<tiles:insertAttribute name="head.js" ignore="true"/>
		<tiles:insertAttribute name="custom.css" ignore="true"/>
		<tiles:insertAttribute name="custom.js" ignore="true"/>
	</head>
	<body class="<tiles:insertAttribute name="body-class" ignore="true"/>">
		<tiles:insertAttribute name="header" ignore="true"/>
		<div class="<tiles:insertAttribute name="ext-width" ignore="true"/>">
			<tiles:insertAttribute name="column-1" ignore="true"/>
			<tiles:insertAttribute name="column-2" ignore="true"/>
		</div>
	  	<tiles:insertAttribute name="footer" ignore="true"/>
	</body>
</html>


