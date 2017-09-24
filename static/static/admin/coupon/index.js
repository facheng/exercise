/**
 * 
 */
var options = {
	"sAjaxSource": requestPath+"syscoupon/couponTypes",
	"aoColumns":[
	    {"sTitle": "序号", "sName":"index", "sWidth":"15px", "sClass":"center", "fnRender":function(obj){
	    	return obj.iDataRow+1;
	    }}, 
	 	{"sTitle": "类型名称", "sName":"name", "sWidth":"60px","fnRender":function(obj){
	 		return disposeWord(obj.aData[obj.iDataColumn]);
	 	}},
	 	
	 	{"sTitle": "类型编码", "sName":"code", "sWidth":"30px" ,"sClass":"center"},
	 	
	 	{"sTitle": "是否已上架", "sName":"onShelf", "sWidth":"35px" ,"sClass":"center"},
	 	
	 	{"sTitle": "类型","sName":"ctype" , "sWidth":"45px" , "bStorable":false,"sClass":"center" ,"fnRender":function(obj){
	 		var type = obj.aData[obj.iDataColumn];

	 		if(type == 1){
	 			return '家政宝';
	 		}
			if(type == 2){
				return '生活宝';		
			}
			if(type == 3){
				return '商旅宝';	
			}
			if(type == 4){
				return '爱车宝';
			}
			if(type == 5){
				return '生活缴费';
			}
			if(type ==6){
				return '生活秘籍';
			}else{
				return '';
			}
	 	}},
	 	
	 	{"sTitle": "金额", "sName":"price" , "sWidth":"45px" , "bSearchable":false, "bStorable":false},
	 	
	 	{"sTitle": "优惠区域", "sName":"region", "sWidth":"50px" ,"bSearchable":false, "fnRender":function(obj){
	 		return disposeWord(obj.aData[obj.iDataColumn]);
	 	}},
	 	{"sTitle": "发券商家", "sName":"sponsor" , "sWidth":"45px" , "sClass":"center"},
	 	{"sTitle": "有效期",  "sName":"deadline" , "sWidth":"50px" , "bSearchable":false, "bStorable":false},
	 	{"sTitle": "客服电话", "sName":"servicePhone" , "sWidth":"45px" , "bStorable":false, "fnRender":function(obj){
	 		return disposeWord(obj.aData[obj.iDataColumn]);
	 	}},
	 	{"sTitle": "操作", "sName":"id", "sWidth":"30px", "sClass":"center", 
	 		"bSearchable":false, "bStorable":false,
	 		"fnRender":function(obj){
	 			var id = obj.aData[obj.iDataColumn];
	 			return '<span objId='+id+'>'
	 				+'<a href="'+requestPath+'syscoupon/couponIndex?typeId='+id+'" class="allotModule" title="查看详情"><i class="icon-th-large"></i></a>|'
	 				+'<a href="javascript:void(0);" class="edit" name="id"><i class="icon-edit" title="编辑类型"></i></a>|'
	 				+'<a href="javascript:void(0);" class="delete"><i class="icon-remove" title="删除"></i></a>'
	 				+'</span>';
		    	
		    	return result;
		    }},
	 	],"fnServerParams": function(aoData){// 添加额外参数
		 Array.prototype.push.apply(aoData, $(".search").parents("form:eq(0)").serializeArray());
	 }
};

function disposeWord(str){
	var label = "<span title='"+str+"'>";
	if(str.length>10){
		str = str.substring(0, 6) + "...";
	}
	label += str;
	label += "</span>";
	return label;
}
