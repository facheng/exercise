/**
 * 
 */
var options = {
	"sAjaxSource": requestPath+"sysprofitecom/profitecoms",
	"aoColumns":[
	    {"sTitle": "序号", "sName":"index", "sWidth":"20px", "sClass":"center", "fnRender":function(obj){
	    	return obj.iDataRow+1;
	    }}, 
	 	{"sTitle": "电商代码", "sName":"code","sWidth":"50px"},//"mDataProp":"cRemark"
	 	{"sTitle": "电商名称", "sName":"ecomName","sWidth":"50px", "bSearchable":false},
	 	{"sTitle": "是否自动清算", "sName":"autoCalculate","sWidth":"50px", "bSearchable":false, "bStorable":false ,
	 		"fnRender":function(obj){
	 		var isAutoCalc = obj.aData[obj.iDataColumn];
	 		return isAutoCalc == '1'?"是":"否";
	 		
 		}},
	 	//{"sTitle": "备注", "sName":"remark","sWidth":"100px", "bSearchable":false, "bStorable":false},
	 	{"sTitle": "操作", "sName":"id", "sWidth":"50px", "sClass":"center", 
	 		"bSearchable":false, "bStorable":false,
	 		"fnRender":function(obj){
	 			var ecomId = obj.aData[obj.iDataColumn];
	 			return '<span objId='+ecomId+'>'
	 				+'<a href="'+requestPath+'sysprofitecom/consumerecIndex?ecomId='+ecomId+'" class="allotModule" title="查看消费记录"><i class="icon-th-large"></i></a>|'
	 				+'<a href="'+requestPath+'sysprofitecom/balanceInIndex?ecomId='+ecomId+'" class="allotModule"  title="电商结算" style="font-size:14px;"><i class="icon-ok-sign"></i></a>|'
	 				+'<a href="javascript:void(0);" class="edit" name="id"><i class="icon-edit" title="编辑"></i></a>|'
	 				+'<a href="javascript:void(0);" class="delete"><i class="icon-remove" title="删除"></i></a>'
	 				+'</span>';
	 		}},
	 ],"fnServerParams": function(aoData){//添加额外参数
		 Array.prototype.push.apply(aoData, $(".search").parents("form:eq(0)").serializeArray());
	}
};
