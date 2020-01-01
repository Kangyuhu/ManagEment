package com.offcn.duibiao.service;

import com.offcn.duibiao.bean.Datacollect;
import com.offcn.duibiao.bean.DatacollectSearch;
import com.offcn.duibiao.bean.Indexvalue;
import com.offcn.duibiao.dao.DatacollectMapper;
import com.offcn.duibiao.dao.IndexvalueMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class DbServiceImpl implements DbService {

    @Autowired
    DatacollectMapper dm;

    @Autowired
    IndexvalueMapper im;

    //查找标杆
    public List<Datacollect> getCollectList(Map map) {

        return dm.getCollectList(map);
    }


    //查找指标
    public List<Indexvalue> getIndexvalueList(Map map) {

        return im.getIndexvalueList(map);
    }

//    查看指标名称
    public List<Datacollect> getCollectName() {

        return dm.getCollectName();
    }

//    根据dacname查找对标企业
    public Datacollect getDatacollectByDacname(String dacname) {

        return dm.getDatacollectByDacname(dacname);
    }

//    保存指标
    public int saveIndexValueInfo(Indexvalue indexvalue) {

        return im.insertSelective(indexvalue);
    }

//    保存对标信息
    public int saveCollectMsg(List<Datacollect> dList) {
        int i = 0;
        for (int j = 0; j < dList.size() ; j++) {
            i = dm.insertSelective(dList.get(j));
            i++;
        }

        return i;
    }

//    查找指标附件
    public Indexvalue getByIndexValueInFile(String inFile) {

        return im.getByIndexValueInFile(inFile);
    }

//    条件检索
    public List<Datacollect> getDatacollectSearch(DatacollectSearch datas) {

        return dm.getDatacollectSearch(datas);
    }


}
