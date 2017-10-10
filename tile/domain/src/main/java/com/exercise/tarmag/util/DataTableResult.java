package com.dt.tarmag.util;

import java.util.Date;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.dt.framework.model.DtModel;
import com.dt.framework.util.DateUtil;
import com.dt.framework.util.JSONConfig;
import com.dt.framework.util.StringUtils;

/**
 * @author raymond jquery dataTable 返回对象
 * @param <T>
 */
public class DataTableResult<T> {
	private int iTotalRecords;// 实际的行数iTotalRecords
	private int iTotalDisplayRecords;// 过滤之后，实际的行数。
	private String sEcho;// 来自客户端 sEcho 的没有变化的复制品，
	private String sColumns;// 可选，以逗号分隔的列名，　　　　
	private List<T> data;// JSON数据

	public DataTableResult() {
		super();
	}

	public int getiTotalRecords() {
		return iTotalRecords;
	}

	public void setiTotalRecords(int iTotalRecords) {
		this.iTotalRecords = iTotalRecords;
	}

	public int getiTotalDisplayRecords() {
		return iTotalDisplayRecords;
	}

	public void setiTotalDisplayRecords(int iTotalDisplayRecords) {
		this.iTotalDisplayRecords = iTotalDisplayRecords;
	}

	public String getsEcho() {
		return sEcho;
	}

	public void setsEcho(String sEcho) {
		this.sEcho = sEcho;
	}

	public String getsColumns() {
		return sColumns;
	}

	public void setsColumns(String sColumns) {
		this.sColumns = sColumns;
	}

	public List<T> getData() {
		return data;
	}

	public void setData(List<T> data) {
		this.data = data;
	}

	public void setParams(DataTableParams params) {
		this.sColumns = params.getsColumns();
		this.sEcho = params.getsEcho();
	}

	public static <T> JSONObject toJSONObject(DataTableParams params,
			PageResult<T> pageResult) {
		DataTableResult<T> dataTableResult = new DataTableResult<T>();
		dataTableResult.setParams(params);
		return dataTableResult.toJSONObject(pageResult);
	}

	public JSONObject toJSONObject(PageResult<T> pageResult) {
		this.setData(pageResult.getDatas());
		this.setiTotalDisplayRecords(pageResult.getPage().getRowCount());
		this.setiTotalRecords(pageResult.getPage().getRowCount());
		return this.toJSONObject();
	}

	protected JSONObject toJSONObject() {
		JSONObject jsonObject = new JSONObject();
		if (StringUtils.isBlank(this.sColumns))
			return jsonObject;
		String[] columns = this.sColumns.split(",");
		JSONArray dataArray = new JSONArray();
		for (T model : this.data) {
			JSONArray objectArray = new JSONArray();
			JSONObject object = null;
			if (model instanceof DtModel) {
				object = JSONObject.fromObject(model,
						JSONConfig.getDefaultConfig());
			} else if (model instanceof Map) {
				object = new JSONObject();
				object.putAll((Map<?, ?>) model);
			} else {
				continue;
			}
			for (String column : columns) {
				Object val = object.get(column);
				String value = StringUtils.EMPTY;
				if (val instanceof JSONObject
						&& ((JSONObject) val).containsKey("day")) {// 如果是日期对象
					JSONObject dateJson = ((JSONObject) object.remove(column));
					Date date = (Date) JSONObject.toBean(dateJson, Date.class);
					value = DateUtil.formatDate(date,
							DateUtil.PATTERN_DATE_TIME2);
				} else if (val != null) {
					value = String.valueOf(val);
				}
				objectArray.add(value);
			}
			dataArray.add(objectArray);
		}

		jsonObject.put("iTotalDisplayRecords", this.iTotalDisplayRecords);
		jsonObject.put("iTotalRecords", this.iTotalRecords);
		jsonObject.put("aaData", dataArray);
		return jsonObject;
	}
}
