package com.offcn.mod.modservice;

import com.offcn.mod.bean.Module;
import com.offcn.mod.bean.ModuleExample;
import com.offcn.mod.dao.ModuleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ModServiceImpl implements ModService {

    @Autowired
    ModuleMapper mm;

//    查找所有
    public List<Module> getMList() {
        List<Module> mList = mm.getMList();

        return mList;
    }

    public int saveInfo(Module mod) {
        int insert = mm.insert(mod);
        return insert;
    }

    public int update(Module mod) {
        int i = mm.updateByPrimaryKeySelective(mod);

        return i;
    }

    public List<Module> getById(int id) {
        ModuleExample me = new ModuleExample();
        ModuleExample.Criteria cc = me.createCriteria();
        cc.andAnalysisFkEqualTo(id);
        List<Module> modules = mm.selectByExample(me);

        return modules;
    }

    public Module getByIdO(int id) {
        Module module = mm.selectByPrimaryKey(id);
        return module;
    }
}
