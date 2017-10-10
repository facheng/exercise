package com.dt.tarmag.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.model.Menu;
import com.dt.tarmag.service.IMenuService;
import com.dt.tarmag.util.DataTableParams;
import com.dt.tarmag.util.DataTableResult;
import com.dt.tarmag.util.MsgKey;

@RequestMapping("sysmenu")
@Controller
public class SysMenuController extends AbstractDtController {
	@Autowired
	private IMenuService menuService;

	@RequestMapping("index")
	protected String index() {
		return "admin/menu/index";
	}

	@RequestMapping("all")
	@ResponseBody
	protected List<Menu> all() {
		return this.menuService.findAll();
	}

	@RequestMapping("menus")
	@ResponseBody
	protected JSONObject findMenu(final Menu menu, final DataTableParams params) {
		JSONObject resultJson = new JSONObject();
		try {
			resultJson = DataTableResult.toJSONObject(
					params,
					this.menuService.findMenu(menu.toMap(null, true),
							params.getPage()));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return resultJson;
	}

	@RequestMapping("entity")
	protected String entity(final ModelMap map, Menu menu) {
		if (menu.getId() != 0l) {
			menu = this.menuService.findMenuById(menu.getId());
		}
		map.put("entity", menu);
		return "admin/menu/entity";
	}

	@RequestMapping("save")
	@ResponseBody
	protected MsgResponse save(final HttpSession session, final Menu menu) {
		try {
			this.menuService.saveMenu_tx(menu);
			return new Success(MsgKey._000000001);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Fail(MsgKey._000000002);
		}
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public MsgResponse delete(@RequestParam("ids") final Long[] ids) {
		try {
			this.menuService.delete_tx(ids);
			return new Success(MsgKey._000000003);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Success(MsgKey._000000004);
		}
	}
}
