package com.dt.tarmag.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.ExpressDeliveryReceiver;

/**
 * @author yuwei
 * @Time 2015-7-8下午07:42:28
 */
@Repository
public class ExpressDeliveryReceiverDao extends
		DaoImpl<ExpressDeliveryReceiver, Long> implements
		IExpressDeliveryReceiverDao {

	@Override
	public ExpressDeliveryReceiver getExpressDeliveryReceiver(Long deliveryId,
			Long residentId) {
		String sql = "SELECT * FROM DT_EXPRESS_DELIVERY_RECEIVER EDR WHERE EDR.DELIVERY_ID=? AND EDR.RESIDENT_ID=?";
		return this.queryForObject(sql, ExpressDeliveryReceiver.class,
				deliveryId, residentId);
	}

	@Override
	public void clean(Long residentId, Long houseId) {
		String sql = "UPDATE DT_EXPRESS_DELIVERY_RECEIVER EDR SET EDR.DELETED='Y' WHERE EDR.DELETED='N' AND EDR.IS_READ='1' AND EDR.RESIDENT_ID=? AND EDR.DELIVERY_ID IN (SELECT ID FROM DT_EXPRESS_DELIVERY WHERE DELETED='N' AND HOUSE_ID=?)";
		this.execute(sql, residentId, houseId);
	}

	@Override
	public int getReadCountByDeliveryId(long deliveryId) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(ID) ")
		   .append(" FROM DT_EXPRESS_DELIVERY_RECEIVER ")
		   .append(" WHERE DELIVERY_ID = ? AND IS_READ = ? AND DELETED = ? ");
		return queryCount(sql.toString(), new Object[]{deliveryId, true, Constant.MODEL_DELETED_N});
	}

	@Override
	public List<ExpressDeliveryReceiver> getExpressDeliveryReadList(long deliveryId, int pageNo, int pageSize) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT * ")
		   .append(" FROM DT_EXPRESS_DELIVERY_RECEIVER ")
		   .append(" WHERE DELIVERY_ID = ? AND IS_READ = ? AND DELETED = ? ")
		   .append(" ORDER BY READ_TIME DESC ");
		return query(sql.toString(), ExpressDeliveryReceiver.class, pageNo, pageSize, new Object[]{deliveryId, true, Constant.MODEL_DELETED_N});
	}
	
	@Override
	public List<Map<String, Object>> getPushVos(long broadcastId) {
		StringBuffer sql = new StringBuffer();
		sql.append("select br.ID id,b.TITLE content,'2' type,br.RESIDENT_ID userId,dm.APP_TYPE appType,dm.N_TOKEN nToken,dm.DEVICE_MODEL deviceModel,dm.DEVICE_TYPE deviceType ");
		sql.append("from DT_EXPRESS_DELIVERY_RECEIVER br ");
		sql.append("left join DT_EXPRESS_DELIVERY b on b.ID = br.DELIVERY_ID ");
		sql.append("inner join DT_DEVICE_MANAGE dm on dm.USER_ID = br.RESIDENT_ID ");
		sql.append("where br.DELIVERY_ID = ? ");
		return this.queryForMapList(sql.toString(), broadcastId);
	}
}
