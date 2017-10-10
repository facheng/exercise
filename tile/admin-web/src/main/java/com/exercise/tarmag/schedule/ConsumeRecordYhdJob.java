package com.dt.tarmag.schedule;


import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;

import com.dt.framework.util.DateUtil;
import com.dt.framework.util.HttpUtil;
import com.dt.framework.util.SecurityUtil;
import com.dt.tarmag.enumeration.EcommerceCode;
import com.dt.tarmag.model.ProfitConsumeRec;
import com.dt.tarmag.model.ProfitEcom;
import com.dt.tarmag.service.IProfitService;


/**
 * 从一号店定时抓取消费记录。
 * 一号店抓取数据有如下要求：
 * 1、抓取数据的时间区间段不能超过1小时；
 * 2、两次抓取操作不能小于2分钟
 * @author yuwei
 * @Time 2015-8-14上午11:13:06
 */
@Component
public class ConsumeRecordYhdJob extends AbstractJob {
	protected final Logger logger = Logger.getLogger(this.getClass());

	/**
	 * 网盟唯一标识码
	 */
	private final static String TRACKER_U = "105291442";
	/**
	 * 一号店分配的安全码
	 */
	private final static String SECRET_KEY = "6pxcvv6y8ktcejcpwdb6hbvjn4elychu";
	/**
	 * 时间间隔(分钟)
	 */
	private final static int TIME_INTERVAL = 20;
	/**
	 * 指定时间之前(分钟)
	 */
	private final static int TIME_BEFORE = 60;
	
	
	@Autowired
	private IProfitService profitService;
	
	
	
	
	@Override
	protected void executeWork() {
		Calendar c = Calendar.getInstance();
		c.add(Calendar.MINUTE, -TIME_BEFORE);
		Date endTime = c.getTime();
		
		c.add(Calendar.MINUTE, -TIME_INTERVAL);
		Date startTime = c.getTime();

		doRequest(startTime, endTime);
	}
	
