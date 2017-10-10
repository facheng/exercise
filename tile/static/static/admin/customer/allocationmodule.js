$(function(){
	$('.tree').treegrid({
        expanderExpandedClass: 'icon-minus-sign',
        expanderCollapsedClass: 'icon-plus-sign'
    });
	
	// 复选框级联操作
	$(".allotModul").change(function(e){
		var id = $(this).attr("id");
		var checked = $(this).attr("checked");
		cascadeChecked(id, checked);
		e.stopPropagation();
	});
	
	$("#backBtn").click(function(e){
		$.redirect("index");
	});
	
	$("#saveBtn").click(function(e){
		var _from = $("#moduleForm");
		if($(":checked").length > 0){
			
			
			var datas = [];
			var mIds = [];
			datas.push({
				"name":"roleId",
				"value":$("#roleId").val()
			});
			$(":checked").each(function(){
				mIds.push($(this).val());
				datas.push({
					"name":$(this).attr("name"),
					"value":$(this).val()
				});
			});
			//如果未曾修改过 点击保存
			var owns = $("#owns").val();
			if(owns.length > 0){
				owns = owns.replace(/\s/g, "")
					.substring(1, owns.length - 1).split(",");
				if(owns.length == mIds.length){
					owns.sort();
					mIds.sort();
					if(owns.join(",") == mIds.join(",")){
						$("#backBtn").click();
					}
				}
			}
			$.ajax({
				url:requestPath + "syscustomer/alloteModule?"+$.param(datas),
				type:"post",
				dataType:"json",
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
		}else{
			$.alert("请选择模块后进行该操作！");
		}
	});
	if($(".widget-box").height() > $(window).height()){
		$(".widget-content").css("overflow", "auto")
			.height($(window).height() - ($(".widget-title").height() + $(".form-actions").height()+50));
	}
});