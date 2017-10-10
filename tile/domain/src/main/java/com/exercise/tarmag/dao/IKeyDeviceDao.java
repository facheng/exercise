/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.dao;

import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.KeyDevice;
import com.dt.tarmag.vo.KeyDeviceSearchVo;

/**
 * @author 👤wisdom 
 *
 */
public interface IKeyDeviceDao extends Dao<KeyDevice, Long> {
	
	/**
	 * 根据房屋id 获取对应的钥匙 用于发送邀约中的钥匙
	 * @param houseId
	 * @return
	 */
	public List<KeyDevice> findKeyDevice(Long houseId);
	
	/**
	 * 根据小区和楼栋id获取钥匙列表
	 * @param unitId 小区id
	 * @param storyIds 楼栋id
	 * @return
	 */
	public List<Map<String, Object>> findkeyDevice(Long unitId, List<Long> storyIds);
	
	/**
	 * 查询钥匙设备个数
	 * @param unitId
	 * @param vo
	 * @return
	 */
	int getKeyDeviceCount(long unitId, KeyDeviceSearchVo vo);
	
	/**
	 * 查询钥匙设备集合
	 * @param unitId
	 * @param vo
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<KeyDevice> getKeyDeviceList(long unitId, KeyDeviceSearchVo vo, int pageNo, int pageSize);
	/**
	 * 根据小区获取钥匙
	 * @param unitId
	 * @return
	 */
	List<KeyDevice> getKeyDeviceListByUnitId(long unitId);

	
	/**
	 * 通过钥匙地址查询钥匙
	 * @param deviceAddress
	 * @return
	 */
	public KeyDevice getKeyDeviceByAddress(String deviceAddress);
	/**
	 * 通过钥匙ID获取小区ID
	 * @param keyId
	 * @return
	 */
	public int getUnitIdByKeyId(Long keyId);
	/**
	 * 根据小区和楼栋获取钥匙列表
	 * @param unitId 小区id
	 * @param storyId 楼栋id
	 * @return
	 */
	public List<KeyDevice> findkeyDeviceByUnitAndStory(Long unitId, Long storyId);
}
