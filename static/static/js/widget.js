//通用验证组件
(function($) {
$.widget("wdg.validate", {
	options: {
		widgetClass: 'wdg-validate',
		fieldExpr: 'input[Validate], select[Validate], textarea[Validate]',
		validateAjax: false,          //是否验证ajax
		bindBlur: false,              //是否在失去焦点时做验证
		bindSubmit: true,             //是否在提交表单时做验证
		ignoreHidden: false,          //是否忽略被隐藏的表单项
		resetOpt: true,               //验证时是否重新获取验证选项
		submitReset: false,           //提交表单时，是否重新初始化验证组件
		fieldParent: '[vdFld]',
		hide: function(event, field){ field.data('validateOpt')['parent'].find('[vdErr], [js="vdErr"]').hide(); },
		showNormal: function(){},
		showSuc: function(event, field){ field.data('validateOpt')['parent'].find('[vdErr], [js="vdErr"]').hide(); },
		showErr: function(event, field){
			var em = field.data('validateOpt')['parent'].find('[vdErr], [js="vdErr"]');
			if( em.length == 0 ) return;
			if( em.attr('vdErr') == 'alert' ){ alert(em.html()); } else { em.show(); }
		}
	},

	_create: function() {
		var self = this, options = this.options;
		this.element.addClass(options.widgetClass);

		this.tools = new $.wdg.validate.tools(this.element, options.extTools || {});
		this.tmCheckBlur = null;
		this.blurField = null;    //失去焦点的表单项

		this.init();

		this.element.data('validateResult', 'waiting').bind('ValidateForm', function(event, callback){
			if( options.submitReset == true ) self.init();
			self.validate(callback);
			return false;
		});
		if( options.bindSubmit == true ){
			this.bindSubmit();
		}
	},

	init: function(){
		var self = this, options = this.options;
		this.ajax = 0;
		this.fields = this.element.find(options.fieldExpr)
		this.fields.each(function(){
			var field = $(this), oldOpt = field.data('validateOpt');
			if( oldOpt && oldOpt.ignoreResetOpt == true ){
				return true;
			}
			var opt = $.wdg.validate.getOptions(field.attr('vdOpt'));
			if( opt.url ){
				self.ajax ++;
				field.attr('vdAjaxField', 'suc');
			}
			opt['field'] = field;
			opt['parent'] = field.closest(options.fieldParent);
			opt['tools'] = self.tools;
			field.data('validateOpt', opt);
		});
		this.fields.unbind('Validate').bind('Validate', function(event, result, ajax, evtType){
			if( evtType ){
				event.type = evtType;
			}
			if( ajax ){
				$(this).attr('vdAjaxField', ajax);
			}
			if( result === -1 ){
				self._trigger('hide', event, $(this));
			} else if( result == true ){
				self._trigger('showSuc', event, $(this));
			} else if( result == false ){
				self._trigger('showErr', event, $(this));
			}
			return false;
		});
		if( options.bindBlur == true ){
			this.bindBlur();
		}
	},

	//设置验证结果：在element中设置验证结果，以便其他程序访问结果，同时作为参数调用回调函数
	//            type表示设置结果的验证阶段，一般为：Validate（验证结束并返回true）；afterValidate（验证结束但返回false）；beforeValidate（验证未开始就返回false）
	_setResult: function(result, callback, type){
		type = type || 'Validate';
		var after = this._trigger('afterValidate', null, result);
		after = result && ( after !== false );
		this.element.data('validateResult', after);
		type = after == true ? 'Validate' : result == true ? 'afterValidate' : type;
		callback.call(this.element, after, type);
	},

	//验证流程：1、判断是否有ajax验证
	//         2、无ajax验证时，依次验证表单项并设置验证结果（在设置验证结果函数中执行验证回调函数）
	//         3、有ajax验证时，设置ajax验证定时，定时判断所有验证是否结束，如结束则设置验证结果（在设置验证结果函数中执行验证回调函数）
	validate: function(callback){
		var self = this, tmSubmit = null, result;
		if( ! $.isFunction(callback) ) callback = function(){};

		this.element.data('validateResult', 'waiting');
		if( this._trigger('beforeValidate', null, callback) === false ){
			this._setResult(false, callback, 'beforeValidate');
			return false;
		}
		if( this.ajax > 0 && this.options.validateAjax ){
			var ajaxField = this.fields.filter('[vdAjaxField]');
			if( ajaxField.length == this.ajax ){
				result = true;
				ajaxField.attr('vdAjaxField', 'waiting');
				if( tmSubmit ) clearInterval(tmSubmit);
				tmSubmit = setInterval(function(){
					if( self.fields.filter('[vdAjaxField="waiting"]').length == 0 ){
						clearInterval(tmSubmit);
						tmSubmit = null;
						result = ( self.fields.filter('[vdAjaxField="err"]').length == 0 && result == true );
						self._setResult(result, callback);
					}
				}, 200);
				result = this.exec();
			}
		} else {
			result = this.exec(true);
			this._setResult(result, callback);
		}
		return this.element.data('validateResult');
	},

	_checkField: function(field, ignoreAjax){
		var str = $.trim(field.val() || ''), opt = field.data('validateOpt'),
			tool = $.trim(field.attr('Validate')),
			result = true;
		if( str == field.attr('defaultTips') ) str = '';
		if( this.options.resetOpt ){
			delete opt.ignore;
			opt = $.extend(opt, $.wdg.validate.getOptions(field.attr('vdOpt')));
		}
		if( opt.ignore ){
			var ignore = '|' + opt.ignore + '|', str1 = (str == '') ? '|empty|' : '|' + str + '|';
			if( ignore.indexOf(str1) > -1 ){
				if( field.attr('vdAjaxField') ) field.attr('vdAjaxField', 'suc');
				return -1;
			}
		}
		if( tool ){
			tool = tool.split(/,|\s/);
			for( var i = 0; i < tool.length; i++ ){
				if( ignoreAjax && tool[i] == 'ajaxValidate' ){
					continue;
				}
				field.attr('curTool', tool[i]);
				if( this.tools[tool[i]] ){
					result = this.tools[tool[i]](str, opt);
					if( result == false ){
						return false;
					}
				}
			}
		}
		return result;
	},

	exec: function(ignoreAjax) {
		var self = this, options = this.options, result = true;
		this.fields.each(function(){
			var field = $(this);
			if( field.attr('vdIgnore') == 'yes' || (field.attr('vdIgnore') != 'no' && options.ignoreHidden && (! field.is('input[type=hidden]')) && field.is(':hidden')) ){
				var b = true;
			} else {
				var b = self._checkField(field, (ignoreAjax === true));
			}
			field.triggerHandler('Validate', [b]);
			result = (b && result);
		});
		if( self._trigger('CBexec', null, {'result': result}) === false ) return false;
		return result;
	},

	bindSubmit: function(){
		var self = this;
		if( this.element.is('form') ){
			//表单提交流程：1、判断表单是否正在提交，是则false跳出。
			//            2、判断是否已经得出验证结果，是则设置提交状态并true跳出。
			//            3、触发验证表单事件并设置一个验证后的回调函数，如验证结果为true则再次触发提交表单事件
			this.element.bind('submit.Validate', function(event){
				if( ! self.element.attr('target') ){
					if( self.element.data('validateSubmiting') == true ) return false;
					if( self.element.data('validateResult') == true ){
						self.element.data('validateSubmiting', true);
						return true;
					}
				} else {
					if( self.element.data('validateResult') == true ) return true;
				}
				if( self._trigger('beforeSubmit', event, self.element) !== false ){
					self.element.triggerHandler('ValidateForm', [function(result){
						if( result == true ){
							setTimeout(function(){
								self.element.submit();
							}, 0);
						}
					}]);
				}
				event.preventDefault();
			});
		}
	},

	bindBlur: function() {
		var self = this, options = this.options;
		var checkBlur = function(field){
			if( field ){
				var b = field.val() == '' ? -1 : self._checkField(field);
				field.triggerHandler('Validate', [b, null, 'blur']);
			}
			self.blurField = null;
		}
		this.fields
		.unbind('focus.Validate').bind('focus.Validate', function(event){
			self.fields.attr('vdFocus', 'out');
			var field = $(this);
			field.attr('vdFocus', 'in');
			if( self.tmCheckBlur ){
				clearTimeout(self.tmCheckBlur);
				self.tmCheckBlur = null;
				checkBlur(self.blurField);
			}
			if( field.val() == '' ){
				self._trigger('showNormal', event, field);
			} else {
				field.triggerHandler('Validate', [self._checkField(field), null, 'focus']);
			}
		})
		.unbind('blur.Validate').bind('blur.Validate', function(event){
			self.blurField = $(this);
			self.blurField.attr('vdFocus', 'out');
			self.tmCheckBlur = setTimeout(function(){
				checkBlur(self.blurField);
			}, 100);  //延迟执行blur
		});
	}
});

$.extend($.wdg.validate, {
	//公用函数
	getOptions: function(str){
		var opt = {};
		try{
			if( str.slice(0, 1) != '{' ) str = '{' + str + '}';
			opt = (new Function('return ' + str))();
		} catch(e){};
		return opt;
	},
	//验证工具
	tools: function(form, ext){
		this.form = form;
		for( var key in ext ){
			if( $.isFunction(ext[key]) ){
				this[key] = ext[key];
			}
		}
	}
});

$.extend($.wdg.validate.tools.prototype, {
	re: {
		phone: '^[1][3-8]\\d{9}$',
		cellphone: '^[\\d]{%min,%max}$',
		zipcode: '^\\d{5,10}$',
		email: '^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$',
		skype: '^[a-zA-Z][\\w\\.]{5,31}$',
		qq: '^[1-9]{1}\\d{4,12}$',
		wangwang: '^[\\w\\u4E00-\\u9FA5]{5,20}$',
		url: '^http[s]?:\/\/([\\w.]+\/?)\\S*$'
	},

	isRegExp: function(str, opt){
		try {
			var reType = typeof(opt) == 'string' ? opt : opt.reType;
			if( reType ) {
				var re = new RegExp(this.re[reType], 'ig');
			} else {
				var re = new RegExp(opt.reStr || '', opt.reFlag || 'ig');
			}
			return re.test(str);
		} catch(e) {
			return false;
		}
	},
	isnotEmpty: function(str, opt){
		str = $.trim(str);
		if( str != '' ){
			if( opt.len ) return str.length <= parseInt(opt.len);
			return true;
		} else {
			return false;
		}
	},
	isnotSelectFirst: function(str, opt){
		var v = parseInt($.trim(str));
		return v >= 0;
	},
	isnotEmptyone: function(str, opt){
		str = $.trim(str);
		if( str != ''&&str != '0' ){
			if( opt.len ) return str.length <= parseInt(opt.len);
			return true;
		} else {
			return false;
		}
	},
	isNumber: function(str, opt){
		if( ! $.isNumeric(str) ) return false;
		var num = parseFloat(str);
		if( opt.min && parseFloat(opt.min) > num ) return false;
		if( opt.max && parseFloat(opt.max) < num ) return false;
		return true;
	},
	isIntLargerThanZero: function(str, opt){
		/*必须是大于0的整数(必填)*/
		var v = $.trim(str);
		if(! $.isNumeric(v)) return false;
		return parseInt(v) > 0 && v == "" + parseInt(v);
	},
	isLargerThanZero: function(str, opt){
		/*必须是大于0的数字(必填)*/
		var v = $.trim(str);
		if(! $.isNumeric(v)) return false;
		return parseFloat(v) > 0;
	},
	isLargerThanZero1: function(str, opt){
		/*必须是大于0的数字(选填)*/
		var v = $.trim(str);
		if(v == "") {
			return true;
		}
		
		if(! $.isNumeric(v)) return false;
		return parseFloat(str) > 0;
	},
	isLargerThanZero2: function(str, opt){
		/*必须是大于或等于0的数字(选填)*/
		var v = $.trim(str);
		if(v == "") {
			return true;
		}
		
		if(! $.isNumeric(v)) return false;
		return parseFloat(str) >= 0;
	},
	isIntLargerThanZero1: function(str, opt){
		/*必须是大于或等于0的整数(选填)*/
		var v = $.trim(str);
		if(v == "") {
			return true;
		}
		
		if(! $.isNumeric(v)) return false;
		return parseInt(v) >= 0 && v == "" + parseInt(v);
	},
	isnotValue: function(str, opt){
		return (str != opt.val);
	},
	isnotValueWith: function(str, opt){
		if( opt['with'] ){
			switch( opt['with'] ){
			case 'visible':
				return opt['field'].is(':visible') ? (str != (opt.val || '')) : true;
			}
		} else {
			return (str != opt.val);
		}
	},
	isPassword: function(str){
		return str.length >= 1;
	},
	//确认密码
	confirmPassword: function(str, opt){
		if( opt['pw'] ){
			return str == $(opt['pw']).val();
		} else {
			return true;
		}
	},
	isCellphone: function(str, opt){
		opt = opt || {};
		var min = opt['min'] || '5', max = opt['max'] || '11';
		var sre = this.re.cellphone.replace('%min', min).replace('%max', max);
		return (new RegExp(sre, 'ig')).test(str);
	},
	isMultiPhone: function(str, opt){
		var r = 0, parent = opt.parent, tools = opt.tools;
		parent.find('[vdOpt]').each(function(){
			var field = $(this), type = field.attr('vdOpt'), v = field.val();
			if( v != '' && $.isFunction(tools[type]) ){
				if( tools[type](v) == false ){
					r = -1;
					return false;
				} else {
					r++;
				} 
			}
		});
		return r > 0;
	},
	isMultiEmail: function(str, opt){
		var a = str.split(/,|\;|\n|\s/g);
		if( a.length > opt.count ){
			return false;
		}
		for( var i = 0; i < a.length; i++ ){
			if( a[i] != '' && (new RegExp(this.re.email, 'ig')).test(a[i]) == false ){
				return false;
			}
		}
		return true;
	},
	isContact: function(str){
		return this.isRegExp(str, 'email') || this.isRegExp(str, 'phone');
	},
	isQQ: function(str){
		return this.isRegExp(str, 'email') || this.isRegExp(str, 'qq');
	},
	isWangWang: function(str){
		return this.isRegExp(str, 'wangwang') && ( !this.isNumber(str) );
	},
	isURL: function(str){
		return this.isRegExp(str, 'url');
	},
	isEmail: function(str){
		return this.isRegExp(str, 'email');
	},
	isPhone: function(str){
		return this.isRegExp(str, 'phone');
	},
	isZipcode: function(str){
		return this.isRegExp(str, 'zipcode');
	},
	isSkype: function(str){
		return this.isRegExp(str, 'skype');
	},
	isChecked: function(str, opt){
		return opt['field'][0].checked;
	},
	isImage: function(str, opt){
		var ext = str.slice(str.length - 3);
		return 'PNG|JPG'.indexOf(ext.toUpperCase()) >= 0;
	},
	radioChecked: function(str, opt){
		var b = false;
		$(':radio[name="' + opt['field'][0].name + '"]').each(function(){
			b = (this.checked || b);
		});
		return b;
	},
	checkboxCheck: function(str, opt){
		return opt['parent'].find(':checkbox:checked').length > 0;
	},
	checkDatetime: function(vd, opt){
		var i, j = 0;
		for( i = 0; i < vd.length; i++ ){
			if( $(vd[i]).val() == '' || $(vd[i]).val() == '0' )
				j++;
		}
		if( i == j ){
			if( opt.required == 'no' )
				return true;
			return false;
		}
		if( j < i && j > 0 )
			return false
		return -1;
	},
	compareDate: function(str, opt){
		var vd = opt['parent'].find('select[vdDate]:visible, select[vdIgnore=no]');
		var check = this.checkDatetime(vd, opt);
		if( check == -1 ){
			var cur = new Date(), cd = new Date(cur.getFullYear(), cur.getMonth()),
				sd = new Date(vd.filter('[vdDate="sy"]').val(), parseInt(vd.filter('[vdDate="sm"]').val(), 10) - 1);
			if( vd.length == 4 ){
				var ed = new Date(vd.filter('[vdDate="ey"]').val(), parseInt(vd.filter('[vdDate="em"]').val(), 10) - 1);
				var b = (ed >= sd && sd <= cd);
				if( opt['chk'] && opt['chk'] == 'ed' )
					b = b && (ed <= cd);
				return b;
			} else {
				return (sd <= cd);
			}
		} else {
			return check;
		}
	},
	compareYear: function(str, opt){
		var vd = opt['parent'].find('select[vdDate]:visible, select[vdIgnore=no]');
		var check = this.checkDatetime(vd, opt);
		if( check == -1 ){
			var cur = new Date(), cy = new Date(cur.getFullYear(), 0),
				sy = new Date(vd.filter('[vdDate="sy"]').val(), 0),
				ey = new Date(vd.filter('[vdDate="ey"]').val(), 0);
			var b = (ey >= sy && sy <= cy);
			if( opt['chk'] && (opt['chk'] == 'ey' || opt['chk'] == 'ed') )
				b = b && (ey <= cy);
			return b;
		} else {
			return check;
		}
	},
	ajaxValidate: function(str, opt){
		if( opt['url'] ){
			var param = {};
			var key = opt['key'] || opt['field'].attr('name');
			if( key ) param[key] = str;
			$.ajax({
				url: opt['url'],
				cache: false,
				type: 'POST',
				dataType: 'text',
				data: param,
				success: function(data) {
					if( data == '1' ){
						opt['field'].triggerHandler('Validate', [true, 'suc']);
					} else {
						opt['field'].triggerHandler('Validate', [false, 'err']);
					}
				}
			});
		}
		return -1;
	},
	
	//验证
	ajaxValid: function(str, opt){
		if(str != null && $.trim(str) != '') {
			opt['field'].next(".error-tooltip").find(".checkObj").show();
	        opt['field'].next(".error-tooltip").find(".isNull").hide();
	        return this.ajaxValidate(str, opt);
		} else {
			opt['field'].triggerHandler('Validate', [false, 'err']);
	        opt['field'].next(".error-tooltip").find(".isNull").show();
	        opt['field'].next(".error-tooltip").find(".checkObj").hide();
			return false;
		}
	},
	
	//ajaxEmail邮箱是否重复的验证
	ajaxEmail: function(str, opt){
		if( opt['tools']['isEmail'](str) == true ){
			opt['field'].next(".error-tooltip").find(".checkEmail").show();
	        opt['field'].next(".error-tooltip").find(".emailNull").hide();
	        return this.ajaxValidate(str, opt);
		} else {
	        opt['field'].triggerHandler('Validate', [false, 'err']);
	        opt['field'].next(".error-tooltip").find(".emailNull").show();
	        opt['field'].next(".error-tooltip").find(".checkEmail").hide();
			return false;
		}
	},
	
	//ajaxMobile手机号是否重复的验证
	ajaxMobile: function(str, opt){
		if( opt['tools']['isPhone'](str) == true ){
			opt['field'].next(".error-tooltip").find(".checkObj").show();
	        opt['field'].next(".error-tooltip").find(".isNull").hide();
	        return this.ajaxValidate(str, opt);
		} else {
	        opt['field'].triggerHandler('Validate', [false, 'err']);
	        opt['field'].next(".error-tooltip").find(".isNull").show();
	        opt['field'].next(".error-tooltip").find(".checkObj").hide();
			return false;
		}
	},
	
	//检验是否为时间格式(19:30)
	isnotHourMinute1: function(str, opt){
		var reg = /^(([0-1]\d)|(2[0-3])):[0-5]\d$/;
		var result = reg.test(str);
		
		if(result){
			opt["field"].nextAll(".errHourMinute1").eq(0).hide();
		} else {
			opt["field"].nextAll(".errHourMinute1").eq(0).show();
		}
		return result;
	},
	isnotHourMinute2: function(str, opt){
		var reg = /^(([0-1]\d)|(2[0-3])):[0-5]\d$/;
		var result = reg.test(str);
		
		if(result){
			opt["field"].nextAll(".errHourMinute2").eq(0).hide();
		} else {
			opt["field"].nextAll(".errHourMinute2").eq(0).show();
		}
		return result;
	}
});
})(jQuery);




