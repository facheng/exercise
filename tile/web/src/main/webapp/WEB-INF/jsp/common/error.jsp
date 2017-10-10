<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
	<title>404</title>

    <style type="text/css">
        *{margin:0;padding:0;}
        body {color: #333; font-family: "Microsoft YaHei","Hiragino Sans GB","Microsoft YaHei","微软雅黑",tahoma,arial,simsun,"宋体";font-size:13px; background:#f2f2f2; position: relative; height:100%;}
        html{overflow: auto; position: relative; height:100%;}
        a {text-decoration: none; outline: none; color:#333;}
        img{border:none;}
        .clear {
            *zoom:1;
            clear:both;
        }
        .clear:after {
            display:block;
            content:"clear";
            height:0;
            clear:both;
            overflow:hidden;
            visibility:hidden;
        }
        
        .btn {
          display: inline-block;
          border-radius: 3px;
          color: #fff;
          padding: 0 20px;
          text-align: center;
          font-size: 14px;
          height: 32px;
          line-height: 32px;
        }
        .btnbgViolet {
          background: #4A5EBB;
        }
        .btnbgViolet:hover {
          background: #394CA5;
        }
        .contains_error{text-align: center; height: 170px;position: absolute; top: 50%; margin-top: -90px; width: 100%; left: 0; *width: 640px;*left: 50%;*margin-left: -320px;}
        .error-icon-left,.error-icon-right{display: inline-block;vertical-align: top; *display: block;*float: left;}
        .error-icon-right{margin-left: 30px; text-align: left;}
        .contains_error h2{font-size:38px; color: #334a60;margin-bottom: 16px;}
        .contains_error p{font-size:18px; color: #334a60;margin-bottom:48px;}
        .btnRturnIndex-error{margin-left: 140px;}

    </style>
    
</head>
<body>
    <div class="contains_error clear">
        <div class="error-icon-left"><img src="/static/images/warning.png"></div>
        <div class="error-icon-right">
            <h2>抱歉，您的操作出现了异常！</h2>
            <p>团大侠会及时做处理，还请重新载入或者点击返回首页。</p>
            <a class="btn btnbgViolet btnRturnIndex-error" title="返回首页" onclick="fanhui();" href="javascript:void(0);">返回首页</a>
        </div>
    </div>
</body>
</html>
<script type="text/javascript">
<!--
function fanhui(){
	history.go(-1);
}
//-->
</script>
