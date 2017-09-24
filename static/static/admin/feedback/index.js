/**
 * 
 */
var options = {
	"sAjaxSource": requestPath+"sysfeedback/feedbacks",
	"aoColumns":[
	    {"sTitle": "序号", "sName":"index", "sWidth":"30px", "sClass":"center", "fnRender":function(obj){
	    	return obj.iDataRow+1;
	    }}, 
	 	{"sTitle": "用户姓名", "sName":"userName", "sWidth":"60px"},
	 	{"sTitle": "手机号码", "sName":"phoneNmu", "sWidth":"60px" , "sClass":"center", "bSearchable":false},
	 	{"sTitle": "反馈信息", "sName":"message" ,  "sWidth":"50px" , "bSearchable":false, "bStorable":false},
	 	{"sTitle": "反馈时间", "sName":"createTime" ,  "sWidth":"50px" , "bSearchable":false, "bStorable":false},
	 	{"sTitle": "操作", "sName":"id", "sWidth":"100px", "sClass":"center", 
	 		"bSearchable":false, "bStorable":false,
	 		"fnRender":function(obj){
	 			var id = obj.aData[obj.iDataColumn];
	 			return '<span objId='+id+'>'
	 				+'<a href="javascript:void(0);" class="delete"><i class="icon-remove" title="删除"></i></a>'
	 				+'</span>';
	 		}},
	 	],"fnServerParams": function(aoData){// 添加额外参数
		 Array.prototype.push.apply(aoData, $(".search").parents("form:eq(0)").serializeArray());
	 }
};
