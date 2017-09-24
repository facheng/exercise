/**
 * 
 */
var options = {
	"sAjaxSource": requestPath+"syscoupon/coupons",
	"aoColumns":[
	    {"sTitle": "序号", "sName":"index", "sWidth":"30px", "sClass":"center", "fnRender":function(obj){
	    	return obj.iDataRow+1;
	    }}, 
	 	{"sTitle": "优惠券编码", "sName":"code", "sWidth":"50px" , "bSearchable":false},
	 	{"sTitle": "优惠券类型", "sName":"typeName", "sWidth":"250px" ,"bSearchable":false},
	 	{"sTitle": "领取人姓名", "sName":"userName" , "sWidth":"160px" ,"bStorable":false},
	 	{"sTitle": "领取人电话", "sName":"phoneNum" , "sWidth":"180px" , "bSearchable":false, "bStorable":false},
	 	{"sTitle": "领取时间", "sName":"receivedTime" , "sWidth":"100px" , "bSearchable":false, "bStorable":false},
	 	{"sTitle": "操作", "sName":"id", "sClass":"center", 
	 		"bSearchable":false, "bStorable":false,
	 		"fnRender":function(obj){
	 			var id = obj.aData[obj.iDataColumn];
	 			return '<span objId='+id+'>'
	 				+'<a href="javascript:void(0);" class="delete"><i class="icon-remove" title="删除"></i></a>'
	 				+'</span>';
		    	return result;
		    }},
	 	],"fnServerParams": function(aoData){// 添加额外参数
		 Array.prototype.push.apply(aoData, $(".search").parents("form:eq(0)").serializeArray());
	 }
};
