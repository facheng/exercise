/**
 * 
 */
var options = {
	"sAjaxSource": requestPath+"sysprofitper/propertyProfitDetails",
	"aoColumns":[
	    {"sTitle": "序号", "sName":"index", "sWidth":"30px", "sClass":"center", "fnRender":function(obj){
	    	return obj.iDataRow+1;
	    }}, 
	    {"sTitle": "电商名称", "sName":"ecomName", "sWidth":"50px"},
	 	{"sTitle": "开始日期", "sName":"startTime","sWidth":"40px","sClass":"center"},
	 	{"sTitle": "结束日期", "sName":"endTime", "sWidth":"40px" , "sClass":"center", "bSearchable":false},
	 	{"sTitle": "消费金额（￥）", "sName":"consumeAmount" ,  "sWidth":"40px" , "bSearchable":false, "bStorable":false},
	 	{"sTitle": "返润总金额（￥）", "sName":"totalProfitAmount" ,  "sWidth":"40px" , "bSearchable":false, "bStorable":false},
	 	{"sTitle": "反润金额（￥）", "sName":"profitAmount" ,  "sWidth":"40px" , "bSearchable":false, "bStorable":false},
	 	{"sTitle": "结算状态", "sName":"statusName" , "sWidth":"30px" ,"sClass":"center"},	
	 	{"sTitle": "操作", "sName":"id", "sWidth":"80px", "sClass":"center", 
	 		"bSearchable":false, "bStorable":false,
	 		"fnRender":function(obj){
	 			var id = obj.aData[obj.iDataColumn];
	 			var statusVal = obj.aData[7];
	 			var resultDisplay = '<span objId='+id+'>'
	 			
	 				if(statusVal == '未结算' ){
	 					resultDisplay += '<a href="javascript:void(0);" class="balance" name="pId"><i class="icon-edit" title="编辑"></i></a>|'
						resultDisplay += '<a href="javascript:void(0);" class="deleteDetail"><i class="icon-remove" title="删除"></i></a>'
					} 
	 				if(statusVal == '申请中'){
						resultDisplay += '<a href="javascript:profitDetailOpt('+id+',true);" class="settlement" style="font-size:15px;"><i class="icon-ok-sign" title="结算"></i></a>'
					}
	 				if(statusVal == '结算中(发票)'){
	 					resultDisplay += '<a href="javascript:profitDetailOpt('+id+',false);" class="settlement" style="font-size:15px;"><i class="icon-ok-sign" title="开票"></i></a>'
	 				}
	 				
	 			resultDisplay += '</span>';
	 			return resultDisplay;
	 		}},
 			
	 	],"fnServerParams": function(aoData){// 添加额外参数
		 Array.prototype.push.apply(aoData, $(".search").parents("form:eq(0)").serializeArray());
	 }
};

function profitDetailOpt(objId, flag) {
	var mess = "";
	var alertMsg = "";
	if (flag) {
		mess = "你确定要结算这条记录么？";
		alertMsg = "结算成功";
	} else {
		mess = "你确定这条记录已开发票么？";
		alertMsg = "开票成功";
	}
	url = "undefined" != typeof url ? url : "settlement";
	var $confirm = $.confirm({
		msg : mess,
		confirm : function() {
			$.ajax({
				url : url,
				type : "POST",
				dataType : "json",
				data : "id=" + objId,
				success : function(resp) {
					if (resp.status) {//如果成功 刷新列表
						dataTable.fnReloadAjax();
					}
					$confirm.modal("hide");
					$.alert(alertMsg);
				}
			});
		}
	});
}