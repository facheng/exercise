
$(function($){
	$.initSelect();
});

Math.guid = function(){
    var s4 = function(){
        return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
    };
    return (s4()+s4()+"-"+s4()+"-"+s4()+"-"+s4()+"-"+s4()+s4()+s4());
}

function cascadeChecked(id, checked){
	var ids = [];
	for(var i=id.length-3; i>0; i-=3){
		ids.push(id.substring(0, i));
	}
	checked = "undefined" == typeof checked;
	if(checked){
		$(":checkbox[id^="+id+"]").removeAttr("checked");
	}else{
		$(":checkbox[id^="+id+"]").attr("checked", "checked");
	}
	var count = 1;
	$.each(ids, function(k, v){
		if(checked){
			if($(":checkbox[id^="+v+"]:checked").length > count){
				return false;
			}
			$(":checkbox[id="+v+"]:checked").removeAttr("checked");
			
		}else{
			if($(":checkbox[id="+v+"]").is(":checked")) return false;
			$(":checkbox[id="+v+"]").attr("checked", "checked");
		}
		count ++;
	});
}

$.fn.extend({
	getDataOptions:function(){
		var dataOptions = $(this).attr("data-options"); 
		return typeof dataOptions == "undefined" ? {}:eval("("+dataOptions+")");
	},reloadSelect:function(options){
		var _this = this;
		var defaultOptions = {
			 url:null,
			 params:{},
			 data:[],
			 value:"",
			 defaultText:"---请选择---",
			 defaultValue:"",
			 valueField:"id",
			 textField:"name",
			 success:function(){}
		};
		$.extend(defaultOptions, options);
		$.ajax({
			type:"post",
			url:defaultOptions.url,
			data:defaultOptions.params,
			dataType : "json",
			cache : false,
			success:function(data){
				$(_this).select2("destroy");
				$(_this).html("");
				var datas = [];
				var _option = function(value, text){
					return $("<option></option>").attr("value", value).text(text);
				}
				$(_this).append(_option("", defaultOptions.defaultText));
				$.each(data, function(){
					$(_this).append(_option(this[defaultOptions.valueField], this[defaultOptions.textField]));
				});
				$(_this).val(defaultOptions.value);
				defaultOptions.success.call(this);
				$(_this).select2();
			}
		});
	},
	ajaxSelect:function(options){
		var _this = this;
		if($(_this).is("select") && "undefined" != typeof options){
			var defaultOptions = {
				 url:null,
				 params:{},
				 data:[],
				 value:"",
				 defaultText:"---请选择---",
				 defaultValue:"",
				 valueField:"id",
				 textField:"name",
				 success:function(){}
			};
			
			if(typeof options == "string"){
				options = {url:options};
			}else{
				$.extend(defaultOptions, options);
			}
			
			var _option = function(value, text){
				return $("<option></option>").attr("value", value).text(text);
			}
			
			var _select = function(data){
				$(_this).empty();
				$(_this).append(_option(defaultOptions.defaultValue, defaultOptions.defaultText));
				data = eval(data);
				$.each(data, function(){
					var $option = _option(this[defaultOptions.valueField], this[defaultOptions.textField]);
					$option.data("data", this);
					$(_this).append($option);
				});
				$(_this).val(defaultOptions.value);
				defaultOptions.success.apply(_this, data);
			}
			
			if(defaultOptions.url != null){
				$.ajax({
					type:"post",
					url:defaultOptions.url,
					data:defaultOptions.params,
					dataType : "json",
					cache : false,
					success:function(data){
						_select(data);
					}
				});
			}else{
				_select(defaultOptions.data)
			}
		}
		return _this;
	},
	window:function(options){
		var $window = $(this).data("_window");
		if(typeof $window == "undefined"){
			options.cache = true;
			$(this).data("_window", $.window(options));
		}else{
			$window.modal("show");
			$window.find(":input:visible").val("");
		}
		return this;
	}
});

