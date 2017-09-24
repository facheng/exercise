<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String rqkey = "requestPath", bakey="basePath";
	if(application.getAttribute(rqkey)==null){
		String requestPath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
		//String basePath = requestPath + "static/admin/";
		String basePath = "http://localhost:8080/static/admin/";
		application.setAttribute(rqkey, requestPath);
		application.setAttribute(bakey, basePath);
	}
%>
<link rel="stylesheet" type="text/css" href="${basePath}common/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="${basePath}common/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" type="text/css" href="${basePath}common/css/jquery.treegrid.css" />
<link rel="stylesheet" type="text/css" href="${basePath}common/css/matrix-login.css" />
<link rel="stylesheet" type="text/css" href="${basePath}common/css/matrix-style.css" />
<link rel="stylesheet" type="text/css" href="${basePath}common/css/matrix-media.css" />
<link rel="stylesheet" type="text/css" href="${basePath}common/css/select2.css" />
<link rel="stylesheet" type="text/css" href="${basePath}common/css/uniform.css" />
<link rel="stylesheet" type="text/css" href="${requestPath}font-awesome/css/font-awesome.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<!--[if IE]>
	<script src="${basePath}common/js/html5.js"></script> 
< ![endif]-->
