/**
 * 
 */
var options = {
	"sAjaxSource": requestPath+"syscompany/companys",
	"aoColumns":[
	    {"sTitle": "序号", "sName":"index", "sWidth":"50px", "sClass":"center", "fnRender":function(obj){
	    	return obj.iDataRow+1;
	    }}, 
	 	{"sTitle": "公司名称", "sName":"companyName"},//"mDataProp":"cRemark"
	 	{"sTitle": "公司编码", "sName":"code", "bSearchable":false},
	 	{"sTitle": "公司邮箱", "sName":"email", "bSearchable":false, "bStorable":false},
	 	{"sTitle": "公司地址", "sName":"address", "bSearchable":false},
	 	{"sTitle": "公司备注", "sName":"remark", "bSearchable":false, "bStorable":false},
	 	{"sTitle": "操作", "sName":"id", "sWidth":"100px", "sClass":"center", 
	 		"bSearchable":false, "bStorable":false,
	 		"fnRender":function(obj){
	 			var cId = obj.aData[obj.iDataColumn];
	 			return '<span objId='+cId+'>'
	 				+'<a href="javascript:void(0);" class="edit" name="id"><i class="icon-edit" title="编辑"></i></a>|'
	 				+'<a href="javascript:void(0);" class="delete"><i class="icon-remove" title="删除"></i></a>'
	 				+'</span>';
	 		}},
	 ],"fnServerParams": function(aoData){//添加额外参数
		 Array.prototype.push.apply(aoData, $(".search").parents("form:eq(0)").serializeArray());
	}
};
