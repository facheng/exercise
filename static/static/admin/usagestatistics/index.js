/**
 * 
 */
var options = {
	"sAjaxSource": requestPath+"sysusagestatistics/usagestatistics",
	"aoColumns":[
	    {"sTitle": "序号", "sName":"index", "sWidth":"15px", "sClass":"center", "fnRender":function(obj){
	    	return obj.iDataRow+1;
	    }}, 
	 	{"sTitle": "小区名称", "sName":"unitName", "sWidth":"50px"},
	 	{"sTitle": "物业公司", "sName":"companyName", "sWidth":"50px"},
	 	{"sTitle": "用户注册数", "sName":"registeredCount", "sWidth":"30px" , "sClass":"center", "bSearchable":false},
	 	{"sTitle": "用户活跃数", "sName":"usedCount" ,  "sWidth":"30px" , "sClass":"center", "bSearchable":false, "bStorable":false},
	 	{"sTitle": "用户转换数", "sName":"converts" ,  "sWidth":"30px" , "sClass":"center", "bSearchable":false, "bStorable":false},
	 	{"sTitle": "开门点击数", "sName":"ioCounts" ,  "sWidth":"30px" , "sClass":"center", "bSearchable":false, "bStorable":false},
	 	{"sTitle": "转换点击数", "sName":"clickCounts" ,  "sWidth":"30px" , "sClass":"center", "bSearchable":false, "bStorable":false}
	 ],"fnServerParams": function(aoData){// 添加额外参数
		 Array.prototype.push.apply(aoData, $(".search").parents("form:eq(0)").serializeArray());
	 }
};
