package com.offcn.work.service;

import com.offcn.work.bean.Msg;
import com.offcn.work.bean.MsgExample;
import com.offcn.work.dao.MsgMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MsgServiceImpl implements MsgService {

    @Autowired
    MsgMapper mm;


//    查找我的消息
    public List<Msg> getMyMsgList(Integer eid) {
        return mm.getMyMsgList(eid);
    }

//    getID
    public Msg getByMsgId(int msgid) {
        return mm.selectByPrimaryKey(msgid);
    }

//    删除
    public int delById(int msgid) {
        return mm.deleteByPrimaryKey(msgid);
    }

    public int updateMsg_Mark(Msg msg) {

        return mm.updateByPrimaryKeySelective(msg);
    }

    public List<Msg> getUnreadMsg(Integer eid) {
        MsgExample me = new MsgExample();
        MsgExample.Criteria cc = me.createCriteria();
        cc.andRecvpEqualTo(eid);
        cc.andMarkEqualTo(0);
        List<Msg> msgs = mm.selectByExample(me);
        if (null != msgs){
            return msgs;
        }else {
            return null;
        }


    }
}