//ajax提交一个form
(function($) {
$.widget("wdg.ajaxForm", {
	options: {
		ajaxOptions: {
			type: 'POST',
			dataType: 'text'
		}
	},

	_create: function(){
		if( this.element.is('form') ){
			this.form = this.element;
		} else {
			this.form = this.element.closest('form');
			if( this.form.length == 0 ){
				return false;
			}
			//如果element是普通按钮或链接，则自动绑定submit
			if( ! this.element.is(':submit') ){
				var self = this;
				self.element.click(function(){
					self.form.submit();
					return false;
				});
			}
		}
		if( $.isPlainObject(this.options.validate) || this.options.validate == true ){
			if( this.options.validate == true ){
				var vdOpt = {bindSubmit: false};
			} else {
				var vdOpt = $.extend({}, this.options.validate, {bindSubmit: false});
				this.options.validate = true;
			}
			this.form.validate(vdOpt);
		}
		this.bindSubmit();
	},

	_ajaxSubmit: function(){
		var self = this;
		var ajaxOpt = $.extend({}, this.options.ajaxOptions, {
			url: this.form.attr('action'),
			type: this.form.attr('method'),
			data: this.form.serializeArray()
		});
		if( ajaxOpt.cache === false || this.options.cache === false ){
			ajaxOpt.url += (ajaxOpt.url.indexOf('?') > -1 ? '&' : '?') + '_=' + (new Date()).getTime();
		}
		var success = $.isFunction(ajaxOpt.success) ? ajaxOpt.success : $.isFunction(this.options.success) ? this.options.success : function(){};
		ajaxOpt.success = function(data, ts){
			self.form.removeData('ajaxFoumSubmiting');
			success.call(self.form, data, self.form, ts);
		}
		this.form.data('ajaxFoumSubmiting', true);
		if( this.form.find(':file').length && $.ajaxFileUpload ){
			ajaxOpt['fileElementId'] = this.form.find(':file:first');
			ajaxOpt['secureuri'] = false;
			$.ajaxFileUpload(ajaxOpt);
		} else {
			$.ajax(ajaxOpt);
		}
	},

	bindSubmit: function(){
		var self = this;
		this.form.bind('submit.ajaxForm', function(event){
			if( self.form.data('ajaxFoumSubmiting') != true ){
				if( self._trigger('beforeSubmit', null, self.form) !== false ){
					if( self.options.validate == true ){
						self.form.triggerHandler('ValidateForm', [function(result){
							if( result == true ){
								self._ajaxSubmit();
							}
						}]);
					} else {
						self._ajaxSubmit();
					}
				}
			}
			event.preventDefault();
		});
	}
});
})(jQuery);


