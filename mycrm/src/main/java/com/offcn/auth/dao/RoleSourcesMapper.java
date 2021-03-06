package com.offcn.auth.dao;

import com.offcn.auth.bean.RoleSources;
import com.offcn.auth.bean.RoleSourcesExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoleSourcesMapper {
    long countByExample(RoleSourcesExample example);

    int deleteByExample(RoleSourcesExample example);

    int deleteByPrimaryKey(Integer rsid);

    int insert(RoleSources record);

    int insertSelective(RoleSources record);

    List<RoleSources> selectByExample(RoleSourcesExample example);

    RoleSources selectByPrimaryKey(Integer rsid);

    int updateByExampleSelective(@Param("record") RoleSources record, @Param("example") RoleSourcesExample example);

    int updateByExample(@Param("record") RoleSources record, @Param("example") RoleSourcesExample example);

    int updateByPrimaryKeySelective(RoleSources record);

    int updateByPrimaryKey(RoleSources record);

    int insertAll(List<RoleSources> liat);

    //    获取莫个角色所有的权限
    String getRoleSources_SidByRoleid(int roleid);
}