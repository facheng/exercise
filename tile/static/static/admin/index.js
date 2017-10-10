$(function(){
	
	setTip($(".active a"));
	//菜单点击
	$("#sidebar a[url]").click(function(e){
		$("#sidebar").find("li").removeClass("active");
		$(this).parent().addClass("active");
		setTip(this);
		$("#content-body").attr("src", $(this).attr("url"));
	});
	$("#content-body")
		.attr("height", $("#content").height())
		.attr("src", $("#sidebar .active a").attr("url"));
	
	$(window).resize(function(){
		$("#content-body")
		.attr("height", $("#content").height());
	});
	
	$("#loginOutBtn").click(function(e){
		$.confirm({
			msg:"确认退出系统么？",
			confirm:function(){
				$.redirect("sysadmin/logout");
			}
		});
	});
	
	$("#settingsBtn").click(function(){
		$(this).window({
			title:"密码修改",
			url:"tar/redirect_authority_settings",
			success:function(){
				var $form = $("#settingsForm");
				$($form).validate({ 
					onkeyup: false,
					submitHandler: function(form){ 
						$(form).ajaxSubmit({
				    	  success:function(resp){
				    		  if(typeof resp == "string")resp = eval("(" + resp + ")");
				    		  var $modal = $(form).parents(".modal:eq(0)");
				    		  if(resp.success){
				    			  $($modal).remove();
				    			  $.alert(resp.msg);
				    		  }else{
				    			  $.alert(resp.msg,$modal);
				    		  }
				    	  }
				      }); 
					}
				});
				$($form).submit(function(){
					return false;
				});
			},confirm:function(){
				var _this = this;
				$(_this).modal("hide");
				var oldPwd = $(_this).find("input[name=oldPwd]").val();
				var newPwd = $(_this).find("input[name=newPwd]").val();
				var confirmPwd = $(_this).find("input[name=confirmPwd]").val();
				if(oldPwd == newPwd){
					$.alert("新旧密码不能一致，请重新输入！",[_this]);
				}else{
					$(_this).find("form").submit();
				}
				return false;
			}
		});
	});
});

function setTip(a){
	$("#breadcrumb").empty();
	var tip = $(a).parents("ul:eq(0)").prev().find("span").text();
	var current = $(a).text();
	$("#breadcrumb").append('<a href="javascript:void(0);" title="'
			+tip+'" class="tip-bottom"><i class="icon-home"></i> '
			+tip+'</a> ');
	$("#breadcrumb").append('<a href="javascript:void(0);" class="current" url='+$(a).attr("url")+'>'+current+'</a> ');
	$(".current").die("click").live("click", function(e){
		$("#content-body").attr("src", $(this).attr("url"));
	});
}