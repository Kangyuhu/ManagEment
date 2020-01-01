package com.offcn.ana.dao;

import com.offcn.ana.bean.Analysis;
import com.offcn.ana.bean.AnalysisExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AnalysisMapper {
    long countByExample(AnalysisExample example);

    int deleteByExample(AnalysisExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Analysis record);

    int insertSelective(Analysis record);

    List<Analysis> selectByExample(AnalysisExample example);

    Analysis selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Analysis record, @Param("example") AnalysisExample example);

    int updateByExample(@Param("record") Analysis record, @Param("example") AnalysisExample example);

    int updateByPrimaryKeySelective(Analysis record);

    int updateByPrimaryKey(Analysis record);

    List<Analysis> getNoneNeed();
}