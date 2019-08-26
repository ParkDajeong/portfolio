package com.dajeong.myapp.dto;

public class Pagination {
	//총 게시글 수
	private int contentCnt;
	//한 페이지 당 보여줄 게시글 수
	private int contentViewCnt = 10;
	//시작 게시글
	private int startContent;
	//현재 페이지
	private int page;
	//전체 페이지 수
	private int pageCnt;
	//페이지네이션 시작 번호
	private int startPage;
	//페이지네이션 끝 번호
	private int endPage;
	//페이지네이션에 보여질 최대 페이지 수
	private int pageRangeSize = 10;
	//현재 페이지가 속한 페이지네이션 범위
	private int pageRange;
	//이전 페이지 유무
	private boolean prev;
	//다음 페이지 유무
	private boolean next;
	
	
	public void pageInfo(int contentCnt, int page, int pageRange) {
		this.contentCnt = contentCnt;
		this.page = page;
		this.pageRange = pageRange;
		
		this.pageCnt = (int)Math.ceil(contentCnt*1.0/contentViewCnt);
		this.startPage = (pageRange - 1) * pageRangeSize + 1;
		this.endPage = pageRange * pageRangeSize;
		this.startContent = (page - 1) * contentViewCnt;
		
		this.prev = pageRange != 1 ? true : false;
		//this.next = endPage > pageCnt ? false : true;
		if(this.endPage > this.pageCnt) {
			this.endPage = this.pageCnt;
			this.next = false;
		} else {
			this.next = true;
		}
	}
	
	public int getContentCnt() {
		return contentCnt;
	}
	public void setContentCnt(int contentCnt) {
		this.contentCnt = contentCnt;
	}
	public int getContentViewCnt() {
		return contentViewCnt;
	}
	public void setContentViewCnt(int contentViewCnt) {
		this.contentViewCnt = contentViewCnt;
	}
	public int getStartContent() {
		return startContent;
	}
	public void setStartContent(int startContent) {
		this.startContent = startContent;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getPageCnt() {
		return pageCnt;
	}
	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getPageRangeSize() {
		return pageRangeSize;
	}
	public void setPageRangeSize(int pageRangeSize) {
		this.pageRangeSize = pageRangeSize;
	}
	public int getPageRange() {
		return pageRange;
	}
	public void setPageRange(int pageRange) {
		this.pageRange = pageRange;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	
}
