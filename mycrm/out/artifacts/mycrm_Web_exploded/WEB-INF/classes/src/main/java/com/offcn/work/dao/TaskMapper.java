package com.offcn.work.dao;

import com.offcn.work.bean.Task;
import com.offcn.work.bean.TaskExample;
import com.offcn.work.bean.TaskView;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface TaskMapper {
    long countByExample(TaskExample example);

    int deleteByExample(TaskExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Task record);

    int insertSelective(Task record);

    List<Task> selectByExample(TaskExample example);

    Task selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Task record, @Param("example") TaskExample example);

    int updateByExample(@Param("record") Task record, @Param("example") TaskExample example);

    int updateByPrimaryKeySelective(Task record);

    int updateByPrimaryKey(Task record);

    List<TaskView> getTList(Map map);
}