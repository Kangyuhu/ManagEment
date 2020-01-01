package com.offcn.work.service;

import com.offcn.work.bean.Msg;

import java.util.List;


public interface MsgService {

//查找我的消息
    List<Msg> getMyMsgList(Integer eid);

    Msg getByMsgId(int msgid);

    int delById(int msgid);

    int updateMsg_Mark(Msg msg);

    List<Msg> getUnreadMsg(Integer eid);
}

