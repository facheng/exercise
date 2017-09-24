$(function(){
	$(document).undelegate(".data-table tr a", "click").delegate(".data-table tr a", "click", function(e){
		var objId = $(e.target).parents("span:eq(0)").attr("objId");
		var url = $(e.target).attr("url");
		if($(this).is(".edit")){//如果是编辑
            url = "undefined" != typeof url ? url : "entity";
            var params = {};
            params[$(this).attr("name")] = objId;
            $.redirect(url, params);
		}else if($(this).is(".delete")){//如果是删除
			var ids = [];
            ids.push(objId);
            url = "undefined" != typeof url ? url : "deleteBalance";
            var $confirm = $.confirm({
				msg:"你确定要删除这条记录么？",
				confirm:function(){
					$.ajax({
						url:url,
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
	

	$('#checkAmount_a').on('click' , function(){
		
		var startTime = $('#startTime').val();
		var endTime = $('#endTime').val();
		var ecomId = $('#ecomId').val();
		var isEmptyFlag = $('.data-table .dataTables_empty');
		//alert($(isEmptyFlag).is('td'));
		if(startTime == null || $.trim(startTime) == ""){
			$.alert("请输入交易开始时间");
			return;
		}
		if(endTime == null || $.trim(endTime) == ""){
			$.alert("请输入交易结束时间");
			return;
		}
		if(ecomId == null || $.trim(ecomId) == ""){
			$.alert("电商id为空");
			return;
		}
		if($(isEmptyFlag).is('td')){
			$.alert("没有需要对账的交易");
			return;
		}
		
		  var $confirm = $.confirm({
				msg:"确定对时间段["+startTime+" 00:00:00]-["+endTime+" 23:59:59]内的交易对账？",
				confirm:function(){
					$.ajax({
						url:'checkamount',
						type:'post',  
		                dataType:'json', 
						data:$('#consumerec_form').serialize(),
						success:function(resp){
							if(resp.status){//如果成功 刷新列表
								dataTable.fnReloadAjax();
								$confirm.modal("hide");
								$.alert("对账成功!");
							} else {
								$confirm.modal("hide");
								$.alert("对账失败!");
							}
							
						}
					});
				}
			});
			
	});
	
	$("a[class=add]").click(function(e){
		var url = $(e.target).attr("url");
		url = "undefined" != typeof url ? url : "entity";
		$.redirect(url);
	});
	
	$("form").each(function(){
		$(this).submit(function(){
			return false;
		});
		var form = this;
		var validateOptions = {    
			submitHandler: function(form){ 
		      $(form).ajaxSubmit({
		    	  success:function(resp){
		    		  if(typeof resp == "string")resp = eval("(" + resp + ")");
		    		  if(resp.status){
		    			  $.alert({
		    				  msg:resp.msg,
		    				  confirm:function(){
		    					  $("#backBtn").click();
		    				  }
		    			  });
		    		  }else{
		    			  $.alert(resp.msg);
		    		  }
		    	  }
		      });    
		   } 
		 };
		var defaultOptions = $(this).data("validator")?$(this).data("validator").settings:{};
		$.extend(defaultOptions, validateOptions);
		$(this).validate(defaultOptions);
	});
	
	$("#backBtn").click(function(){
		window.location.href = $(this).attr("backUrl");
	});
});

