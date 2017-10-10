/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.tarmag.vo.InvitationVo;

/**
 * @author raymond
 *
 */
public interface IInvitationService {
	
	/**
	 * 获取邀约
	 * 
	 * @param inviterId 发起人
	 * @param houseId   当前房屋
	 * @param inviteeId 受邀人
	 * @return
	 */
	public List<Map<String, Object>> findInvitations(Long inviterId, Long houseId, Long inviteeId, int pageNo);
	
	/**
	 * 获取发出的邀约明细
	 * @param id 邀约的id
	 * @return
	 */
	public Map<String, Object> findInvitation(Long id);
	/**
	 * 获取发出的邀约明细
	 * @param id 邀约的id
	 * @return
	 */
	public Map<String, Object> findReceptionInvitation(Long id);

	/**
	 * 新增邀约
	 * @param invitation
	 * @param resident
	 */
	public void addInvitation_tx(InvitationVo invitationVo);

	/**
	 * 获取二维码字符串
	 * @param id
	 * @return
	 */
	Map<String, Object> getQrCode(Long id);
}