/* 瀑布流样式组件，需要jqueryui.core ******************************************/
;(function($) {
$.widget('wdg.waterfall', {
	options: {
		itemCtx: 'div.item',
		itemWidth: 200,		//显示块的宽度
		minColumCount: 2,	  //最小显示列
		gap: 10,			   //行列之间的间隔
		resizeInterval: 250,   //窗口宽度改变的时间间隔
		showInterval: 50,	  //每个显示块的显示时间间隔， 0 时将直接显示
		showOvertime: 5,
		itemSort: false,	   //显示块dom对象是否重新排列
		resizeRefresh: true	//是否允许容器宽度改变重刷显示
	},

	_create: function(){
		this.curShow = 0;
		this.showedList = [];
		this.showingList = [];
		this.tmShowing = null;
		this.tmOvertime = null;
		this.columsCount = this._getColumsCount();
		if( this.options.resizeRefresh == true ){
			var self = this, tmResize = null;
			$(window).resize(function(){
				if( tmResize != null ){
					clearTimeout(tmResize);
					tmResize == null;
				}
				tmResize = setTimeout(function(){
					var cc = self._getColumsCount();
					if( self.columsCount != cc ){
						self.columsCount = cc;
						self._init();
					}
				}, self.options.resizeInterval);
			});
		}
	},

	_init: function(){
		this.curList = this.element.find(this.options.itemCtx);
		this.curList.css({opacity: 0, top: 0, left: 0});
		this.colums = [];
		for( var i = 0; i < this.columsCount; i++ ){
			this.colums.push({
				left: i * (this.options.itemWidth + this.options.gap),
				height: 0,
				items: []
			});
		}
		if( this.showedList.length == 0 ){
			this.showingList = [];
			this.show();
		} else {
			this.curShow = 0;
			this.showingList = this.showedList;
			this.showedList = [];
			this._showItem();
		}
	},

	show: function(list){
		var self = this;
		if( list ) this.curList = list;
		this.curListLength = this.curList.length;
		var checkOvertime = function(){
			self.showOvertime ++;
			if( self.showOvertime < self.options.showOvertime ){
				self.tmOvertime = setTimeout(checkOvertime, 1000);
			} else {
				self.showOvertime = 0;
				self.curListLength = self.showingList.length;
				self._showItems();
			}
		}
		this.showOvertime = 0;
		this.tmOvertime = setTimeout(checkOvertime, 1000);
		this.curList.each(function(){
			var item = $(this);
			if( item.attr('loaded') == 'true' ){
				self._showItems(item);
			} else {
				item.attr('loaded', 'false');
				self.loadItem(item);
			}
		});
	},

	loadItem: function(item){
		var self = this, img = item.find('img');
		if( img.length && img.height() == 0 ){
			item.data('loading', true);
			img.load(function(){
				setTimeout(function(){
					item.removeData('loading');
					item.attr('loaded', 'true');
					self._showItems(item);
				}, 100);
			});
		} else {
			item.attr('loaded', 'true');
			self._showItems(item);
		}
	},

	append: function(list){
		this._trigger('beforeAppend', $.Event('append'), list);
		this.element.append(list);
		this.showingList = [];
		this.show(list.css({opacity: 0, top: 0, left: 0}));
	},

	removeItem: function(item){
		var info = item.data('colInfo'), items = info.col.items;
		items.splice(info.colIndex, 1);
		item.slideUp(200, function(){
			for( var i = info.colIndex; i < items.length; i++){
				var obj = items[i].data('colInfo');
				obj.top -= info.height;
				obj.colIndex = i;
				obj.colHeight -= info.colHeight;
				items[i].data('colInfo', obj).css('top', obj.top + 'px');
			}
			info.col.height = items.length ? items[items.length - 1].data('colInfo')['colHeight'] : 0;
		});
	},

	setItemHeight: function(item){
		var info = item.data('colInfo'), items = info.col.items, oldHeight = info.height;
		info.height = item.outerHeight() + this.options.gap;
		var h = info.height - oldHeight;
		info.colHeight += h;
		item.data('colInfo', info);
		for( var i = info.colIndex + 1; i < items.length; i++ ){
			var obj = items[i].data('colInfo');
			obj.top += h;
			obj.colHeight += h;
			items[i].data('colInfo', obj).css('top', obj.top + 'px');
		}
		info.col.height = items[items.length - 1].data('colInfo')['colHeight'];
	},

	_showItems: function(item){
		if( item ) this.showingList.push(item);
		if( this.showingList.length >= this.curListLength ){
			clearTimeout(this.tmOvertime);
			this._trigger('beforeShow', $.Event('showItem'), this);
			this._showItem();
		}
	},

	_showItem: function(){
		var self = this;
		if( this.options.showInterval == 0 ){
			this._showx();
		} else {
			var self = this;
			if( this.tmShowing != null ) return;
			this.tmShowing = setTimeout(function(){
				self.tmShowing = null;
				self._showx();
			}, this.options.showInterval);
		}
	},

	_showx: function(){
		if( this.showingList.length == 0 ){  //最后一个显示结束
			this.element.height(this._getContHeight());
			this._trigger('showEnd', $.Event(), this);
			this.curListLength = 0;
			return;
		}

		var item = $(this.showingList.shift());
		var self = this, options = this.options;
		var minColum = this._getMinHeightColum();
		var pos = {left: minColum.left, top: minColum.height};
		this._trigger('showItem', $.Event('showx'), item);
		if( options.itemSort == true ) this.element.append(item);
		item.css({
			opacity: 1,
			left: pos.left + 'px',
			top: pos.top + 'px'
		}).attr('showed', ++this.curShow).data('colInfo', {
			left: pos.left,
			top: pos.top,
			height: item.outerHeight() + options.gap,
			col: minColum,
			colIndex: minColum.items.length,
			colHeight: minColum.height + item.outerHeight() + options.gap
		});
		minColum.items.push(item);
		minColum.height = item.data('colInfo')['colHeight'];
		this.showedList.push(item);

		this._showItem();
	},

	_getMinHeightColum: function(){
		var col = this.colums[0];
		for( var i = 1; i < this.columsCount; i++ ){
			if( col.height > this.colums[i].height ){
				col = this.colums[i];
			}
		}
		return col;
	},

	_getContHeight: function(){
		var h = this.colums[0].height;
		for( var i = 1; i < this.columsCount; i++ ){
			if( h < this.colums[i].height ){
				h = this.colums[i].height;
			}
		}
		return h;
	},

	_getColumsCount: function(){
		this.contWidth = this.element.width();
		return Math.max(this.options.minColumCount, parseInt((this.contWidth + this.options.gap) / (this.options.itemWidth + this.options.gap), 10));
	}
});
})(jQuery);


