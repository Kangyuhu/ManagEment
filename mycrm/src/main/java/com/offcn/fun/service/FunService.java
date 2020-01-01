package com.offcn.fun.service;

import com.offcn.fun.bean.FunList;
import com.offcn.fun.bean.Function;

import java.util.List;

public interface FunService {
//    查找所有
    List<FunList>getFList();


    List<Function> getFunByMid(int mid);

    Function getById(Integer funFk);

    int saveInfo(Function fun);
}
