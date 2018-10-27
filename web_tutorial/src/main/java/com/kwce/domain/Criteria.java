package com.kwce.domain;

public class Criteria {
	private int page;
	private int perPageNum; // 페이지당 보여지는 개수 
	
	
	public Criteria() {
		super();
		this.page = 1;
		this.perPageNum = 10;
	}

	public int getPage() {
		return page;
	}

	/**
	 * @param page 몇 페이지씩 보여줄 것인가를 설정한다. 
	 */
	public void setPage(int page) {
		if(page<0) {
			this.page = 1;
			return; 
		}
		this.page = page;
	}
	
	/**
	 * @param perPageNum 몇 페이지씩 보여줄 것인가를 설정한다. 
	 */
	public void setPerpageNum(int perPageNum) {
		if(perPageNum <=0 || perPageNum > 100) {
			this.perPageNum=10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	// sql에 20=> 시작점 번호, 개수 이렇게 넣기 위해서
	/**
	 * @return sql에 넣을 시작점 번호를 리턴 한다.  
	 */
	
	public int getPageStart() {
		return (this.page - 1)*perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	@Override
	public String toString() {
		return "PageCriteria [page=" + page + ", perPageNum=" + perPageNum + "]";
	}
	
	
}
