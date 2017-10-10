/**
 * 
 * 
 */
var options = {
	"sAjaxSource": requestPath+"sysprofitper/profitpers",
	"aoColumns":[
	    {"sTitle": "序号", "sName":"index", "sWidth":"20px", "sClass":"center", "fnRender":function(obj){
	    	return obj.iDataRow+1;
	    }}, 
	    {"sTitle": "物业公司ID", "sName":"cId", "bVisible":false},
	 	{"sTitle": "物业公司", "sName":"companyName","sWidth":"50px"},
	 	{"sTitle": "返润比例", "sName":"percent","sWidth":"50px", 
	 	"fnRender":function(obj){
	 		var id = obj.aData[4];
	 		var cId = obj.aData[1];
 			var percent = obj.aData[obj.iDataColumn];
 			return render(id, cId, percent);
 		}},
	 	{"sTitle": "操作", "sName":"id", "sWidth":"50px", "sClass":"center", 
	 		"bSearchable":false, "bStorable":false,
	 		"fnRender":function(obj){
	 			var cId = obj.aData[1];
	 			var id = obj.aData[4];
	 			if(id > 0){
	 				return '<span objId='+cId+'>'
	 				+'<a href="'+requestPath+'sysprofitper/profitperDetailIndex?cId='+cId+'" class="allotModule" title="结算详情"><i class="icon-list"></i></a>|'
	 				+'<a href="javascript:void(0);" class="balance" name="cId"><i class="icon-edit" title="结算"></i></a></span>';
	 			}else{
	 				return '<span>'
	 				+ '请先设置返润比例</span>';
	 			}
	 			
	 		}},
	 ],"fnServerParams": function(aoData){//添加额外参数
		 Array.prototype.push.apply(aoData, $(".search").parents("form:eq(0)").serializeArray());
	}
};

$(function(){
	$(document.body).undelegate(".percentContainer label", "click")
		.delegate(".percentContainer label", "click", function(e){
			if($(this).is(":hidden")){
				$(this).show();
				$(this).prev().hide();
			}else{
				$(this).show().hide();
				$(this).prev().show();
			}
			e.stopPropagation();
		});
	$(document.body).undelegate(".modifyPercent", "click")
	.delegate(".modifyPercent", "click", function(e){
		
		var val = $(this).parent().prev().val();
		var $container = $(this).parents(".percentContainer:eq(0)");
		$container.find("label").text(val);
		var dataOptions = eval("("+$container.attr("dataOptions")+")");
		var old = dataOptions.percent;
		$(this).parents("span:eq(0)").next().show();
		$(this).parents("span:eq(0)").hide();
		if(parseFloat(val) == parseFloat(old)) return false;
		dataOptions.percent = val;
		$container.attr("dataOptions", toJSON(dataOptions));
		$.ajax({
			url: requestPath+"sysprofitper/save",
			type:"post",
			data:dataOptions,
			success:function(){
				 location.reload();
			}
		});
	});
});

function toJSON(obj){
	var json = "{";
	for(var prop in obj){
		var js = "\""+prop + "\":" + obj[prop]; 
		if(json.length > 1){
			json += ",";
		}
		json += js;
	}
	json += "}";
	return json;
}

function render(id, cId, percent){
	var container = "<div class='percentContainer' dataOptions='{\"id\":"+id+", \"cId\":"+cId+", \"percent\":"+percent+"}'>";
	var label = "<label><u title='点击修改'>"+percent+"</u></label>";
	var input = "<span style='display:none;'><input type='text' value='"+percent+"' style='width:100px;'/>&nbsp;&nbsp;<a href='javascript:void(0);' name='id' style='font-size:20px;'><i class='icon-ok modifyPercent' title='修改'></i></a></span>";
	container += input;
	container += label;
	container += "</div>";
	return container;
}


















 