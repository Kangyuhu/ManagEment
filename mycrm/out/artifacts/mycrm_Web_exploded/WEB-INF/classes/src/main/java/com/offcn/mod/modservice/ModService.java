package com.offcn.mod.modservice;

import com.offcn.mod.bean.Module;

import java.util.List;

public interface ModService {
//    查找所有
    List<Module> getMList();


    int saveInfo(Module mod);

    int update(Module mod);

    List<Module> getById(int id);

    Module getByIdO(int id);
}
