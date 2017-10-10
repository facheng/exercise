package com.dt.tarmag.util;

import java.util.List;

import com.dt.framework.util.Page;

public class PageResult<T>{
	
	private Page page;
	private List<T> datas;

	public PageResult(Page page, List<T> datas) {
		super();
		this.page = page;
		this.datas = datas;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public List<T> getDatas() {
		return datas;
	}

	public void setDatas(List<T> datas) {
		this.datas = datas;
	}

	
}
