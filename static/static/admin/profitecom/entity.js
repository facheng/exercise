$(function() {
	
	jQuery.validator.addMethod("isRepeat", function(value, element) {
		
		var flagErr = true;
		var oldCode = $('#old_code').val();
		var curCode = $('#code').val();
		if(oldCode != curCode){
			 $.ajax({
				url:requestPath+'sysprofitecom/code',  
                type:'post',  
                dataType:'json', 
                async:false,
                data:'code='+curCode,
                success:function(data){
                	//alert(typeof data);
                	flagErr = data;
                }
				
			});
			//alert(flagErr);
		} 
		return flagErr;
	}, $.validator.format("电商代码不能重复"));

});