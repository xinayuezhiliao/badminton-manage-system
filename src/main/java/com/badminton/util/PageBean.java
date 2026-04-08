package com.badminton.util;

import java.util.List;

public class PageBean<T> {
    private List<T> list;
    private int pageNo;
    private int pageSize;
    private int totalCount;
    private int totalPage;

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        this.totalPage = (totalCount + pageSize - 1) / pageSize;
    }

    public int getTotalPage() {
        return totalPage;
    }
}