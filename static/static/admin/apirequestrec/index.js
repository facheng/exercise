/**
 * 
 */
var options = {
	"sAjaxSource": requestPath+"sysapirequestrec/apirequestrecs",
	"aoColumns":[
	    {"sTitle": "序号", "sName":"index", "sWidth":"30px", "sClass":"center", "fnRender":function(obj){
	    	return obj.iDataRow+1;
	    }}, 
	 	{"sTitle": "用户姓名", "sName":"userName", "sWidth":"60px"},
	 	{"sTitle": "手机号码", "sName":"phoneNmu", "sWidth":"60px" , "sClass":"center", "bSearchable":false},
	 	{"sTitle": "在线时长", "sName":"times" ,  "sWidth":"50px" , "bSearchable":false, "bStorable":false}
	 ],"fnServerParams": function(aoData){// 添加额外参数
		 Array.prototype.push.apply(aoData, $(".search").parents("form:eq(0)").serializeArray());
	 }
};
