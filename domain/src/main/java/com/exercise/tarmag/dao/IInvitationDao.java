/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.dao;

import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.Invitation;

/**
 * @author 👤wisdom
 *
 */
public interface IInvitationDao extends Dao<Invitation, Long> {
	
	/**
	 * 获取邀约
	 * @return
	 */
	public List<Map<String, Object>> findInvitations(Map<String, Object> params, int pageNo);

	/**
	 * 获取发出的邀约明细
	 * @param id
	 */
	public Map<String, Object> findInvitation(Long id);
	
	/**
	 * 获取收到的邀约明细
	 * @param id
	 */
	public Map<String, Object> findReceptionInvitation(Long id);
}
