package com.offcn.ana.service;

import com.offcn.ana.bean.Analysis;
import com.offcn.pro.bean.Project;

import java.util.List;

public interface AnaService {

//    查找没有需求的项目
    List<Analysis> getNoneNeed();

//      查找项目
    List<Project> getPro(int i);

//    查找所有需求
    List<Analysis> getList();

//    保存
    int saveInfo(Analysis analysis);

//    根据ID查找
    Analysis getById(int id);

//    根据ID修改
    int update(Analysis analysis);
}
