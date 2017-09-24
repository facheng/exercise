$(function(){
	$("a[class=add]").click(function(e){//菜单新增 弹出窗口
		var params = $(e.target).attr("params");
		if(typeof params != "undefined"){
			params = eval("(" + params + ")");
		}else{
			params = {};
		}
		var $addWin = $.window({
			title:"菜单信息",
			url:"entity",
			params:params,
			success:function(){
				$.initSelect();
				var validateOptions = {    
					submitHandler: function(form){ 
				      $(form).ajaxSubmit({
				    	  dataType:"json",
				    	  success:function(resp){
				    		  if(resp.status){//如果成功 刷新列表
								dataTable.fnReloadAjax();
								$addWin.modal("hide");
							  }
							  $.alert(resp.msg);
				    	  }
				      })
					}
				};
				
				$(this).find("form").each(function(){
					var defaultOptions = $(this).data("validator")?$(this).data("validator").settings:{};
					$.extend(defaultOptions, validateOptions);
					$(this).validate(defaultOptions);
				});
			},
			confirm:function(){//新增
				$(this).find("form").submit();
				return false;
			}
		});
	});
	
	$(document).undelegate(".plus", "click")
		.delegate(".plus", "click", function(e){//增加子菜单
		var $span = $(e.target).parents("[objId]:eq(0)");
		var selection = $span.attr("selection");
		var params = $span.attr("params");
		if(typeof params != "undefined"){
			params = eval("(" + params + ")");
		}else{
			params = {};
		}
		var pId = $span.attr("objId");//$("#qingyu").select2("val", "CA");
		var $addWin = $.window({
			title:"菜单信息",
			url:"entity",
			params:params,
			show:function(){
				$("#parentId").prop("disabled", true);
			},
			success:function(){
				if(typeof selection != "undefined"){
					selection = eval("(" + selection + ")");
					$.initSelect(selection);
				}else{
					$.initSelect({"#parentId":pId});
				}
				var validateOptions = {    
					submitHandler: function(form){ 
				      $(form).ajaxSubmit({
				    	  dataType:"json",
				    	  success:function(resp){
				    		  if(resp.status){//如果成功 刷新列表
								dataTable.fnReloadAjax();
								$addWin.modal("hide");
							  }
							  $.alert(resp.msg);
				    	  }
				      })
					}
				};
				$(this).find("form").each(function(){
					var defaultOptions = $(this).data("validator")?$(this).data("validator").settings:{};
					$.extend(defaultOptions, validateOptions);
					$(this).validate(defaultOptions);
				});
			},
			confirm:function(){//新增
				$(this).find("form").submit();
				return false;
			}
		});
	});
	
	$(document).undelegate(".edit,.delete", "click")
		.delegate(".edit,.delete", "click", function(e){
		var $span = $(e.target).parents("[objId]:eq(0)");
		var objId = $span.attr("objId");
		if($(this).is(".edit")){//编辑
			var params = $span.attr("params");
			if(typeof params != "undefined"){
				params = eval("(" + params + ")");
			}else{
				params = {};
			}
			params[$(this).attr("name")] = objId;
			var $editwin = $.window({
				title:"菜单信息",
				url:"entity",
				params:params,
				success:function(){
					$.initSelect();
					var validateOptions = {  
						submitHandler: function(form){ 
					      $(form).ajaxSubmit({
					    	  dataType:"json",
					    	  success:function(resp){
					    		  if(resp.status){//如果成功 刷新列表
									dataTable.fnReloadAjax();
									$editwin.modal("hide");
								  }
								  $.alert(resp.msg);
					    	  }
					      })
						}	
					};
					var defaultOptions = $(this).data("validator")?$(this).data("validator").settings:{};
					$.extend(defaultOptions, validateOptions);
					$(this).find("form").validate(defaultOptions);
				},
				confirm:function(){
					$(this).find("form").submit();
					return false;
				}
			});
		}else if($(this).is(".delete")){//删除
			var ids = [];
            ids.push(objId);
            var $confirm = $.confirm({
				msg:"你确定要删除这条记录么？",
				confirm:function(){
					$.ajax({
						url:"delete",
						type:"POST",
						dataType:"json",
						data:{"ids":ids.join(",")},
						success:function(resp){
							if(resp.status){//如果成功 刷新列表
								dataTable.fnReloadAjax();
							}
							$confirm.modal("hide");
							$.alert(resp.msg);
						}
					});
				}
			});
		}
		e.stopPropagation();
	});
});