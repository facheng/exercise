/**
 * 
 */
var options = {
	"sAjaxSource": requestPath+"sysprofitecom/balanceIns",
	"aoColumns":[
	    {"sTitle": "序号", "sName":"index", "sWidth":"30px", "sClass":"center", "fnRender":function(obj){
	    	return obj.iDataRow+1;
	    }}, 
	 	{"sTitle": "电商名", "sName":"ecomName", "sWidth":"150px" , "bSearchable":false},
	 	{"sTitle": "对账时间", "sName":"checkAmountTime", "sWidth":"100px" ,"bSearchable":false},
	 	{"sTitle": "交易开始时间", "sName":"startTime", "sWidth":"100px" ,"bSearchable":false},
	 	{"sTitle": "交易结束时间", "sName":"endTime", "sWidth":"100px" ,"bSearchable":false},
	 	{"sTitle": "消费金额（¥）", "sName":"consumeAmount" , "sWidth":"100px" , "bSearchable":false, "bStorable":false},
	 	{"sTitle": "反润金额（¥）", "sName":"profitAmount" , "sWidth":"100px" , "bSearchable":false, "bStorable":false},
	 	{"sTitle": "状态", "sName":"status" , "sWidth":"100px" , "bSearchable":false, "bStorable":false ,"fnRender":function(obj){
 			var status = obj.aData[obj.iDataColumn];
	    	return status == 0 ?'未结算':status == 1?'结算中(发票)':'已结算';
	    }},
	 	{"sTitle": "操作", "sName":"id", "sClass":"center", 
	 		"bSearchable":false, "bStorable":false,
	 		"fnRender":function(obj){
	 			var id = obj.aData[obj.iDataColumn];
	 			var statusVal = obj.aData[7];
	 			var resultDisplay =  '<span objId='+id+'>';
 				if(statusVal == '未结算' ){
 					resultDisplay += '<a href="javascript:closeBalance('+id+',true);" class="balance" style="font-size:14px;" title="申请结算"><i class="icon-ok-sign"></i></a>'
 				} else if(statusVal == '已结算'){
 					resultDisplay += '<a href="javascript:void(0);" class="delete"><i class="icon-remove" title="删除"></i></a>'
 				} else {
 					resultDisplay += '<a href="javascript:closeBalance('+id+',false);" class="balance"  title="结算"><i class="icon-ok"></i></a>'
 				}
 				resultDisplay += '</span>';
	 			
	 			return resultDisplay;
		    }},
	 	],"fnServerParams": function(aoData){// 添加额外参数
		 Array.prototype.push.apply(aoData, $(".search").parents("form:eq(0)").serializeArray());
	 }
};

function closeBalance(objId,isApply){
		//var objId = $(this).parents("span:eq(0)").attr("objId");
     	var mess = "";
     	var alertMsg = "";
     	if(isApply){
     		mess = "你确定申请结算这条记录么？";
     		alertMsg = "申请成功";
     	} else {
     		mess = "你确定结算这条记录么？";
     		alertMsg = "结算成功";
     	}
        url = "undefined" != typeof url ? url : "balance";
        var $confirm = $.confirm({
			msg:mess,
			confirm:function(){
				$.ajax({
					url:url,
					type:"POST",
					dataType:"json",
					data:"id="+objId,
					success:function(resp){
						if(resp.status){//如果成功 刷新列表
							dataTable.fnReloadAjax();
						}
						$confirm.modal("hide");
						$.alert(alertMsg);
					}
				});
			}
		});
}
