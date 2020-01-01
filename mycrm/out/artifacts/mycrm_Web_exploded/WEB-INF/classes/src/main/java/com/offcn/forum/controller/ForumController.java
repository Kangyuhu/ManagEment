package com.offcn.forum.controller;

import com.offcn.emp.bean.Employee;
import com.offcn.forum.bean.Evaluate;
import com.offcn.forum.bean.Forumpost;
import com.offcn.forum.service.ForumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("forum")
public class ForumController {

    @Autowired
    ForumService fs;

//    查找所有贴汁
    @RequestMapping("getForumList")
    @ResponseBody
    public List<Forumpost> getForumList() {
        List<Forumpost> forList = fs.getForumList();

    		return forList;
    }

//    查看贴汁详情
    @RequestMapping("getByForumID")
    public String getByForumID(@RequestParam(defaultValue = "0") int  forumid,
                               Model model) {
        Forumpost forumpost = fs.getByForumID(forumid);
        model.addAttribute("forumpost",forumpost);

    		return "forum-reply";
    }


//    发表评论
    @RequestMapping("addEvaluate")
    public String addEvaluate(Evaluate eva, HttpSession session) {
        Employee usr = (Employee) session.getAttribute("usr");
        eva.setEmpFk4(usr.getEid());
        eva.setUpdatetime(new Date());
        eva.setEvatime(new Date());

        int i = fs.saveEvaluate(eva);
        if (i > 0){
            return "redirect:/forum/getByForumID?forumid="+eva.getForumFk();
        }else {
            return "error";
        }

    }


//查看我的帖子
    @RequestMapping("getMyForumList")
    public String getMyForumList(@RequestParam(defaultValue = "0") int eid,
                                          Model modle) {
            List<Forumpost> forum = fs.getMyForumList(eid);
            modle.addAttribute("forum",forum);
    		return "forum-showmyself";
    }


//    发表帖子
    @RequestMapping("addForumpost")
    public String addForumpost(Forumpost forumpost,HttpSession session) {
        Employee usr = (Employee) session.getAttribute("usr");
        forumpost.setEmpFk3(usr.getEid());
        forumpost.setCreatetime(new Date());
        int i = fs.saveForumpost(forumpost);
        if (i > 0){
            return "redirect:/forum/getMyForumList";
        }
    		return "redirect:/error.jsp";
    }


}