//为文本输入框绑定显示默认提示
jQuery.fn.showPlaceholder = function(options){
	options = $.extend({
		bindSubmit: true,
		tipsColor: '#6B7074',
		textColor: $.browser.msie ? '#333333' : 'inherit'
	}, options || {});
	return this.each(function(){
		var tf = $(this);
		var isIE = jQuery.support.htmlSerialize == false || !('placeholder' in this);
		if( ! tf.attr('placeholder') ) return true;
		if( tf.data('showPlaceholder') ){
			var opt = $.extend(tf.data('showPlaceholder'), options);
			if( tf.val() == '' || tf.val() == tf.attr('placeholder') ){
				tf.css('color', opt.tipsColor);
				if (tf.val() == '' && isIE ){
					tf.val(tf.attr('placeholder'));
				}
			}
			tf.data('showPlaceholder', opt);
			return true;
		}
		if( tf.val() == '' ) tf.css('color', options.tipsColor);
		if( isIE ){
			var form = tf.closest('form');
			if( form.length ){
				if( options.bindSubmit ){
					form.submit(function(){
						if( tf.val() == tf.attr('placeholder') ){
							tf.val('');
						}
					});
				}
			}
			tf.bind('blur.showPlaceholder', function(){
				var opt = tf.data('showPlaceholder') || options;
				if( tf.val() == '' ){
					tf.val(tf.attr('placeholder')).css('color', opt.tipsColor);
				}
			});
			tf.bind('focus.showPlaceholder click.showPlaceholder', function(){
				var opt = tf.data('showPlaceholder') || options;
				if( tf.val() == tf.attr('placeholder') ) tf.val('');
				tf.css('color', opt.textColor);
			});
			tf.triggerHandler('blur.showPlaceholder');
		} else {
			tf.bind('input.showPlaceholder', function(){
				var opt = tf.data('showPlaceholder') || options;
				tf.css('color', (tf.val() == '') ? opt.tipsColor : opt.textColor);
			});
		}
		tf.data('showPlaceholder', options);
	});
};


