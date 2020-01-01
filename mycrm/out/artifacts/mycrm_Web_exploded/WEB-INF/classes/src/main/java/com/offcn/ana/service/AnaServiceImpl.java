package com.offcn.ana.service;

import com.offcn.ana.bean.Analysis;
import com.offcn.ana.dao.AnalysisMapper;
import com.offcn.pro.bean.Project;
import com.offcn.pro.dao.ProjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AnaServiceImpl implements AnaService {

    @Autowired
    AnalysisMapper am;

    @Autowired
    ProjectMapper pm;

//    查找没有需求的项目
    public List<Analysis> getNoneNeed() {
        List<Analysis> list = am.getNoneNeed();
        return list;
    }

//    查找所有项目
    public List<Project> getPro(int pid) {
        Map<Object, Object> map = new HashMap<Object, Object>();
        map.put("pid",pid);
        List<Project> list = pm.getPro(map);
        return list;
    }

//    查找所有
    public List<Analysis> getList() {
        List<Analysis> list = am.selectByExample(null);
        return list;
    }

//    保存
    public int saveInfo(Analysis analysis) {
        int i = am.insertSelective(analysis);

        return i;
    }

//    ID查找
    public Analysis getById(int id) {
        Analysis analysis = am.selectByPrimaryKey(id);

        return analysis;
    }

    public int update(Analysis analysis) {
        int i = am.updateByPrimaryKeySelective(analysis);

        return i;
    }


}