	private void doRequest(Date startTime, Date endTime) {
		ProfitEcom ecom = profitService.getProfitEcomByCode(EcommerceCode.YHD.getCode());
		if(ecom == null) {
			logger.error("电商基本资料缺失(code=" + EcommerceCode.YHD.getCode() + ")");
			return;
		}
		
		logger.info("开始从一号店定时抓取消费记录");
		logger.info("startTime=" + DateUtil.formatDate(startTime, DateUtil.PATTERN_DATE_TIME2));
		logger.info("endTime=" + DateUtil.formatDate(endTime, DateUtil.PATTERN_DATE_TIME2));
		
		String url = "http://unioncps.yhd.com/common/service.do";
		Map<String, String> params = new HashMap<String, String>();
		params.put("v", "1.0");
		params.put("method", "order.get.new");
		params.put("type", "0");
		params.put("tracker_u", TRACKER_U);
		params.put("format", "json");
		params.put("time", String.valueOf(Calendar.getInstance().getTimeInMillis() / 1000));
		params.put("s", String.valueOf(startTime.getTime() / 1000));
		params.put("e", String.valueOf(endTime.getTime() / 1000));
		
		String sign = computeSign(params);
		params.put("sign", sign);
		params.put("update", "1");
		
		String result = HttpUtil.doGet(url, params);
		logger.info(result);
		parseResult(ecom.getId(), result);
		logger.info("从一号店定时抓取消费记录结束");
	}
	
	
	/**
	 * 解析一号店返回的json数据
	 * @param ecomId
	 * @param result
	 */
	private void parseResult(long ecomId, String result) {
		try {
			logger.info("抓取数据结束，解析中.......");
			JSONObject jsonResult = JSONObject.fromObject(result);
			if(jsonResult == null || jsonResult.isEmpty()) {
				logger.info("没有数据");
				return;
			}
			int count = jsonResult.getInt("count");
			if(count <= 0) {
				logger.info("没有数据");
				return;
			}
			
			JSONArray orderArray = jsonResult.getJSONArray("orders");
			for(int i = 0; i < orderArray.size(); i++) {
				JSONObject jsonOrder = orderArray.getJSONObject(i);

				/**
				 * 下单时间
				 **/
				String orderCreateTimeStr = jsonOrder.getString("orderCreateTime");
				Date orderCreateTime = DateUtil.parseDate(orderCreateTimeStr, DateUtil.PATTERN_DATE_TIME2);
				
				/**
				 * 订单号
				 **/
				String orderCode = jsonOrder.getString("orderCode");

				/**
				 * 小区Id和住户Id
				 **/
				long unitId = 0;
				long residentId = 0;
				String uid = jsonOrder.getString("uid");
				if(uid != null && !"".equals(uid.trim())) {
					try {
						String[] arr = uid.trim().split("|");
						unitId = Long.parseLong(arr[0]);
						residentId = Long.parseLong(arr[1]);
					} catch (Exception ue) {
						logger.error("uid格式应为“小区ID|住户ID”如：8|1");
					}
				}
				
				/**
				 * 消费金额
				 **/
				double orderAmount = jsonOrder.getDouble("orderAmount");
				
				/**
				 * 反润金额
				 **/
				double commission = jsonOrder.getDouble("commission");
				
				/**
				 * 如果是新数据，直接保存；
				 * 如果是已经存在的，但目前的状态是“未对账”，更新数据
				 **/
				ProfitConsumeRec rec = profitService.getProfitConsumeRec(ecomId, orderCode);
				if(rec == null) {
					logger.info("新增数据(ecomId:" + ecomId + "，orderId：" + orderCode + ")");
					rec = new ProfitConsumeRec();
					rec.setEcomId(ecomId);
					rec.setConsumeTime(orderCreateTime);
					rec.setOrderId(orderCode);
					rec.setUnitId(unitId);
					rec.setResidentId(residentId);
					rec.setConsumeAmount(orderAmount);
					rec.setProfitAmount(commission);
					rec.setStatus(ProfitConsumeRec.STATUS_NOT_APPROVE);
					profitService.saveProfitConsumeRecord_tx(rec);
				} else if(rec.getStatus() == ProfitConsumeRec.STATUS_NOT_APPROVE) {
					logger.info("更新数据(recId:" + rec.getId() + ")");
					rec.setConsumeTime(orderCreateTime);
					rec.setUnitId(unitId);
					rec.setResidentId(residentId);
					rec.setConsumeAmount(orderAmount);
					rec.setProfitAmount(commission);
					profitService.updateProfitConsumeRecord_tx(rec);
				} else {
					/**
					 * 不处理已对账结束的消费记录
					 **/
					logger.info("已对账记录不可更新。recId=" + rec.getId());
				}
			}
			
			logger.info("解析结束");
		} catch (Exception e) {
			logger.error(e.getMessage());
			logger.info("解析结束");
		}
	}
	
	
	/**
	 * 签名计算：
	 * 将请求参数格式化为"key=value"格式，即"k1=v1"、"k2=v2"；
	 * 将格式化的参数键值对，以字典升序排列后，拼凑在一起，即"k1=v1k2=v2"；
	 * 在拼凑的字符串末尾追加上用户的secret_key，该key由1号店分配；
	 * 将上面字符串用md5生成摘要，即签名字符串。
	 * @return
	 */
	private String computeSign(Map<String, String> params) {
		Assert.notEmpty(params);

		List<String> list = new ArrayList<String>();
		Set<Entry<String, String>> paramSet = params.entrySet();
		for(Entry<String, String> entry : paramSet) {
			String key = entry.getKey();
			String value = entry.getValue();

			if("sign".equals(key)) {
				continue;
			}
			if("update".equals(key)) {
				continue;
			}
			
			String str = null;
			if(value == null) {
				str = key + "=";
			} else {
				str = key + "=" + value;
			}
			
			list.add(str);
		}
		
		Collections.sort(list);
		
		StringBuffer buf = new StringBuffer("");
		for(String str : list) {
			buf.append(str);
		}
		
		buf.append(SECRET_KEY);
		
		return SecurityUtil.getMD5(buf.toString());
	}
	
}


