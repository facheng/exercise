useDefSubmit = false;
$(document).ready(function(){
	var login = $('#loginform');
	login.validate();
	var recover = $('#recoverform');
	recover.validate();
	var speed = 400;

	$('#to-recover').click(function(){
		$("#loginform").slideUp();
		$("#recoverform").fadeIn();
	});
	$('#to-login').click(function(){
		
		$("#recoverform").hide();
		$("#loginform").fadeIn();
	});
	
	$("input[name='passWord']").keypress(function(e){
		if(e.keyCode == 13){
            $("#login").click();
        }
	});
	
	$(document).keypress(function(e){
		if(e.keyCode == 13){//回车登陆
			$("#login").click();
		}
	});
	
	$('#login').click(function(){
		login.submit();
	});
	
	$("#loginbox").css("margin-top", ($(window).height()-$("#loginbox").height())/2);
    $(window).resize(function(){
    	$("#loginbox").css("margin-top", ($(window).height()-$("#loginbox").height())/2);
    });
    if($.browser.msie == true && $.browser.version.slice(0,3) < 10) {
        $('input[placeholder]').each(function(){ 
	        var input = $(this);       
	        $(input).val(input.attr('placeholder'));
	        $(input).focus(function(){
	             if (input.val() == input.attr('placeholder')) {
	                 input.val('');
	             }
	        });
	        $(input).blur(function(){
	            if (input.val() == '' || input.val() == input.attr('placeholder')) {
	                input.val(input.attr('placeholder'));
	            }
	        });
	    });
    }
});