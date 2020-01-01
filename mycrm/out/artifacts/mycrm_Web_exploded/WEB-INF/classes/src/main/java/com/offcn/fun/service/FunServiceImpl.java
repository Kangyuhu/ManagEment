package com.offcn.fun.service;

import com.offcn.fun.bean.FunList;
import com.offcn.fun.bean.Function;
import com.offcn.fun.bean.FunctionExample;
import com.offcn.fun.dao.FunctionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FunServiceImpl implements FunService {

    @Autowired
    FunctionMapper fm;

//    查找所有
    public List<FunList> getFList() {
        List<FunList> list = fm.getFList();
        return list;
    }

    public List<Function> getFunByMid(int mid) {
        FunctionExample fe = new FunctionExample();
        FunctionExample.Criteria cc = fe.createCriteria();
        cc.andModeleFkEqualTo(mid);
        List<Function> list = fm.selectByExample(fe);
        return list;
    }

    public Function getById(Integer funFk) {
        Function fun = fm.selectByPrimaryKey(funFk);

        return fun;
    }

//    保存
    public int saveInfo(Function fun) {

        return fm.insertSelective(fun);
    }
}