//自动验证输入字符表单的长度
jQuery.fn.checkFieldLength = function( options ){
	options = $.extend({
		cnWord: false
	}, options || {});
	return this.each(function(){
		var field = $(this);
		if( field.data('bindCheckFieldLength') == true ){
			return true;
		}
		var maxlen = options.maxlength || parseInt(field.attr('maxlength'), 10) || 200;
		maxlen = maxlen > 0 ? maxlen : 200;
		var tm = null;
		var checkLength = function(){
			var text = field.val();
			if( field.data('oldtext') == text ){
				clearInterval(tm);
				tm = null;
			} else {
				field.data('oldtext', text);
			}
			if( $.isFunction(options.cutWord) ){
				text = options.cutWord(text, maxlen, '');
			} else {
				text = text.slice(0, maxlen);
			}
			if( text != field.val() ){
				field.val(text).scrollTop(999);
			}
			var l = Math.max(0, maxlen - ( options.cnWord == true ? text.length : text.replace(/[^\x00-\xff]/g, 'AA').length ));
		};
		if( parseInt(maxlen, 10) > 0 ){
			maxlen = parseInt(maxlen, 10);
			field.data('bindCheckFieldLength', true)
				.bind('focus paste', function(){
					setTimeout(function(){
						checkLength();
					}, 50);
				})
				.bind('keydown mousedown', function(){
					if( tm != null ){ return true; }
					tm = setInterval(checkLength, 100);
				})
				.bind('keyup mouseup blur', function(){
					clearInterval(tm);
					tm = setTimeout(function(){
						checkLength();
					}, 50);
				});
		}
	});
};


