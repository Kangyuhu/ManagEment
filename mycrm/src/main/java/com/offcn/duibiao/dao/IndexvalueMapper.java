package com.offcn.duibiao.dao;

import com.offcn.duibiao.bean.Indexvalue;
import com.offcn.duibiao.bean.IndexvalueExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface IndexvalueMapper {
    long countByExample(IndexvalueExample example);

    int deleteByExample(IndexvalueExample example);

    int deleteByPrimaryKey(Integer inId);

    int insert(Indexvalue record);

    int insertSelective(Indexvalue record);

    List<Indexvalue> selectByExample(IndexvalueExample example);

    Indexvalue selectByPrimaryKey(Integer inId);

    int updateByExampleSelective(@Param("record") Indexvalue record, @Param("example") IndexvalueExample example);

    int updateByExample(@Param("record") Indexvalue record, @Param("example") IndexvalueExample example);

    int updateByPrimaryKeySelective(Indexvalue record);

    int updateByPrimaryKey(Indexvalue record);

//    查找所有指标
    List<Indexvalue> getIndexvalueList(Map map);

//    查找指标附件
    Indexvalue getByIndexValueInFile(String inFile);
}