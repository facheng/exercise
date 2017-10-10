$(function() {
	$("#customerForm").validate({
		rules : {
			userName : {
				required:true,
				remote:{
				 url:requestPath+'syscustomer/isrepeat',  
                 type:'post',  
                 dataType:'json',  
                 data:{  
                    userName:function(){
                    	return $('#userName').val();
                    },
                    _:new Date().getTime()
                 },  
                 dataFilter: function(data, type) {  
                     return data;
                }
			   }
			}
		},
		messages : {
			userName : {
				required : "用户名不能为空",
				remote : "用户名已存在"
			}
		}
	});
});