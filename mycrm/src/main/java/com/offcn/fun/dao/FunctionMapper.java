package com.offcn.fun.dao;

import com.offcn.fun.bean.FunList;
import com.offcn.fun.bean.Function;
import com.offcn.fun.bean.FunctionExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FunctionMapper {
    long countByExample(FunctionExample example);

    int deleteByExample(FunctionExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Function record);

    int insertSelective(Function record);

    List<Function> selectByExample(FunctionExample example);

    Function selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Function record, @Param("example") FunctionExample example);

    int updateByExample(@Param("record") Function record, @Param("example") FunctionExample example);

    int updateByPrimaryKeySelective(Function record);

    int updateByPrimaryKey(Function record);

    List<FunList> getFList();
}