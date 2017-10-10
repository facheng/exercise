package com.dt.tarmag.util;

import com.dt.framework.util.Page;

/**
 * @author raymond
 * jquery dataTable 发送给后台的参数
 */
public class DataTableParams {
	private int iDisplayStart=0;// 显示的起始索引
	private int iDisplayLength=10;// 显示的行数
	private int iColumns;// 显示的列数
	private String sColumns;// 显示的列
	private String sSearch;// 全局搜索字段
	private boolean bEscapeRegex;// 全局搜索是否正则
	private boolean bSortable_;// 表示一列是否在客户端被标志位可排序
	private boolean bSearchable_;// 表示一列是否在客户端被标志位可搜索
	private String sSearch_;// 个别列的搜索
	private boolean bEscapeRegex_;// 个别列是否使用正则搜索
	private int iSortingCols;// 排序的列数
	private int iSortCol_;// 被排序的列
	private String sSortDir_;// 排序的方向 "desc" 或者 "asc".
	private String sEcho;// 用来生成的信息

	public int getiDisplayStart() {
		return iDisplayStart;
	}

	public void setiDisplayStart(int iDisplayStart) {
		this.iDisplayStart = iDisplayStart;
	}

	public int getiDisplayLength() {
		return iDisplayLength;
	}

	public void setiDisplayLength(int iDisplayLength) {
		this.iDisplayLength = iDisplayLength;
	}

	public int getiColumns() {
		return iColumns;
	}

	public void setiColumns(int iColumns) {
		this.iColumns = iColumns;
	}

	public String getsSearch() {
		return sSearch;
	}

	public void setsSearch(String sSearch) {
		this.sSearch = sSearch;
	}

	public boolean isbEscapeRegex() {
		return bEscapeRegex;
	}

	public void setbEscapeRegex(boolean bEscapeRegex) {
		this.bEscapeRegex = bEscapeRegex;
	}

	public boolean isbSortable_() {
		return bSortable_;
	}

	public void setbSortable_(boolean bSortable_) {
		this.bSortable_ = bSortable_;
	}

	public boolean isbSearchable_() {
		return bSearchable_;
	}

	public void setbSearchable_(boolean bSearchable_) {
		this.bSearchable_ = bSearchable_;
	}

	public String getsSearch_() {
		return sSearch_;
	}

	public void setsSearch_(String sSearch_) {
		this.sSearch_ = sSearch_;
	}

	public boolean isbEscapeRegex_() {
		return bEscapeRegex_;
	}

	public void setbEscapeRegex_(boolean bEscapeRegex_) {
		this.bEscapeRegex_ = bEscapeRegex_;
	}

	public int getiSortingCols() {
		return iSortingCols;
	}

	public void setiSortingCols(int iSortingCols) {
		this.iSortingCols = iSortingCols;
	}

	public int getiSortCol_() {
		return iSortCol_;
	}

	public void setiSortCol_(int iSortCol_) {
		this.iSortCol_ = iSortCol_;
	}

	public String getsSortDir_() {
		return sSortDir_;
	}

	public void setsSortDir_(String sSortDir_) {
		this.sSortDir_ = sSortDir_;
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

	public Page getPage(){
		Page page = new Page();
		page.setCurrentPage(this.iDisplayStart/this.iDisplayLength + 1);
		page.setPageSize(this.iDisplayLength);
		return page;
	}

	@Override
	public String toString() {
		return "DataTableParams [iDisplayStart=" + iDisplayStart
				+ ", iDisplayLength=" + iDisplayLength + ", iColumns="
				+ iColumns + ", sColumns=" + sColumns + ", sSearch=" + sSearch
				+ ", bEscapeRegex=" + bEscapeRegex + ", bSortable_="
				+ bSortable_ + ", bSearchable_=" + bSearchable_ + ", sSearch_="
				+ sSearch_ + ", bEscapeRegex_=" + bEscapeRegex_
				+ ", iSortingCols=" + iSortingCols + ", iSortCol_=" + iSortCol_
				+ ", sSortDir_=" + sSortDir_ + ", sEcho=" + sEcho + "]";
	}
	
}
