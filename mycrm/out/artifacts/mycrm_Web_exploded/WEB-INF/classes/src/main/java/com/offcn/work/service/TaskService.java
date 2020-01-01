package com.offcn.work.service;

import com.github.pagehelper.PageInfo;
import com.offcn.work.bean.Task;
import com.offcn.work.bean.TaskView;

import java.util.Map;


public interface TaskService {

    PageInfo<TaskView> getTList(Map map);

    int saveInfo(Task taskView);

    int update(Task taskView);

    Task getById(int id);

}
