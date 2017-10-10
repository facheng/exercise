var defaultOptions = {
		"bJQueryUI": true,
		"sPaginationType": "full_numbers",
		"sDom": '<"top"fp>rt<"bottom"pi><"clear">',
		"aLengthMenu": [[5, 10, 20, 30], [5, 10, 20, 30]],
	    "bInfo": true,
	    "bServerSide": true,
	    "bProcessing": true,
		"bSort":false,
		"bFilter": false,
		"bAutoWidth": true,
		"bPaginate": true,
		"oLanguage": {
			"sLengthMenu": "每页显示 _MENU_ 条记录 ",
			"sZeroRecords": "抱歉， 没有找到",
			"sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
			"sInfoEmpty": "",
			"sInfoFiltered": "",
			"oPaginate": {  
                    "sFirst": "首页",  
                    "sPrevious": "前一页",
                    "sNext": "后一页",  
                    "sLast": "尾页"  
                }, 
			"sZeroRecords": "没有检索到数据",  
			"sProcessing": "数据加载中。。。",
			"sSearch":"Filter"
		},
		"fnServerData": function ( sSource, aoData, fnCallback ) {
			 //将客户名称加入参数数组   
		    //aoData.push( { "name": "customerName", "value": $("#customerName").val() } ); 
			 $.ajax( {   
			        "type": "POST",    
			        "url": sSource,    
			        "dataType": "json",   
			        "data": $.param(aoData), //以json格式传递   
			        "success": function(resp) {   
			            fnCallback(resp); //服务器端返回的对象的returnObject部分是要求的格式  
			        }   
			    }); 
		},
		"fnInitComplete":function(oSettings){//表头的回调函数
			if ($(this).prev().html().length == 0) {
				$(this).prev().html("&nbsp;");
			}
//			$(this).prev().empty();
//			$(this).prev().html("&nbsp;");
		},
		"fnDrawCallback":function(){
			//为了处理被bootstrap覆盖的text-align样式
			$('.data-table').find(".center").css("text-align","center");
		}
	};
$(function($){
	if("undefined" != typeof top.window.frames["iframepage"])
	{
		$(top.window.frames["iframepage"].document).find("body").css("background", "#EEEEEE");
	}
	$('.data-table').each(function(){
		//data-options="{'options':'xxxOptions', 'former':'#xxxform', 'id':'xxxDataTable'}"
		var dataOptions = $(this).getDataOptions();
		var tableOptions = dataOptions.options;
		var former = dataOptions.former || "form";
		if("undefined" == typeof tableOptions){
			tableOptions = options;
		}else{
			tableOptions = eval(tableOptions);
		}
		
		var id = dataOptions.id;
		if("undefined" == $.type(id)){
			id = "dataTable";
		}
		if("undefined" != $.type(window[id])){
			throw new error("When there are multiple lists, you must declare ID and former");
		}
		window[id] = $(this).dataTable($.extend({}, defaultOptions, tableOptions));
		$(former).find(".search").click(function(){
			var $first = $(".first[tabIndex]");
			if($first.is(".ui-state-disabled")){
				window[id].fnReloadAjax();
			}else{
				$first.click();
			}
		});
		/*$(former).find(":input").keypress(function(e){
			if(e.keyCode == 13){
				$(former).find(".search").click();
			}
		});*/
		$(former).find('input[type=checkbox],input[type=radio],input[type=file]').uniform();
		if($('select')){ 
			$('select').select2();
		}
	});
});
