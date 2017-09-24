package com.dt.tarmag.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.springframework.ui.ModelMap;

import com.dt.framework.web.vo.MsgResponse;
import com.dt.tarmag.model.Resident;
import com.dt.tarmag.vo.ResidentVo;

public interface IResidentService {
	
	/**
	 * 保存api访问记录
	 * @param tokenId
	 */
	void saveApiRequestRec_tx(String tokenId);
	
	/**
	 * 根据tokenId查住户Id
	 * @param tokenId
	 * @return
	 */
	Long getResidentId(String tokenId);
	
	/**
	 * i家园app获取验证码 
	 * @param phoneNum 手机号
	 * @return
	 */
	public MsgResponse getPinCode_tx(String phoneNum);
	
	/**
	 * 通过手机号和验证码登录
	 * @param phoneNum
	 * @param pinCode
	 * @return
	 */
	public MsgResponse login_tx(String phoneNum, String pinCode, String tokenId);
	
	/**
	 * 登出
	 * @param phoneNum
	 * @param tokenId
	 * @return
	 */
	public void loginOut_tx(String tokenId);
	
	/**根据tokenId获取登录信息
	 * @param tokenId
	 * @return
	 */
	public Map<String, Object> getLoginInfoByTokenId(String tokenId);

	/**
	 * 👤头像上传
	 * @param id
	 * @param headimg
	 */
	public void headimg_tx(Long id, String headimg);
	
	/**
	 * 👤信息修改
	 * @param id
	 * @param headimg
	 */
	public void residetrevise_tx(Resident resident);

	
	/**
	 * 通过房屋 ID 查询业主信息或租客信息
	 * @return
	 */
	public List<Map<String ,Object>> getResidentByHouseId(long houseId);

	/**
	 * 查询业主信息或租客信息
	 * @param houseId
	 * @param resident
	 * @return
	 */
	public List<Resident> getResident(String houseId, Resident resident);
	
	/**
	 * 通过手机号码查询租客或业主
	 * @param phoneNum
	 * @return
	 */
	public Resident getResidentByPhoneNum(String phoneNum);
	
	/**
	 * 导入住户信息
	 * @param inputStream
	 * @param unitId
	 * @param model
	 * @throws IOException 
	 */
	public void importResident_tx(InputStream inputStream, Long unitId, ModelMap model) throws IOException;
	
	/**
	 * 通过房屋ID查询业主和家属信息
	 * @param houseId
	 * @return
	 */
	public List<ResidentVo> getResidentByHouseIdAndType(long houseId);
	
	/**
	 * 查询指定房屋里的所有住户
	 * @param houseId
	 * @return
	 */
	List<Map<String ,Object>> getResidentListByHouseId(long houseId);
	
	/**
	 * 根据小区id查询用户信息
	 * @param houseId
	 * @return
	 */
	List<Map<String ,Object>> getResidentListByUnitId(long unitId);
	
	/**
	 * 查询用户头像和昵称
	 * @param phoneNum
	 * @return
	 */
	public Map<String ,Object> getResidentInfo(String phoneNum);
	
}
