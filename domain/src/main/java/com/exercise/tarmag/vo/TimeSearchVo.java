package com.dt.tarmag.vo;

import java.util.Calendar;
import java.util.Date;

import com.dt.framework.util.DateUtil;


/**
 * @author yuwei
 * @Time 2015-7-29下午04:13:40
 */
public abstract class TimeSearchVo {
	/**
	 * 报修时间格式。
	 * 1按起止日期查询；
	 * 2按时间类型查询。
	 */
	private Byte timeFlag;
	/**
	 * 若timeFlag=1，timeStart有效
	 */
	private String timeStart;
	/**
	 * 若timeFlag=1，timeEnd有效
	 */
	private String timeEnd;
	/**
	 * 若timeFlag=2，timeType有效。
	 * 取值为：
	 * 0不限
	 * 1今天
	 * 2最近10天
	 * 3最近1个月
	 * 4最近3个月
	 * 5最近1年
	 * 6近1周
	 */
	private Byte timeType;
	
	

	
	public void calculateDate(){
		Date startTime = getStartTime();
		if(startTime != null) {
			setTimeStart(DateUtil.formatDate(startTime, DateUtil.PATTERN_DATE1));
		}
		
		Date endTime = getEndTime();
		if(endTime != null) {
			setTimeEnd(DateUtil.formatDate(endTime, DateUtil.PATTERN_DATE1));
		}
	}
	
	
	
	/**
	 * 根据现有条件，计算出实际的起始时间
	 * @return
	 */
	public Date getStartTime(){
		if(getTimeFlag() == null) {
			return null;
		}
		if(getTimeFlag() == 1) {
			try {
				return DateUtil.parseDate(getTimeStart(), DateUtil.PATTERN_DATE1);
			} catch (Exception e) {
				setTimeStart("");
				return null;
			}
		}
		if(getTimeFlag() == 2) {
			Byte tt = getTimeType();
			if(tt == 0) {
				//不限
				return null;
			}
			if(tt == 1) {
				//今天
				return DateUtil.getStartOfDate(new Date());
			}
			if(tt == 2) {
				//最近10天
				Calendar c = Calendar.getInstance();
				c.add(Calendar.DAY_OF_MONTH, -10);
				return c.getTime();
			}
			if(tt == 3) {
				//最近1个月
				Calendar c = Calendar.getInstance();
				c.add(Calendar.MONTH, -1);
				return c.getTime();
			}
			if(tt == 4) {
				//最近3个月
				Calendar c = Calendar.getInstance();
				c.add(Calendar.MONTH, -3);
				return c.getTime();
			}
			if(tt == 5) {
				//最近12个月
				Calendar c = Calendar.getInstance();
				c.add(Calendar.MONTH, -12);
				return c.getTime();
			}
			if(tt == 6) {
				//最近7天
				Calendar c = Calendar.getInstance();
				c.add(Calendar.DAY_OF_MONTH, -7);
				return c.getTime();
			}
			if(tt == 7) {
				//最近30天
				Calendar c = Calendar.getInstance();
				c.add(Calendar.DAY_OF_MONTH, -30);
				return c.getTime();
			}
			return null;
		}
		return null;
	}
	/**
	 * 根据现有条件，计算出实际的结束时间
	 * @return
	 */
	public Date getEndTime(){
		if(getTimeFlag() == null) {
			return null;
		}
		if(getTimeFlag() == 1) {
			try {
				return DateUtil.getLastSecOfDate(DateUtil.parseDate(getTimeEnd(), DateUtil.PATTERN_DATE1));
			} catch (Exception e) {
				setTimeEnd("");
				return null;
			}
		}
		if(getTimeFlag() == 2) {
			Byte tt = getTimeType();
			if(tt == 0) {
				//不限
				return null;
			}
			if(tt == 1) {
				//今天
				return new Date();
			}
			if(tt == 2) {
				//最近10天
				return new Date();
			}
			if(tt == 3) {
				//最近1个月
				return new Date();
			}
			if(tt == 4) {
				//最近3个月
				return new Date();
			}
			if(tt == 5) {
				//最近12个月 （1年）
				return new Date();
			}
			if(tt == 6) {
				//最近7天 （1周）
				return new Date();
			}
			return null;
		}
		return null;
	}
	
	

	public Byte getTimeFlag() {
		return timeFlag;
	}
	public void setTimeFlag(Byte timeFlag) {
		this.timeFlag = timeFlag;
	}
	public String getTimeStart() {
		return timeStart;
	}
	public void setTimeStart(String timeStart) {
		this.timeStart = timeStart;
	}
	public String getTimeEnd() {
		return timeEnd;
	}
	public void setTimeEnd(String timeEnd) {
		this.timeEnd = timeEnd;
	}
	public Byte getTimeType() {
		return timeType;
	}
	public void setTimeType(Byte timeType) {
		this.timeType = timeType;
	}
}
