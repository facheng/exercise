package com.dt.tarmag.api.ihome;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.service.IAppMenuService;
import com.dt.tarmag.util.MsgKey;

@Controller
@RequestMapping("ihome/appmenu")
public class IHomeAppMenuController extends AbstractDtController{
	
	@Autowired
	private IAppMenuService appMenuService;
	
	@RequestMapping(value="menus", method=GET)
	@ResponseBody
	protected MsgResponse menus(Long unitId){
		MsgResponse response = null;
		try {
			if(unitId != null){
				response = new Success("menus", this.appMenuService.getAppMenuListByUnitId(unitId));
			}else{
				response = new Success("menus", this.appMenuService.getAppMenuList());
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
	
	
	@RequestMapping(value="resident/menus", method=GET)
	@ResponseBody
	protected MsgResponse residentMenus(Long residentId,Long unitId){
		MsgResponse response = null;
		try {
			if(residentId != null){
				response = new Success("menus", this.appMenuService.getResidentAppMenuList(residentId,unitId));
			}else{
				response = new Fail(MsgKey._000000006);
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
	
	@RequestMapping(value="resident/menu/create", method=POST)
	@ResponseBody
	protected MsgResponse residentMenuC(Long residentId,Long appMenuId){
		MsgResponse response = null;
		try {
			if(residentId != null && appMenuId != null){
				this.appMenuService.addResidentMenu_tx(residentId, appMenuId);
				response = new Success();
			}else{
				response = new Fail(MsgKey._000000006);
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
	
	@RequestMapping(value="resident/menu/delete", method=POST)
	@ResponseBody
	protected MsgResponse residentMenuD(Long residentId,Long appMenuId){
		MsgResponse response = null;
		try {
			if(residentId != null && appMenuId != null){
				this.appMenuService.deleteResidentMenu_tx(residentId, appMenuId);
				response = new Success();
			}else{
				response = new Fail(MsgKey._000000006);
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
	
	@RequestMapping(value="livemenus", method=GET)
	@ResponseBody
	protected MsgResponse livemenus(){
		MsgResponse response = null;
		try {
			response = new Success("menus", this.appMenuService.getLiveAppMenu());
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
	
	/**
	 * 获取生活秘籍
	 * @return
	 * 
	 */
	@RequestMapping(value="lifecheats", method=GET)
	@ResponseBody
	protected MsgResponse lifecheats(){
		MsgResponse response = null;
		try {
			response = new Success("menus", this.appMenuService.getLiveCheats());
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
	
}
