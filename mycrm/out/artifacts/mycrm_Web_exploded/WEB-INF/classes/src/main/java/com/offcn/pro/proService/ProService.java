package com.offcn.pro.proService;

import com.github.pagehelper.PageInfo;
import com.offcn.pro.bean.Project;

import java.util.List;
import java.util.Map;

public interface ProService {


//   分页查找
    PageInfo<Project> getPage(Map map);

//   查找所有
    List<Project> getList();

//   保存
    int saveInfo(Project pro);

    Project getPro(int id);

    int update(Project pro);

    int delePro(List<Integer> id);
}