//通过一个链接或按钮选择文件上传
jQuery.fn.uploadFile = function(options){
	options = $.extend({
		type: 'submit',
		dataType: 'json'
	}, options || {});
	return this.each(function(i){
		var btn = $(this), fID = options.name + (new Date()).getTime(), btnBox = {width: btn.outerWidth(), height: btn.outerHeight()};
		var form = null, fileBase = $('<input type="file" id="' + fID + '" name="' + options.name + '" />').css($.extend({display:'block', padding:0, width:'220px', height:'30px', cursor:'pointer'}, options.style || {}));
		if( options.type != 'form' ){
			if( options.type == 'ajax' && ! jQuery.ajaxFileUpload ) throw 'uploadFile missing argument: ajaxFileUpload';
			form = $('<form action="' + options.action + '" method="post" enctype="multipart/form-data"></form>').append(fileBase.clone());
			$('body').append(form.css({display: 'none', opacity: 0}));
		} else {
			form = $(options.form).css({display: 'none', opacity: 0});
		}
		var evt = 'mousemove.uf_' + options.name + '_' + i;
		var changeSubmit = function(){
			var f = $(this);
			if( $.isFunction(options.onChange) ){
				options.onChange.call(f, btn);
			}
			if( options.type == 'ajax' ){
				$.ajaxFileUpload({
					fileElementId: fID,
					secureuri: false,
					dataType: options.dataType,
					url: options.action,
					success: function(data){
						f.removeAttr('disabled');
						if( $.isFunction(options.success) ) options.success(data);
						form.empty().append(fileBase.clone());
					}
				});
			} else {
				f.closest('form').trigger('submit');
			}
			hideFile();
			setTimeout(function(){
				f.attr('disabled', true);
			}, 50);
		}
		var hideFile = function(){
			form.css({
				display: 'none',
				position: 'static',
				zIndex: 0
			});
			$(document).unbind(evt);
		}
		var fileMove = function(event){
			if( event.pageX < btnBox.left || event.pageY < btnBox.top || event.pageX > btnBox.right || event.pageY > btnBox.bottom ){
				hideFile();
			} else {
				form.css({
					left: (event.pageX - 200) + 'px',
					top: (event.pageY - 10) + 'px'
				});
			}
		}
		form.delegate(':file', 'change', changeSubmit);
		btn.bind('mouseenter', function(event){
			var os = btn.offset();
			btnBox.top = os.top; btnBox.left = os.left;
			btnBox.bottom = os.top + btn.outerHeight(); btnBox.right = os.left + btn.outerWidth();
			form.css({
				display: 'block',
				position: 'absolute',
				zIndex: 2147483583,
				left: 0,
				top: 0
			}).appendTo('body');
			fileMove(event);
			$(document).bind(evt, fileMove);
		});
	});
}


