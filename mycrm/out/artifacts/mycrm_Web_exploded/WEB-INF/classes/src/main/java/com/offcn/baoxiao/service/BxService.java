package com.offcn.baoxiao.service;

import com.github.pagehelper.PageInfo;
import com.offcn.baoxiao.bean.Baoxiao;

import java.util.Map;

public interface BxService {

    PageInfo<Baoxiao> getBaoXiao(Map map);

    Baoxiao getByBaoXiao(String bxid);

    int updaBaoXiao(Baoxiao baoxiao);

    int saveBaoXiao(Baoxiao baoxiao);
}
