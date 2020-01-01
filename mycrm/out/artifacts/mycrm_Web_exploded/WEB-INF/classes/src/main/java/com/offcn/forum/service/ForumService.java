package com.offcn.forum.service;

import com.offcn.forum.bean.Evaluate;
import com.offcn.forum.bean.Forumpost;

import java.util.List;

public interface ForumService {

    //查找所有贴汁
    List<Forumpost> getForumList();


//    查看贴汁详情
    Forumpost getByForumID(int forumid);

//    发表评论
    int saveEvaluate(Evaluate eva);

//    查找我的帖子
    List<Forumpost> getMyForumList(int eid);

//    发表帖子
    int saveForumpost(Forumpost forumpost);
}
