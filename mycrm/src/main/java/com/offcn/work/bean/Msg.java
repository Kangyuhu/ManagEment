package com.offcn.work.bean;

import com.offcn.emp.bean.Employee;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Msg {
    private Integer msgid;

    private Integer sendp;

    private Integer recvp;

    private Integer mark;

    private String msgcontent;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date msgtime;

    private Employee emp;

    public Employee getEmp() {
        return emp;
    }

    public void setEmp(Employee emp) {
        this.emp = emp;
    }

    public Integer getMsgid() {
        return msgid;
    }

    public void setMsgid(Integer msgid) {
        this.msgid = msgid;
    }

    public Integer getSendp() {
        return sendp;
    }

    public void setSendp(Integer sendp) {
        this.sendp = sendp;
    }

    public Integer getRecvp() {
        return recvp;
    }

    public void setRecvp(Integer recvp) {
        this.recvp = recvp;
    }

    public Integer getMark() {
        return mark;
    }

    public void setMark(Integer mark) {
        this.mark = mark;
    }

    public String getMsgcontent() {
        return msgcontent;
    }

    public void setMsgcontent(String msgcontent) {
        this.msgcontent = msgcontent == null ? null : msgcontent.trim();
    }

    public Date getMsgtime() {
        return msgtime;
    }

    public void setMsgtime(Date msgtime) {
        this.msgtime = msgtime;
    }
}