package com.tity.entity;

public class PageCunit {
	
	private String cunityName;
	private String cunityClounm;
	private Integer page = 1;
	private Integer start;
	private Integer size = 50;
	
	public String getCunityName() {
		return cunityName;
	}
	public void setCunityName(String cunityName) {
		this.cunityName = cunityName;
	}
	public String getCunityClounm() {
		return cunityClounm;
	}
	public void setCunityClounm(String cunityClounm) {
		this.cunityClounm = cunityClounm;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public Integer getSize() {
		return size;
	}
	public void setSize(Integer size) {
		this.size = size;
	}
	
}
