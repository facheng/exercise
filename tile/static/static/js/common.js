
function check(){
	var b = true;

	/**
	 * 任意字符(必填)
	 */
	$(".not_empty").each(function(){
		var v = $.trim($(this).val());
		if(v == "") {
			$(this).next("div").show();
			b = false;
		} else {
			$(this).next("div").hide();
		}
	});

	/**
	 * 下拉列表不能选0(必选)
	 */
	$(".not_select_0").each(function(){
		var v = $(this).val();
		if(v == 0) {
			$(this).next("div").show();
			b = false;
		} else {
			$(this).next("div").hide();
		}
	});

	/**
	 * radio不能选0(必选)
	 */
	$(".not_select_radio").each(function(){
		var rchecked = false;
		var rdd = $(this);
		rdd.find('[type="radio"]').each(function(){
			if($(this).is(":checked") && $(this).val() > 0) {
				rchecked = true;
			}
		});
		
		if(rchecked) {
			rdd.next("div").hide();
		} else {
			rdd.next("div").show();
			b = false;
		}
	});

	/**
	 * checkbox不能选0(必选)
	 */
	$(".not_select_checkbox").each(function(){
		var rchecked = false;
		var rdd = $(this);
		rdd.find('[type="checkbox"]').each(function(){
			if($(this).is(":checked") && $(this).val() > 0) {
				rchecked = true;
			}
		});
		
		if(rchecked) {
			rdd.next("div").hide();
		} else {
			rdd.next("div").show();
			b = false;
		}
	});

	/**
	 * 必须是大于0的数字(必填)
	 */
	$(".larger_than_zero").each(function(){
		var v = $.trim($(this).val());
		if($.isNumeric(v) && v > 0) {
			$(this).next("div").hide();
		} else {
			$(this).next("div").show();
			b = false;
		}
	});

	/**
	 * 必须是大于0的数字(选填)
	 */
	$(".larger_than_zero1").each(function(){
		var v = $.trim($(this).val());
		if(v == "" || $.isNumeric(v) && v > 0) {
			$(this).next("div").hide();
		} else {
			$(this).next("div").show();
			b = false;
		}
	});

	/**
	 * 必须是大于或等于0的数字(选填)
	 */
	$(".larger_than_zero2").each(function(){
		var v = $.trim($(this).val());
		if(v == "" || $.isNumeric(v) && v >= 0) {
			$(this).next("div").hide();
		} else {
			$(this).next("div").show();
			b = false;
		}
	});
	
	return b;
}


$(document).ready(function(){
	$(".clear-data").on("keydown", function(e){
		e = e || event;
		currKey = e.keyCode || e.which || e.charCode;
		if(currKey == 8) {
			$(this).val("");
		}
		return false;
	});
	
	$(".btn-submit").on("click", function(){
		$('.black-opacity').fadeIn();
		$(this).closest("form").submit();
	});
	
	$(".click-disappear").on("click", function(){
		$(this).fadeOut();
	});
	
	$(".auto-submit").bind("keypress", function(e){
		e = e || event;
		if (e.keyCode == '13') {
			$(this).closest("form").submit();
		}
	});
	
	$('.selectAll').click(function(){
		if ($(this).is(':checked') == true) {
			$(this).closest("table").find('td input[type="checkbox"]').attr("checked", true);
		} else {
			$(this).closest("table").find('td input[type="checkbox"]').attr("checked", false);
		}
	});
});