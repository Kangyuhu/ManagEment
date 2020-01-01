package com.offcn.pro.proService;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.pro.bean.Project;
import com.offcn.pro.bean.ProjectExample;
import com.offcn.pro.dao.ProjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ProServiceImpl implements ProService {

    @Autowired
    ProjectMapper pm;

//    /分页查找
    public PageInfo<Project> getPage(Map map) {
        PageHelper.startPage((Integer) map.get("pageNO"),4);
        List<Project> list = pm.getPage(map);
        PageInfo<Project> info = new PageInfo<Project>(list);

        return info;
    }

//    查找所有
    public List<Project> getList() {
        List<Project> list = pm.selectByExample(null);
        return list;
    }
//      保存
    public int saveInfo(Project pro) {
        int i = pm.insert(pro);
        return i;
    }

//    getPro
    public Project getPro(int id) {
        Project project = pm.selectByPrimaryKey(id);

        return project;
    }

    public int update(Project pro) {

        int i = pm.updateByPrimaryKeySelective(pro);

        return i;
    }


//    删除
    public int delePro(List<Integer> id) {
        ProjectExample pro = new ProjectExample();
        ProjectExample.Criteria cc = pro.createCriteria();
        cc.andPidIn(id);

        return pm.deleteByExample(pro);
    }


}
