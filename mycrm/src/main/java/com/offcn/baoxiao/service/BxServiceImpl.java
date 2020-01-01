package com.offcn.baoxiao.service;

import com.github.pagehelper.PageInfo;
import com.offcn.baoxiao.bean.Baoxiao;
import com.offcn.baoxiao.dao.BaoxiaoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class BxServiceImpl implements BxService {

    @Autowired
    BaoxiaoMapper bm;

//    查找所有
    public PageInfo<Baoxiao> getBaoXiao(Map map) {
        List<Baoxiao> baoxiaoList = bm.getBaoXiao(map);
        return new PageInfo(baoxiaoList);
    }

//    ID查找
    public Baoxiao getByBaoXiao(String bxid) {
        return bm.selectByPrimaryKey(bxid);
    }

//    修改
    public int updaBaoXiao(Baoxiao baoxiao) {
        return bm.updateByPrimaryKeySelective(baoxiao);
    }


//    保存
    public int saveBaoXiao(Baoxiao baoxiao) {
        return bm.insertSelective(baoxiao);
    }
}
