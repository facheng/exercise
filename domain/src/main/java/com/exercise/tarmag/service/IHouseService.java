/**
 * 
 */
package com.dt.tarmag.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.ui.ModelMap;

import com.dt.tarmag.model.House;
import com.dt.tarmag.model.HouseResident;
import com.dt.tarmag.vo.HouseVo;
import com.dt.tarmag.vo.Tree;

/**
 * @author raymond
 *
 */
public interface IHouseService {

	/**
	 * 通过楼栋获取房屋列表
	 * 
	 * @param storyId
	 * @return
	 */
	public List<Map<String, Object>> getHousesByStoryId(long storyId,
			String tokenId);

	/**
	 * 查询房屋数量
	 * 
	 * @param unitId
	 * @param status
	 * @param roomNo
	 * @return
	 */
	public int getHouseCount(long unitId, Byte status, String roomNo, Long partitionId );

	/**
	 * 房屋列表
	 * 
	 * @param unitId
	 * @param status
	 * @param roomNo
	 * @return
	 */
	public List<Map<String, Object>> getHouseList(long unitId, Byte status,
			String roomNo, Long partitionId, int pageNo, int pageSize);

	/**
	 * 获取 导出房屋的信息
	 * 
	 * @param house
	 * @param path
	 *            模板路径
	 * @return
	 */
	public HSSFWorkbook findHouseInfosExcel(House house, String path)
			throws Exception;

	/**
	 * 通过 ID查询房屋信息
	 * 
	 * @param houseId
	 * @return
	 */
	public House getHouseById(long houseId);

	/**
	 * 修改房屋信息
	 * 
	 * @param houseId
	 * @param vo
	 */
	public void updateHouse_tx(long houseId, HouseVo vo);

	/**
	 * 删除房屋信息
	 * 
	 * @param userId
	 * @param houseId
	 */
	public void removeHouse_tx(Long houseId);

	/**
	 * 根据 房屋dycode 和 小区id 获取房屋总数
	 * 
	 * @return
	 */
	public int findCountHouse(House house);

	/**
	 * 查询房屋绑定关系个数
	 * 
	 * @param unitId
	 * @param state
	 *            /房屋状态(全部、0未核准、1已核准、2已驳回)
	 * @param roomNo
	 * @return
	 */
	int getHouseResidentReviewCount(long unitId, Byte state, String roomNo);

	/**
	 * 查询房屋绑定关系
	 * 
	 * @param unitId
	 * @param state
	 *            /房屋状态(全部、0未核准、1已核准、2已驳回)
	 * @param roomNo
	 * @return
	 */
	List<Map<String, Object>> getHouseResidentReviewMapList(long unitId,
			Byte state, String roomNo, int pageNo, int pageSize);

	/**
	 * 核准/驳回房屋绑定
	 * 
	 * @param houseResidentIdList
	 * @param isApproved
	 */
	void doHouseResidentReview_tx(List<Long> houseResidentIdList,
			byte isApproved);

	/**
	 * 房屋导入
	 * 
	 * @param inputStream
	 * @param unitId
	 * @param model
	 * @throws IOException
	 */
	public void importHouse_tx(InputStream inputStream, Long unitId,
			ModelMap model) throws IOException;

	/**
	 * 查询指定小区下所有房屋
	 * @param unitId
	 * @return
	 */
	List<Tree> getHouseTreeByUnitId(long unitId);
	/**
	 * 查询指定楼栋下的所有房屋
	 * @param unitId
	 * @return
	 */
	List<Tree> getStoryHouseByStoryId(long storyId);

	Map<String, Object> getHouseToEdit(long houseId);

	/**
	 * 查询指定手机号码的人是否居住在指定的房屋中
	 * 
	 * @param houseId
	 * @param mobile
	 * @return
	 */
	HouseResident getHouseResident(long houseId, String mobile);
	
	/**
	 * 查询指定楼栋下所有房屋信息
	 * @param storyId
	 * @return
	 */
	List<House> getHouseListByStoryId(long storyId);
	
	/**
	 * 查询指定片区下所有房屋信息
	 * @param storyId
	 * @return
	 */
	List<House> getHouseListByPartitionId(long partitionId);
	
	/**
	 * 查询房屋审核列表
	 * @param unitId
	 * @param state
	 * @param roomNo
	 * @param partitionId
	 * @param userName
	 * @param phoneNum
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> getHouseResidentReviewList(
			Long unitId,
			Byte state,
			String roomNo,
			Long partitionId,
			String userName,
			String phoneNum,
			Integer pageNo,
			Integer pageSize);
	
	/**
	 * 查询房屋审核总数
	 * @param unitId
	 * @param state
	 * @param roomNo
	 * @param partitionId
	 * @param userName
	 * @param phoneNum
	 * @return
	 */
	public int getHouseResidentReviewCount(
			Long unitId,
			Byte state,
			String roomNo,
			Long partitionId,
			String userName,
			String phoneNum);
	
	int getHouseCountByUnitId(long unitId);
	/**
	 * 查询房屋统计结果，按状态统计
	 * @param unitId
	 * @return
	 */
	List<Map<String, Object>> getHouseStatistics(long unitId);
	JSONArray getHouseStatisticsJson(long unitId);
	
	/**
	 * 获取 导出房屋的信息
	 * 
	 * @param house
	 * @param path
	 *            模板路径
	 * @return
	 */
	public HSSFWorkbook getHouseInfosForExport( House house )
			throws Exception;
}
