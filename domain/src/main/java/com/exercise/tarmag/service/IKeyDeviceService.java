/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.springframework.ui.ModelMap;

import com.dt.tarmag.vo.KeyDeviceSearchVo;
import com.dt.tarmag.vo.KeyDeviceVo;

/**
 * @author 👤wisdom
 *
 */
public interface IKeyDeviceService {
	/**
	 * 获取钥匙
	 * 
	 * @param tokenId
	 * @return
	 */
	public List<Map<String, Object>> findKeys(String tokenId);

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
	List<Map<String, Object>> getKeyDeviceMapList(long unitId, KeyDeviceSearchVo vo, int pageNo, int pageSize);

	/**
	 * 查询钥匙设备以供编辑
	 * 
	 * @param keyDeviceId
	 * @return
	 */
	Map<String, Object> getkeyDeviceToEdit(long keyDeviceId);

	void createKeyDevice_tx(KeyDeviceVo vo);

	void updateKeyDevice_tx(long id, KeyDeviceVo vo);

	Map<String, Object> getKeyDeviceDetail(long keyDeviceId);

	void deleteKeyDevice_tx(long keyDeviceId);

	/**
	 * 根据用户id 获取钥匙
	 * 
	 * @param residentId
	 * @return
	 */
	List<Map<String, Object>> findKeys(Long residentId);
	
	/**
	 * 钥匙数据导入
	 * @param inputStream
	 * @param unitId
	 * @param model
	 * @throws IOException 
	 */
	public void importKeyDevice_tx(InputStream inputStream, Long unitId, ModelMap model) throws IOException;
	
	/**
	 * 获取某个小区的钥匙
	 * @param unitId
	 * @return
	 */
	public Map<String, Object> getKeys(Long unitId);
	
	/**
	 * 通过小区id和楼栋id获取钥匙信息
	 */
	public List<Map<String, Object>> findkeyDevice(Long unitId , Long storyId);
}
