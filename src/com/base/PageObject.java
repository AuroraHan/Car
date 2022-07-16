package com.base;

import java.util.ArrayList;
import java.util.List;
public class PageObject {
	//当前页
	private int cur_page=1;
	//每页显示的记录数
	public static int  pageRow=30;
	//记录总数
	private int totalRows;
	//开始位置
	private int startRow;
	//数据
	private List datas;

	//总页数
	private int pageCount;
	public int getPageCount() {
		pageCount = (int)Math.ceil(totalRows*1.0/pageRow*1.0);
		return pageCount;
	}
	public int getCur_page() {
		return cur_page;
	}
	public void setCur_page(int cur_page) {
		this.cur_page = cur_page;
	}
	public int getPageRow() {
		return pageRow;
	}
	public void setPageRow(int pageRow) {
		this.pageRow = pageRow;
	}
	public int getTotalRows() {
		return totalRows;
	}
	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}
	public List getDatas() {
		return datas;
	}
	public void setDatas(List datas) {
		this.datas = datas;
	}
	public int getStartRow() {

		this.startRow = (this.cur_page-1)*this.pageRow;
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
}
