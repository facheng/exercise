<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>后台管理系统</title>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<base href="${requestPath}">
	<%@include file="/common/css.jsp" %>
</head>
<body>
<!--Header-part-->
<div id="header">
  <h1><a href="javascript:void(0);">MatAdmin</a></h1>
</div>
<!--close-Header-part-->
<!--top-Header-menu-->
<div id="user-nav" class="navbar navbar-inverse">
  <ul class="nav">
    <li  class="dropdown" id="profile-messages" >
      <a title="" href="#" data-toggle="dropdown" data-target="#profile-messages" class="dropdown-toggle">
          <i class="icon icon-user"></i>  <span class="text">欢迎${user.userName}</span><b class="caret"></b>
      </a>
      <ul class="dropdown-menu">
        <li><a href="javascript:void(0);"><i class="icon-user"></i>${user.userName}的资料</a></li>
        <li class="divider"></li>
      </ul>
    </li>
<!--     <li class=""><a title="" href="javascript:void(0);" id="settingsBtn"><i class="icon icon-cog"></i> <span class="text">设置</span></a></li>
 -->    <li class=""><a title="" href="javascript:void(0);" id="loginOutBtn"><i class="icon icon-share-alt"></i> <span class="text">退出</span></a></li>
  </ul>
</div>
<!--close-top-Header-menu-->
<!--start-top-serch-->
<!--<div id="search">
  <input type="text" placeholder="输入搜索内容..."/>
  <button type="submit" class="tip-bottom" title="Search"><i class="icon-search icon-white"></i></button>
</div>-->
<!--close-top-serch-->
<!--sidebar-menu-->
<div id="sidebar"><a href="#" class="visible-phone"><i class="icon icon-home"></i> 控制台</a>
  <ul>
  	<c:forEach var="menuMap" items="${menus}" varStatus="status">
  		<li class="submenu ${status.index eq 0?'open':''}">
  			<a href="javascript:void(0);"><i class="icon icon-th-list"></i><span>${menuMap.key.title}</span></a>
  			<ul class="${status.index eq 0?'show':''}">
  			<c:forEach var="menu" items="${menuMap.value}" varStatus="mstatus">
  				<li class="${status.index eq 0 and mstatus.index eq 0 ? 'active':''}">
  					<a href="javascript:void(0);" url="${requestPath}${menu.url}">${menu.title }</a>
  				</li>
  			</c:forEach>
  			</ul>
  		</li>
  	</c:forEach>
  </ul>
</div>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
  <div id="content-header">
    <div id="breadcrumb">
    	<a href="javascript:void(0);" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> 首页</a>
    </div>
  </div>
<!--End-breadcrumbs-->
   <iframe style="width:100%;margin-top:20px;margin-right:20px;" id="content-body" name="iframepage" frameBorder=0 
   			scrolling=no  class="container-fluid">
   		
   </iframe>
</div>

<!--end-main-container-part-->

<!--Footer-part-->

<div class="row-fluid">
  <div id="footer" class="span12">Copyright @2014-2015 doubletuan.com.All Right Reserved. 技术支持：上海团团信息技术有限公司  沪ICP备14043145号</div>
</div>

<!--end-Footer-part-->
<%@include file="/common/js.jsp" %>
<script src="${basePath}matrix.js"></script>
<script src="${basePath}index.js"></script>
</body>
</html>
