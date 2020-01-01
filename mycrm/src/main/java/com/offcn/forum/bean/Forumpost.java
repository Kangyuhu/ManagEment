package com.offcn.forum.bean;

import com.offcn.emp.bean.Employee;

import java.util.Date;
import java.util.List;

public class Forumpost {
    private Integer forumid;

    private String forumtitle;

    private String forumcontent;

    private Integer empFk3;

    private Date createtime;

    private Integer status;

//    发帖人
    private Employee emp;

//    评论
    private List<Evaluate> evaluate;

    public Employee getEmp() {
        return emp;
    }

    public void setEmp(Employee emp) {
        this.emp = emp;
    }

    public List<Evaluate> getEvaluate() {
        return evaluate;
    }

    public void setEvaluate(List<Evaluate> evaluate) {
        this.evaluate = evaluate;
    }

    public Integer getForumid() {
        return forumid;
    }

    public void setForumid(Integer forumid) {
        this.forumid = forumid;
    }

    public String getForumtitle() {
        return forumtitle;
    }

    public void setForumtitle(String forumtitle) {
        this.forumtitle = forumtitle == null ? null : forumtitle.trim();
    }

    public String getForumcontent() {
        return forumcontent;
    }

    public void setForumcontent(String forumcontent) {
        this.forumcontent = forumcontent == null ? null : forumcontent.trim();
    }

    public Integer getEmpFk3() {
        return empFk3;
    }

    public void setEmpFk3(Integer empFk3) {
        this.empFk3 = empFk3;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}