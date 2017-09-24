package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.tarmag.model.FocusResident;
import com.dt.tarmag.vo.FocusResidentVo;


/**
 * 需要关注的业主
 * @author jiaosf
 * @since 2015-7-17
 */
public interface IFocusResidentServie {
	/**
	 *  需要关注的业主总数查询
	 * @param unitId
	 * @param roomNum
	 * @return
	 */
	public int getFocusResidentCount(Long unitId, String roomNum ,Byte residentStatus);
	
	/**
	 * 需要关注的业主列表查询 分页
	 * @param unitId
	 * @param roomNum
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> getFocusResidentList(Long unitId, String roomNum,Byte residentStatus ,Integer pageNo, Integer pageSize);
	
	/**
	 * 获取修改页面回显数据
	 * @param frId
	 * @return
	 */
	public FocusResidentVo getFocusResidentInfo(long frId);
	
	/**
	 * 修改或者保存需要关注的业主
	 * @param focusResidentVo
	 * @throws Exception 
	 */
	public void saveOrUpdate_tx(FocusResidentVo focusResidentVo) throws Exception;
	
	/**
	 * 移除需要关注的业主
	 * @param idList
	 * @param isApprovedYes
	 */
	public void removeFocusResident_tx(List<Long> idList);
	
	/**
	 * 根据业主关系查询需要关注的业主
	 * @param hrId
	 * @return
	 */
	public List<FocusResident> getfocusResidentByHrId(long hrId);

}
