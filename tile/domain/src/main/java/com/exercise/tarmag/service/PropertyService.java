package com.dt.tarmag.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.convert.ViewTransfer;
import com.dt.tarmag.dao.IHouseDao;
import com.dt.tarmag.vo.HouseStatusCount;

/**
 * @author yuwei
 * @Time 2015-6-25下午02:49:34
 */
@Service
public class PropertyService implements IPropertyService {
	
	@Autowired
	private IHouseDao houseDao;
	
	/**
	 *  房屋状态统计
	 * @param unitId
	 * 			小区id
	 * @return
	 */
	@Override
	public List<HouseStatusCount> getHouseCount(long unitId) throws Exception{
		
		List<Map<String, Object>> list = houseDao.getHouseCount(unitId);
		if(list == null || list.size() == 0){
			return null;
		}
		int countAll = 0 ;//所以房屋总数
		List<HouseStatusCount> listHouseStatusCounts = new ArrayList<HouseStatusCount>();
		for(int i = 0 ; i < list.size() ; i++){
			countAll = countAll + Integer.parseInt(list.get(i).get("count").toString());//获取总数
		}
		for(int i = 0 ; i < list.size() ; i++){
			HouseStatusCount houseStatusCount = new HouseStatusCount();
			Map<String, Object> map = list.get(i);
			int count = Integer.parseInt(map.get("count").toString());
			String status = map.get("status").toString();
			houseStatusCount.setStatus(status);//房屋对应状态 (0自住，1空置，2待售，3出租，4待租)
			houseStatusCount.setCountAll(countAll);
			if(countAll == 0){
				houseStatusCount.setPrecent("0");
			}else{
				double pre = count * 1.0 / countAll;
				houseStatusCount.setPrecent(new BigDecimal(pre).setScale(3,BigDecimal.ROUND_HALF_UP).toString());
			}
			houseStatusCount.setCount(count);
			houseStatusCount.setMemo(ViewTransfer.getHouseStatusMemo(houseStatusCount
					.getStatus()));
			listHouseStatusCounts.add(houseStatusCount);
		}
		return listHouseStatusCounts;
	}
	
}
