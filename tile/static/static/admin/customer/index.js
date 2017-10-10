/**
 * 
 */
var options = {
	"sAjaxSource": requestPath+"syscustomer/customers",
	"aoColumns":[
	    {"sTitle": "序号", "sName":"index", "sWidth":"50px", "sClass":"center", "fnRender":function(obj){
	    	return obj.iDataRow+1;
	    }}, 
	 	{"sTitle": "用户名称", "sName":"userName"},//"mDataProp":"cRemark"
	 	{"sTitle": "公司名称", "sName":"companyName", "bSearchable":false, "bStorable":false},
	 	{"sTitle": "公司ID", "sName":"companyId", "bVisible":false},
	 	{"sTitle": "创建人", "sName":"createUserName", "bSearchable":false},
	 	{"sTitle": "创建时间", "sName":"createDateTime", "bSearchable":false, "bStorable":false},
	 	{"sTitle": "操作", "sName":"id", "sWidth":"100px", "sClass":"center", 
	 		"bSearchable":false, "bStorable":false,
	 		"fnRender":function(obj){
	 			var id = obj.aData[obj.iDataColumn];
	 			return '<span objId='+id+'>'
	 				+'<a href="'+requestPath+'syscustomer/allocationmodule?companyId='+obj.aData[3]+'" class="allotModule" title="分配模块"><i class="icon-th-large"></i></a>|'
	 				+'<a href="javascript:void(0);" class="edit" name="id"><i class="icon-edit" title="编辑"></i></a>|'
	 				+'<a href="javascript:void(0);" class="delete"><i class="icon-remove" title="删除"></i></a>'
	 				+'</span>';
	 		}},
	 ],"fnServerParams": function(aoData){//添加额外参数
		 Array.prototype.push.apply(aoData, $(".search").parents("form:eq(0)").serializeArray());
	}
};