$.extend({
	initSelect:function(selectOptions){
		$("select[data-options]").each(function(){
			var _this = this;
			$(_this).css("width", "220px");
			var options = eval("(" + $(_this).attr("data-options") + ")");
			if("undefined" == typeof options.valueField){
				options.valueField = $(_this).attr("name");
			}
			options.success = function(data){
				if("object" == typeof selectOptions){
					$.each(selectOptions, function(k, v){
						if($(_this).is(k)){
							$(_this).select2().select2("val", v);
							$(_this).attr("val", v);
							$(_this).change();
						}else{
							$(_this).select2();
						}
					});
				}else{
					if("undefined" == typeof options.value 
							|| options.value == ""){
						$(_this).select2().select2("val", "");
					}else{
						$(_this).select2();
					}
				}
			}
			$(this).ajaxSelect(options);
			$(this).removeAttr("data-options");
		});
	},
    modal:function(options){
    	var defaultOptions = {
    			type:"alert",//alert confirm window
    			url:null,
                params:{},
                success:function(args){},
    			binder:null,//selector
    			content:null,
    			title:"消息提示",
    			confirm:function(){},
    			cancel:function(){},
    			show:function(){},
    			footer:true,
    			cache:false,
    			toggle:[]
    	};
        if("undefined" == typeof options) options = {};
    	$.extend(defaultOptions, options);
    	
        var id = Math.guid();
        
    	var $modal = $("<div class='modal hide fade in'></div>").attr("id", id).hide();
        //头部
        var $modal_header = $("<div class='modal-header'><a class='close' data-dismiss='modal'>X</a><h3>"+defaultOptions.title+"</h3></div>");
        //内容区域
        var $modal_body = $("<div class='modal-body'></div>");
        $modal.append($modal_header);

        if(defaultOptions.content != null){
            $modal_body.html(defaultOptions.content);
            defaultOptions.success.call($modal, defaultOptions.contenta);
        }else if(defaultOptions.binder != null){
        	$(defaultOptions.binder).hide();
            $modal_body.html($(defaultOptions.binder).clone(true).show());
            defaultOptions.success.call($modal, defaultOptions.binder);
        }else if(options.url != null){
        	if(defaultOptions.cache == false){
        		defaultOptions.params._ = new Date().getTime();
        	}
            $modal_body.load(defaultOptions.url, defaultOptions.params, function(args){
            	defaultOptions.success.call($modal, args);
            });
        }
        $modal.append($modal_body);
        
        //底部
        if(defaultOptions.footer){
	        var $modal_footer = $("<div class='modal-footer'>"
	            +"<a href='#' class='btn btn-success'>确认</a>"
	            + (defaultOptions.type == "alert"?"":"<a href='#' class='btn btn-cancel' data-dismiss='modal'>取消</a>")
	            +"</div>");
	        $modal_footer.find("a").click(function(e){
	            if($(this).is(".btn-success")){
	                if(defaultOptions.confirm.call($modal, defaultOptions) == false){
	                   return false;
	                }
	            }else if($(this).is(".btn-cancel")){
	            	defaultOptions.cancel.call($modal, defaultOptions);
	            }
	            $modal.modal("hide");
	            return false;
	        });
	        $modal.append($modal_footer);
        }
        
        $("body").append($modal);
        $modal.on("show.bs.modal", function(){
        	defaultOptions.show.call(this, defaultOptions);
        });
        return $modal.modal("hide").on("hide.bs.modal", function(){
        	var _this = this;
        	$.each(defaultOptions.toggle, function(){
        		$(this).modal("show");
        	});
        	if(defaultOptions.cache == false)$(this).remove();
        });
    },
    alert:function(options, toggle){
       var defaultOptions = {
		   type:"alert",
		   content:"",
           title:"消息提示"
       }
       if("undefined" == typeof options){
           options = {msg:""};
       }else if("string" == typeof options){
    	   options = {content:options};
       }else{
    	   options.content = options.msg;
       }
       if("undefined" != $.type(toggle)){
    	   if($.isArray(toggle)){
    		   options.toggle = toggle;
    	   }else{
    		   var toggles = new Array();
    		   $.each(arguments, function(i){
    			   if(i>0 && $.type(this) != "undefined"){
    				   toggles.push(this);
    			   }
    		   });
    		   options.toggle = toggles;
    	   }
       }
       $.extend(defaultOptions, options)
       return $.modal(defaultOptions).modal("show");
    },
    confirm:function(options){
        var defaultOptions = {
            type:"confirm",
            title:"警告",
            content:"",
            confirm:function(){}
        };
        if("undefined" == typeof options){
            options = {msg:""};
        }else{
        	options.content = options.msg;
        }
        $.extend(defaultOptions, options);
        return $.modal(defaultOptions).modal("show");
    },
    window:function(options){
        var defaultOptions = {
            type:"window",//alert confirm window
            url:null,
            params:{},
            success:function(args){},
            binder:null,//selector
            content:null,
            title:"消息提示",
            confirm:function(){},
            cancel:function(){}
        };
        if("undefined" == typeof options) options = {};
        $.extend(defaultOptions, options);
        return $.modal(defaultOptions).modal("show");
    },
    redirect:function(url, params){
    	if("undefined" != typeof params){
    		url += "?" + $.param(params);
    	}
    	window.location.href = url;
    }
});
