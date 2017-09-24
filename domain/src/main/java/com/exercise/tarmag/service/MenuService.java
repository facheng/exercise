/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.BeanUtil;
import com.dt.framework.util.Page;
import com.dt.tarmag.dao.IMenuDao;
import com.dt.tarmag.model.Menu;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.util.Params;

/**
 * @author raymond
 *
 */
@Service
public class MenuService implements IMenuService {

	@Autowired
	private IMenuDao menuDao;

	@Override
	public List<Menu> findAll() {
		return this.menuDao.findAllParents();
	}

	@Override
	public void saveMenu_tx(Menu menu) {
		if (menu.getId() == 0l) {
			menu.setCode(this.menuDao.getMaxCode(Params.getParams("parentId",
					menu.getParentId())));
			this.menuDao.save(menu);
		} else {
			Menu entity = this.menuDao.get(menu.getId());
			BeanUtil.copyProperty(menu, entity);
			this.menuDao.update(entity);
		}
	}

	@Override
	public void delete_tx(Long[] ids) {
		if (ids == null)
			return;
		for (Long id : ids) {
			this.menuDao.deleteByKey(id);
		}
	}

	@Override
	public PageResult<Map<String, Object>> findMenu(Map<String, Object> params,
			Page page) {
		return this.menuDao.findMenu(params, page);
	}

	@Override
	public Menu findMenuById(long id) {
		return this.menuDao.get(id);
	}
}
