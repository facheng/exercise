package com.dt.framework.model;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import com.dt.framework.util.JSONConfig;

/**
 * 底层简单model
 * @author jason
 *
 */
public class DtSimpleModel implements java.io.Serializable{

	private static final long serialVersionUID = -7573236047379180851L;
	/**
	 * 主键
	 */
	private long id;
	/**
	 * 默认为N   N 未删除   Y 删除
	 */
	private String deleted = "N";
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	
	/**
	 * 获取指定字段的值组装成map
	 * @param fieldNames 需要获取的字段 如果为空则将所有字段转换
	 * @param isFilter 是否需要过滤空对象 或者空字符串
	 * @return 
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> toMap(String[] fieldNames, boolean isFilter){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		JSONObject jsonObject = JSONObject.fromObject(this, JSONConfig.getDefaultConfig(isFilter));
		if(fieldNames!=null){
			JSONObject json = new JSONObject();
			for(String fieldName : fieldNames){
				if(jsonObject.containsKey(fieldName)){
					json.put(fieldName, jsonObject.get(fieldName));
				}
			}
			resultMap.putAll(json);
		}else{
			resultMap.putAll(jsonObject);
		}
		return resultMap;
	}
	
	public Map<String, Object> toMap(String[] fieldNames){
		return this.toMap(fieldNames, false);
	}
}
