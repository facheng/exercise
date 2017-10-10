/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.IExpressDeliveryDao;
import com.dt.tarmag.dao.IExpressDeliveryReceiverDao;
import com.dt.tarmag.dao.IHouseDao;
import com.dt.tarmag.model.ExpressDeliveryReceiver;
import com.dt.tarmag.model.House;
import com.dt.tarmag.util.DateUtils;
import com.dt.tarmag.util.Params;

/**
 * @author 👤wisdom
 *
 */
@Service
public class ExpressDeliveryService implements IExpressDeliveryService {

	@Autowired
	private IHouseDao houseDao;

	@Autowired
	private IExpressDeliveryDao expressDeliveryDao;

	@Autowired
	private IExpressDeliveryReceiverDao expressDeliveryReceiverDao;

	@Override
	public byte security(Long houseId) {
		return this.houseDao.get(houseId).getDelegateDelivery();
	}

	@Override
	public void delegate_tx(Long houseId, int delegateDelivery) {
		House house = this.houseDao.get(houseId);
		house.setDelegateDelivery((byte) delegateDelivery);
		this.houseDao.update(house);
	}


	@Override
	public List<Map<String, Object>> expressdeliverys(Long houseId,
			Long residentId, int pageNo) {
		List<Map<String, Object>> expressdeliverys = this.expressDeliveryDao
				.expressdeliverys(Params.getParams("houseId", houseId,
						"residentId", residentId), pageNo);
		for (Map<String, Object> expressdelivery : expressdeliverys) {
			DateUtils.disposeCreateDateTime(expressdelivery);
		}
		return expressdeliverys;
	}

	@Override
	public Map<String, Object> expressdelivery_tx(Long id, Long residentId) {
		ExpressDeliveryReceiver expressDeliveryReceiver = this.expressDeliveryReceiverDao
				.getExpressDeliveryReceiver(id, residentId);
		expressDeliveryReceiver.setIsRead(true);
		expressDeliveryReceiver.setReadTime(new Date());
		this.expressDeliveryReceiverDao.update(expressDeliveryReceiver);
		Map<String, Object> expressdelivery = this.expressDeliveryDao.get(id).toMap(
				new String[] { "title", "createDateTime" });
		DateUtils.disposeCreateDateTime(expressdelivery);
		return expressdelivery;
	}

	@Override
	public void clean_tx(Long residentId, Long houseId) {
		this.expressDeliveryReceiverDao.clean(residentId, houseId);
	}
}
