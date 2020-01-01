package com.offcn.duibiao.bean;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class DatacollectSearch {
    //    企业名称
    private String dname;

    //    开始时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startTime;

    //    结束时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endTime;

    public String getDname() {
        return dname;
    }

    public void setDname(String dname) {
        this.dname = dname;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }
}
