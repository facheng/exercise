/**
 * 
 */
var options = {
	"sAjaxSource": requestPath+"sysmenu/menus",
	"aoColumns":[
	    {"sTitle": "序号", "sName":"index", "sWidth":"50px", "sClass":"center", "fnRender":function(obj){
	    	return obj.iDataRow+1;
	    }}, 
	    {"sTitle": "菜单名称", "sName":"title", "sWidth":"100px"},
	 	{"sTitle": "菜单编码", "sName":"code", "sWidth":"100px"},
	 	{"sTitle": "上级菜单", "sName":"parentId", "bVisible":false},
	 	{"sTitle": "上级菜单", "sName":"parentName", "sWidth":"100px"},
	 	{"sTitle": "链接路径", "sName":"url"},
	 	{"sTitle": "创建时间", "sName":"createDateTime", "sWidth":"120px"},
	 	{"sTitle": "操&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;作", 
	 		"sName":"id", "sClass":"center", "bSearchable":false, "sWidth":"50px",
	 		"fnRender":function(obj){
	    	var result = '<span objId='+obj.aData[obj.iDataColumn]+'>';
	    	if(obj.aData[2].length < 6){
	    		result += '<a href="javascript:void(0);" class="plus" title="新增子菜单"><i class="icon-plus"></i></a>|';
	    	}	
			result += '<a href="javascript:void(0);" class="edit" name="id" title="编辑"><i class="icon-edit"></i></a>|'
 				+'<a href="javascript:void(0);" class="delete" title="删除"><i class="icon-remove"></i></a>'
 				+'</span>';
	    	
	    	return result;
	    }},
	 ],"fnServerParams": function(aoData){//添加额外参数
		 Array.prototype.push.apply(aoData, $(".search").parents("form:eq(0)").serializeArray());
	},
	"fnDrawCallback":function(){
		//$('.data-table').find(".mUrl").css({'width': '120px','display':'block','word-break':'break-all','word-wrap':'break-word', 'line-height':'20px'});
	}
};
