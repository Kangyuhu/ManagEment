package com.offcn.forum.service;

import com.offcn.emp.bean.Employee;
import com.offcn.emp.dao.EmployeeMapper;
import com.offcn.forum.bean.Evaluate;
import com.offcn.forum.bean.EvaluateExample;
import com.offcn.forum.bean.Forumpost;
import com.offcn.forum.bean.ForumpostExample;
import com.offcn.forum.dao.EvaluateMapper;
import com.offcn.forum.dao.ForumpostMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ForumServiceImpl implements ForumService {

    @Autowired
    ForumpostMapper fm;

    @Autowired
    EmployeeMapper em;

    @Autowired
    EvaluateMapper elm;


//    查找所有贴汁
    public List<Forumpost> getForumList() {

        return fm.selectByExample(null);
    }

//    查看贴汁详情
    public Forumpost getByForumID(int forumid) {
//        根据ID查找贴汁
        Forumpost foru = fm.selectByPrimaryKey(forumid);
//        查找发帖人
        Employee emp = em.selectByPrimaryKey(foru.getEmpFk3());
        foru.setEmp(emp);
//        查找所有直接评论
        EvaluateExample ee = new EvaluateExample();
        EvaluateExample.Criteria cc = ee.createCriteria();
        cc.andForumFkEqualTo(foru.getForumid());
        cc.andEvaidFkIsNull();
        List<Evaluate> elist = elm.selectByExample(ee);
        getReply(elist);
        foru.setEvaluate(elist);

        return foru;
    }

//    发表评论
    public int saveEvaluate(Evaluate eva) {

        return elm.insertSelective(eva);
    }

//    查找我的帖子
    public List<Forumpost> getMyForumList(int eid) {
        ForumpostExample fe = new ForumpostExample();
        ForumpostExample.Criteria cc = fe.createCriteria();
        cc.andEmpFk3EqualTo(eid);

        return fm.selectByExample(fe);
    }

//    发帖子
    public int saveForumpost(Forumpost forumpost) {

        return fm.insertSelective(forumpost);
    }


    //    回复
    public void getReply(List<Evaluate> elist) {
        for (Evaluate ev : elist) {
//            查找评论
            Employee emp = em.selectByPrimaryKey(ev.getEmpFk4());
            ev.setEmp(emp);

//            查看回复
            EvaluateExample ee = new EvaluateExample();
            EvaluateExample.Criteria cc = ee.createCriteria();
            cc.andForumFkEqualTo(ev.getForumFk());
            cc.andEvaidFkEqualTo(ev.getEvaid());
            List<Evaluate> ReplyList = elm.selectByExample(ee);
            if (ReplyList != null && ReplyList.size()>0){
                ev.setEvaluates(ReplyList);
                getReply(ReplyList);
            }

        }
    }
}
