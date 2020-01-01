package com.offcn.auth.service;

import com.github.pagehelper.PageInfo;
import com.offcn.auth.bean.EmpRole;
import com.offcn.auth.bean.Role;
import com.offcn.auth.bean.Sources;
import com.offcn.emp.bean.Dept;
import com.offcn.emp.bean.Employee;
import com.offcn.emp.bean.Level;
import com.offcn.emp.bean.Position;

import java.util.List;
import java.util.Map;

public interface AuthService {

    //    人员管理
    PageInfo<Employee> getEmpAll(Map map);

    //     职位
    List<Position> getPositionAll();

    //    等级
    List<Level> getLevelAll();

    //    部门
    List<Dept> getDeptAll();

    //    角色
    List<Role> getRoleAll();

    //    保存新用户
    int SaveEmp(Employee employee, String roleid);

    //    根据用户ID查找角色
    EmpRole getEmp_RoleEmpFkTo(int eid);

    //    保存修改
    int UpdateEmp(Employee employee, String roleid);

    //    查找所有节点
    List<Sources> getSources();

    //    保存资源
    int saveSources(Sources sources);

    //    删除资源
    int deleteSources(int sid);

    //    修改资源
    int updateSources(Sources sources);

    //    根据查找资源
    Sources getSourcesById(int id);

    //    保存角色
    int saveRole(String sids, Role role);

    //    删除角色
    int deleRole(int roleid);

    //    根据主键查找角色
    Role getRoleById(int roleid);

    //    获取莫个角色所有的权限
    String getRoleSources_SidByRoleid(int roleid);

    //    修改角色
    int updRole(Role role,String sid);

//    显示菜单栏
    List<Sources> getSource(Map map);
}
