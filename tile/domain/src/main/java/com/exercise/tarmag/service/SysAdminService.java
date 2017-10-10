/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.dao.redis.IRedisDao;
import com.dt.framework.util.SecurityUtil;
import com.dt.tarmag.dao.ISysAdminDao;
import com.dt.tarmag.model.Menu;
import com.dt.tarmag.model.SysAdmin;

/**
 * @author raymond
 *
 */
@Service
public class SysAdminService implements ISysAdminService{
	@Autowired
	private ISysAdminDao sysAdminDao;
	
	@Autowired
	private IRedisDao redisDao;
	
	@Override
	@SuppressWarnings("all")
	public Map<String, Object> login(final String userName, final String password) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		SysAdmin loginAdmin = this.sysAdminDao.getSysAdmin(userName);
		if(loginAdmin == null||!loginAdmin.getPassword().equals(SecurityUtil.getMD5(password))){
			resultMap.put("errmsg", "用户名或密码错误");
			resultMap.put("user", new HashMap<String, Object>(){
				private static final long serialVersionUID = 1L;
				{
					this.put("userName", userName);
					this.put("password", password);
				}
			});
		}else{
			resultMap.put("menus", this.sysmenus());
			resultMap.put("user", loginAdmin);
		}
		return resultMap;
	}

	@Override
	@SuppressWarnings("all")
	public Map<Menu, List<Menu>> sysmenus() {
		Map<Menu, List<Menu>> menuMap = new TreeMap<Menu, List<Menu>>(new Comparator<Menu>() {
			@Override
			public int compare(Menu m1, Menu m2) {
				return m1.getSeq()-m2.getSeq();
			}
		});
		try {
			SAXReader saxReader = new SAXReader();
			Document document = saxReader.read(this.getClass().getClassLoader().getResourceAsStream("sysmenu.xml"));
			Element mels = document.getRootElement();
			List<Element> els = mels.elements();
			
			for(Element mel : els){
				menuMap.putAll(this.getMenuMap(mel));
			}
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return menuMap;
	}
	
	@SuppressWarnings("all")
	protected Map<Menu, List<Menu>> getMenuMap(Element el){
		Map<Menu, List<Menu>> map = new TreeMap<Menu, List<Menu>>(new Comparator<Menu>() {
			@Override
			public int compare(Menu m1, Menu m2) {
				return m1.getSeq()-m2.getSeq();
			}
		});
		Element childel = el.element("children");
		List<Menu> menus = new ArrayList<Menu>();
		if(childel != null){
			List<Element> els = childel.elements();
			for(Element cel : els){
				menus.add(this.getMenu(cel));
			}
		}
		map.put(this.getMenu(el), menus);
		return map;
	}
	
	protected Menu getMenu(Element element){
		Menu menu = new Menu();
		menu.setId(Long.valueOf(element.elementText("id")));
		menu.setCode(element.elementText("code"));
		menu.setSeq(Integer.valueOf(element.elementText("seq")));
		menu.setUrl(element.elementText("url"));
		menu.setTitle(element.elementText("title"));
		return menu;
	}
}
