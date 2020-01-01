package com.offcn.work.dao;

import com.offcn.work.bean.Msg;
import com.offcn.work.bean.MsgExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MsgMapper {
    long countByExample(MsgExample example);

    int deleteByExample(MsgExample example);

    int deleteByPrimaryKey(Integer msgid);

    int insert(Msg record);

    int insertSelective(Msg record);

    List<Msg> selectByExample(MsgExample example);

    Msg selectByPrimaryKey(Integer msgid);

    int updateByExampleSelective(@Param("record") Msg record, @Param("example") MsgExample example);

    int updateByExample(@Param("record") Msg record, @Param("example") MsgExample example);

    int updateByPrimaryKeySelective(Msg record);

    int updateByPrimaryKey(Msg record);

    List<Msg> getMyMsgList(int eid);
}