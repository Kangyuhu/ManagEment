package com.offcn.work.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.work.bean.Task;
import com.offcn.work.bean.TaskView;
import com.offcn.work.dao.TaskMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class TaskServiceImpl implements TaskService {

    @Autowired
    TaskMapper tm;


//    分页显示
    public PageInfo<TaskView> getTList(Map map) {
        PageHelper.startPage((Integer) map.get("pageNO"),3);
        List<TaskView> tList = tm.getTList(map);
        PageInfo<TaskView> info = new PageInfo<TaskView>(tList);

        return info;
    }

//    保存添加
    public int saveInfo(Task taskView) {
        int i = tm.insertSelective(taskView);

        return i;
    }

//    保存修改
    public int update(Task taskView) {
        int i = tm.updateByPrimaryKeySelective(taskView);

        return i;
    }

    public Task getById(int id) {
        Task task = tm.selectByPrimaryKey(id);

        return task;
    }
}
