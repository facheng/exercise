/**
 * 
 */
var options = {
	"sAjaxSource": requestPath+"sysappclickrec/appclickrecs",
	"aoColumns":[
	    {"sTitle": "序号", "sName":"index", "sWidth":"15px", "sClass":"center", "fnRender":function(obj){
	    	return obj.iDataRow+1;
	    }}, 
	 	{"sTitle": "菜单名称", "sName":"menuName", "sWidth":"35px" ,"sClass":"center"},
	 	{"sTitle": "功能类别", "sName":"typeName", "sWidth":"30px" , "sClass":"center", "bSearchable":false},
	 	{"sTitle": "点击次数", "sName":"counts" ,  "sWidth":"35px" , "bSearchable":false, "bStorable":false}
	 ]
};
