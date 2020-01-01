package com.offcn.pro.dao;

import com.offcn.pro.bean.Project;
import com.offcn.pro.bean.ProjectExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ProjectMapper {
    long countByExample(ProjectExample example);

    int deleteByExample(ProjectExample example);

    int deleteByPrimaryKey(Integer pid);

    int insert(Project record);

    int insertSelective(Project record);

    List<Project> selectByExample(ProjectExample example);

    Project selectByPrimaryKey(Integer pid);

    int updateByExampleSelective(@Param("record") Project record, @Param("example") ProjectExample example);

    int updateByExample(@Param("record") Project record, @Param("example") ProjectExample example);

    int updateByPrimaryKeySelective(Project record);

    int updateByPrimaryKey(Project record);

    List<Project> getPage(Map map);

    List<Project> getPro(Map map);
}