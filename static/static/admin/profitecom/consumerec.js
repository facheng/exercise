/**
 * 
 */
var options = {
	"sAjaxSource": requestPath+"sysprofitecom/consumerecs",
	"aoColumns":[
	    {"sTitle": "序号", "sName":"index", "sWidth":"30px", "sClass":"center", "fnRender":function(obj){
	    	return obj.iDataRow+1;
	    }}, 
	 	{"sTitle": "电商名", "sName":"ecomName", "sWidth":"200px" , "bSearchable":false},
	 	{"sTitle": "交易时间", "sName":"consumeTime", "sWidth":"100px" ,"bSearchable":false},
	 	{"sTitle": "订单号", "sName":"orderId" , "sWidth":"150px" ,"bStorable":false},
	 	{"sTitle": "消费金额（¥）", "sName":"consumeAmount" , "sWidth":"100px" , "bSearchable":false, "bStorable":false},
	 	{"sTitle": "反润金额（¥）", "sName":"profitAmount" , "sWidth":"100px" , "bSearchable":false, "bStorable":false},
	 	{"sTitle": "状态", "sName":"status" , "sWidth":"100px" , "bSearchable":false, "bStorable":false ,"fnRender":function(obj){
 			var status = obj.aData[obj.iDataColumn];
	    	return status == 0 ?'未对账':'已对账';
	    }},
	 	],"fnServerParams": function(aoData){// 添加额外参数
		 Array.prototype.push.apply(aoData, $(".search").parents("form:eq(0)").serializeArray());
	 }
};

