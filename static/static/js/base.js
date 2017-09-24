// JavaScript Document
$(function(){
	
	//绑定业主弹层
	$('.bind-hoster-btn').live('click',function(){
		$('.dialog-bind-hoster,.black-opacity').fadeIn();
	})
	$('.modify-hoster-btn,.unbind-hoster-btn').live('click',function(){
		$('.dialog-modify-hoster,.black-opacity').fadeIn();
	})
	$('.editInfo-con').live('click',function(){
		
		$(this).find('span').toggleClass('choiceBtn');
		
		$(this).siblings('.editInfo-con').find('span').removeClass('choiceBtn');
	})
	$('.modify-confirm-btn').live('click',function(){
		$('.dialog-modify-hoster').hide();
		$('.dialog-bind-hoster').show();
	})
	$('.delete-hosterInfo-btn').live('click',function(){
		$('.dialog-delete-info,.black-opacity').fadeIn();
	})
	$('.add-hoster-btn').live('click',function(){
		$('.dialog-add-hoster,.black-opacity').fadeIn();
	})
	$('.import-tmpl-btn').live('click',function(){
		$('.set-house-position,.black-opacity').fadeIn();
	})
	$('.import-confirm-btn').live('click',function(){
		$('.set-house-position').hide();
		$('.dialog-importing').show();
	})
	
	//close popup
	$('.dialog-close', '.dialog').click(function(){
		$('.dialog, .black-opacity').fadeOut();
	});
	$('.black-opacity').click(function(){
		$('.dialog-close', '.dialog').click();
	});
	//close popup
	
	
	$('.rol-sel-list').live('click',function(){
		$(this).find('.role-sel-code').toggleClass('hideOrshow');
	})	
	$('.role-sel-code').find('li').live('click',function(){
		var text=$(this).text();
		$(this).parents('.rol-sel-list').find('.role-result').text(text).removeClass('role-no-sel');
	})
	
	
	/*publish-new-notice.html*/
	$('.wuye-radio,.juweihu-radio').live('click',function(){
		$('.wuye-content-hide').show();
		$('.kuadi-content-hide').hide();
	})
	$('.kuaidi-radio').live('click',function(){
		$('.wuye-content-hide').hide();
		$('.kuadi-content-hide').show();
	})
	
	$('.msgAddBtn').live('click',function(){
		$('.dialog-choose-obj,.black-opacity').fadeIn();
	})
	$('.modify-notice-btn').live('click',function(){
		$('.dialog-modify-notice,.black-opacity').fadeIn();
	})
	
	/*publish-new-notice.html*/
	
	
	/*house-manage-detail.html start*/
	
	$('.modify-houseInfo-btn').live('click',function(){
		$('.dialog-modify-house-info,.black-opacity').fadeIn();
	})

	/*house-manage-detail.html end*/
	
	/*focus-hoster.html start*/
	
	$('.blacklist').live('mouseenter',function(){
		$(this).find('.tooltip').addClass('hover');
	});
	$('.blacklist').live('mouseleave',function(){
		$(this).find('.tooltip').removeClass('hover');
	});
	
	$('.modify-focus-btn').live('click',function(){
		$('.dialog-modify-focus-hoster,.black-opacity').fadeIn();
	})
	$('.ownersBlacklistAdd').live('click',function(){
		$(this).find('span').toggleClass('choiceBtn');
		$(this).siblings('.editInfo-con').find('span').removeClass('choiceBtn');
	})
	$('.delete-focus-hoster').live('click',function(){
		$('.dialog-delete-focus-hoster,.black-opacity').fadeIn();
	})
	
	$(".all-choose").click(function () {//全选  
		$(".focus-host-tbl :checkbox").attr("checked", true);  
	});  

	$(".none-choose").click(function () {//全不选  
		$(".focus-host-tbl :checkbox").attr("checked", false);  
	});  

	$(".reverse-choose").click(function () {//反选  
		$(".focus-host-tbl :checkbox").each(function () {  
			$(this).attr("checked", !$(this).attr("checked"));  
		});  
	});  
	
	
	/*focus-hoster.html end*/
	
})