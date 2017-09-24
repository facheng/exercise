$(function(){
	$(document).undelegate(".data-table tr a", "click").delegate(".data-table tr a", "click", function(e){
		var objId = $(e.target).parents("span:eq(0)").attr("objId");
		var url = $(e.target).attr("url");
		if($(this).is(".balance")){//如果是编辑
            url = "undefined" != typeof url ? url : "balance";
            var params = {};
            params[$(this).attr("name")] = objId;
            $.redirect(url, params);
		}
        e.stopPropagation();
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