package com.offcn.duibiao.service;

import com.offcn.duibiao.bean.Datacollect;
import com.offcn.duibiao.bean.DatacollectSearch;
import com.offcn.duibiao.bean.Indexvalue;

import java.util.List;
import java.util.Map;

public interface DbService {

    //查找所有标杆
    List<Datacollect> getCollectList(Map map);

    //查找所有指标
    List<Indexvalue> getIndexvalueList(Map map);

    //    查看标杆名称
    List<Datacollect> getCollectName();

    //    根据dacname查找标杆
    Datacollect getDatacollectByDacname(String dacname);

    //    保存指标
    int saveIndexValueInfo(Indexvalue indexvalue);

    //    保存对标
    int saveCollectMsg(List<Datacollect> dList);

    //查找指标附件
    Indexvalue getByIndexValueInFile(String inFile);

//    条件检索
List<Datacollect> getDatacollectSearch(DatacollectSearch datas);
}
