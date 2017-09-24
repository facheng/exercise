package com.dt.tarmag.schedule;


import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.dt.tarmag.model.ResidentUnit;
import com.dt.tarmag.model.ResidentUnitKey;
import com.dt.tarmag.service.IResidentUnitKeyService;


/**
 * 删除指定时间内不使用的钥匙+用户绑定关系。
 * 住户和小区绑定(见表DT_RESIDENT_UNIT)成功后，系统会给住户分配钥匙(见表DT_RESIDENT_UNIT_KEY)。
 * 1、在绑定成功后1天(时间从DT_RESIDENT_UNIT.CREATE_TIME起算)内，如果有钥匙没使用(在DT_IN_OUT中记录)过，则删除。
 * 2、在1天内使用过，之后的2天(第2天~第3天)内又没使用的，也删除
 * 
 * 注意：
 * 1、在1天内使用，并且2~3天内也使用，这种钥匙保留，其它的全删除
 * 2、只删楼栋的钥匙，不删小区的
 * @author yuwei
 * @Time 2015-7-24下午04:43:16
 */
@Component
public class ResidentKeyJob extends AbstractJob {
	private final Logger logger = Logger.getLogger(ResidentKeyJob.class);
	
	@Autowired
	private IResidentUnitKeyService residentUnitKeyService;
	

	/**
	 * 分批查询时，每一批次查询的数据条数
	 */
	private final static int PAGE_SIZE = 10;
	

	@Override
	protected void executeWork() {
		logger.info("com.dt.tarmag.schedule.ResidentKeyJob-----start......");
		int currentPageNo = 1;
		while(true) {
			List<ResidentUnitKey> list = residentUnitKeyService.getResidentUnitStoryKeyList(currentPageNo, PAGE_SIZE);
			if(list == null || list.size() <= 0) {
				break;
			}
			
			int delCount = 0;
			for(ResidentUnitKey ruk: list) {
				if(executeRuk(ruk)) {
					delCount++;
				}
			}
			
			if(delCount == 0) {
				currentPageNo++;
			}
		}
		logger.info("com.dt.tarmag.schedule.ResidentKeyJob-----end......");
	}
	
	
	/**
	 * 对于每一把绑定的钥匙，在其住户和小区绑定后1天内和2~3天内是否都使用过。“是”则保留，“否”则删除
	 * @param ruk
	 * 若删除，返回true，否则返回false
	 */
	private boolean executeRuk(ResidentUnitKey ruk) {
		ResidentUnit ru = residentUnitKeyService.getResidentUnitById(ruk.getResidentUnitId());
		if(ru == null) {
			residentUnitKeyService.delete_tx(ruk);
			return true;
		}
		
		Calendar c = Calendar.getInstance();
		c.setTime(ru.getCreateTime());
		c.add(Calendar.DAY_OF_MONTH, 1);
		
		Date fromDate = ru.getCreateTime();
		Date endDate = c.getTime();
		
		/**
		 * 绑定时间若未超过1天，不删除
		 **/
		if(new Date().getTime() - ru.getCreateTime().getTime() < 24 * 60 * 60 * 1000) {
			return false;
		}
		
		/**
		 * 第1天内未使用，删除
		 **/
		boolean used = residentUnitKeyService.isUsed(ru.getResidentId(), ruk.getKeyDeviceId(), fromDate, endDate);
		if(!used) {
			logger.info("删除钥匙【DT_RESIDENT_UNIT_KEY.ID=" + ruk.getId() + "】");
			residentUnitKeyService.delete_tx(ruk);
			return true;
		}
		
		
		c.setTime(ru.getCreateTime());
		c.add(Calendar.DAY_OF_MONTH, 1);
		fromDate = c.getTime();
		
		c.add(Calendar.DAY_OF_MONTH, 2);
		endDate = c.getTime();
		/**
		 * 第2~3天内未使用，删除
		 **/
		used = residentUnitKeyService.isUsed(ru.getResidentId(), ruk.getKeyDeviceId(), fromDate, endDate);
		if(!used) {
			logger.info("删除钥匙【DT_RESIDENT_UNIT_KEY.ID=" + ruk.getId() + "】");
			residentUnitKeyService.delete_tx(ruk);
			return true;
		}
		
		return false;
	}
	
}