//字数超长时截字
jQuery.fn.ellipsis = function(options){
	options = $.extend({
		updating: false,
		instr: '...'
	}, options || {});
	var s = document.documentElement.style;
	if(!('textOverflow' in s || 'oTextOverflow' in s )){
		return this.each(function(){
			var el = $(this);
			if(el.css('overflow') == "hidden"){
				el.css({
					'wordBreak': 'keep-all',
					'wordWrap': 'normal',
					'whiteSpace': 'nowrap'
				});
				var originalText = el.html();
				var w = parseInt(el.attr('textOverflow')) || el.width();
				var t = $(this.cloneNode(true)).hide().css({
					'position':'absolute',
					'overflow':'visiable',
					'width':'auto',
					'max-width':'inherit'
				});
				el.after(t);

				var text = originalText;
				while(text.length > 0 && t.width() > w){
					text = text.substr(0, text.length-1)
					t.html(text + options.instr);
				}
				el.html(t.html());
				t.remove();

				if(options.updating == true){
					var oldW = w;
					setInterval(function(){
						if(el.width() != oldW){
							oldW = el.width();
							el.html(originalText);
							el.ellipsis();
						}
					},200);
				}
			}
		})
	} else {
		return this.each(function(){
			$(this).css({
				'wordBreak': 'keep-all',
				'wordWrap': 'normal',
				'whiteSpace': 'nowrap'
			});
		});
	}
}


