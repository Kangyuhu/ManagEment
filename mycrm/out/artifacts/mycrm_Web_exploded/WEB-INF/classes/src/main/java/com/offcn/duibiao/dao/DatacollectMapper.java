package com.offcn.duibiao.dao;

import com.offcn.duibiao.bean.Datacollect;
import com.offcn.duibiao.bean.DatacollectExample;
import com.offcn.duibiao.bean.DatacollectSearch;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface DatacollectMapper {
    long countByExample(DatacollectExample example);

    int deleteByExample(DatacollectExample example);

    int deleteByPrimaryKey(Integer daid);

    int insert(Datacollect record);

    int insertSelective(Datacollect record);

    List<Datacollect> selectByExample(DatacollectExample example);

    Datacollect selectByPrimaryKey(Integer daid);

    int updateByExampleSelective(@Param("record") Datacollect record, @Param("example") DatacollectExample example);

    int updateByExample(@Param("record") Datacollect record, @Param("example") DatacollectExample example);

    int updateByPrimaryKeySelective(Datacollect record);

    int updateByPrimaryKey(Datacollect record);

    List<Datacollect> getCollectList(Map map);

    List<Datacollect> getCollectName();

    //    查找指定公司
    Datacollect getDatacollectByDacname(String dacname);

    //    条件检索
    List<Datacollect> getDatacollectSearch(DatacollectSearch search);
}