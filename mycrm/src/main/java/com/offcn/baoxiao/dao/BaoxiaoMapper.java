package com.offcn.baoxiao.dao;

import com.offcn.baoxiao.bean.Baoxiao;
import com.offcn.baoxiao.bean.BaoxiaoExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface BaoxiaoMapper {
    long countByExample(BaoxiaoExample example);

    int deleteByExample(BaoxiaoExample example);

    int deleteByPrimaryKey(String bxid);

    int insert(Baoxiao record);

    int insertSelective(Baoxiao record);

    List<Baoxiao> selectByExample(BaoxiaoExample example);

    Baoxiao selectByPrimaryKey(String bxid);

    int updateByExampleSelective(@Param("record") Baoxiao record, @Param("example") BaoxiaoExample example);

    int updateByExample(@Param("record") Baoxiao record, @Param("example") BaoxiaoExample example);

    int updateByPrimaryKeySelective(Baoxiao record);

    int updateByPrimaryKey(Baoxiao record);

//    查报销单
    List<Baoxiao> getBaoXiao(Map map);
}