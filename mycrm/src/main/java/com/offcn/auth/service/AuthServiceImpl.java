package com.offcn.auth.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.auth.bean.*;
import com.offcn.auth.dao.EmpRoleMapper;
import com.offcn.auth.dao.RoleMapper;
import com.offcn.auth.dao.RoleSourcesMapper;
import com.offcn.auth.dao.SourcesMapper;
import com.offcn.emp.bean.Dept;
import com.offcn.emp.bean.Employee;
import com.offcn.emp.bean.Level;
import com.offcn.emp.bean.Position;
import com.offcn.emp.dao.DeptMapper;
import com.offcn.emp.dao.EmployeeMapper;
import com.offcn.emp.dao.LevelMapper;
import com.offcn.emp.dao.PositionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    EmployeeMapper empm;

    @Autowired
    PositionMapper posm;

    @Autowired
    LevelMapper lm;

    @Autowired
    DeptMapper dm;

    @Autowired
    RoleMapper rm;

    @Autowired
    EmpRoleMapper erm;

    @Autowired
    SourcesMapper sm;

    @Autowired
    RoleSourcesMapper rsm;


    //    人员管理
    public PageInfo<Employee> getEmpAll(Map map) {
        PageHelper.startPage((Integer) map.get("pageNO"), 5);
        List<Employee> empAll = empm.getEmpAll(map);
        PageInfo<Employee> info = new PageInfo(empAll);

        return info;
    }

    //    职位
    public List<Position> getPositionAll() {

        return posm.selectByExample(null);
    }

    //    等级
    public List<Level> getLevelAll() {

        return lm.selectByExample(null);
    }

    //    部门
    public List<Dept> getDeptAll() {

        return dm.selectByExample(null);

    }

    //    角色
    public List<Role> getRoleAll() {

        return rm.selectByExample(null);
    }

    //    保存新用户
    public int SaveEmp(Employee employee, String roleid) {
        int i = empm.insertSelective(employee);
        EmpRole er = new EmpRole();
        er.setRoleFk(Integer.parseInt(roleid));
        er.setEmpFk(employee.getEid());
        er.setErdis("歌姬");
        erm.insertSelective(er);

        return i;
    }

    //    根据用户名查角色
    public EmpRole getEmp_RoleEmpFkTo(int eid) {
        EmpRoleExample ere = new EmpRoleExample();
        EmpRoleExample.Criteria cc = ere.createCriteria();
        cc.andEmpFkEqualTo(eid);
        List<EmpRole> empRoles = erm.selectByExample(ere);
        if (empRoles.size() > 0 && null != empRoles) {
            return empRoles.get(0);
        } else {

            return null;
        }
    }


    //    保存修改
    public int UpdateEmp(Employee employee, String roleid) {
        int i = empm.updateByPrimaryKeySelective(employee);
        EmpRole empRole = getEmp_RoleEmpFkTo(employee.getEid());
        int i1 = 0;
        if (null != empRole) {
//            修改
            empRole.setRoleFk(Integer.parseInt(roleid));
            i1 = erm.updateByPrimaryKeySelective(empRole);
        } else {
//            添加
            EmpRole er = new EmpRole();
            er.setRoleFk(Integer.parseInt(roleid));
            er.setEmpFk(employee.getEid());
            er.setErdis("歌姬");
            i1 = erm.insertSelective(er);
        }

        if (i > 0 && i1 > 0) {
            return i;
        } else {
            return 0;
        }
    }

    //    查找节点
    public List<Sources> getSources() {
//        查找1级节点
        SourcesExample se = new SourcesExample();
        SourcesExample.Criteria cc = se.createCriteria();
        cc.andPidEqualTo(0);
        List<Sources> flist = sm.selectByExample(se);
        //        查找二级节点
        getChild(flist.get(0));
        return flist;
    }

    //    保存资源
    public int saveSources(Sources sources) {

        return sm.insertSelective(sources);
    }

    //    删除资源
    public int deleteSources(int sid) {

        return sm.deleteByPrimaryKey(sid);
    }

    //    更新资源
    public int updateSources(Sources sources) {

        return sm.updateByPrimaryKeySelective(sources);
    }

    //    根据ID查找资源
    public Sources getSourcesById(int id) {

        return sm.selectByPrimaryKey(id);
    }


    //    保存角色
    public int saveRole(String sids, Role role) {
        int i1 = rm.insertSelective(role);
        String[] split = sids.split(",");
        ArrayList<RoleSources> rsList = new ArrayList<RoleSources>();
        for (String sid : split) {
            RoleSources rs = new RoleSources();
            rs.setSid(Integer.parseInt(sid));
            rs.setRoleid(role.getRoleid());
            rs.setRsdis(role.getRolename() + "穿红戴绿");
            rsList.add(rs);
        }
        int i = rsm.insertAll(rsList);
        if (i > 0 && i1 > 0) {
            return i;
        } else {
            return 0;
        }
    }

    //           删除角色
    public int deleRole(int roleid) {
        RoleSourcesExample rse = new RoleSourcesExample();
        RoleSourcesExample.Criteria cc = rse.createCriteria();
        cc.andRoleidEqualTo(roleid);
        int i = rsm.deleteByExample(rse);
        int i1 = rm.deleteByPrimaryKey(roleid);
        if (i > 0 && i1 > 0) {
            return i;
        } else {
            return 0;
        }
    }

    //    通过ID查找角色
    public Role getRoleById(int roleid) {

        return rm.selectByPrimaryKey(roleid);
    }

    //    获取莫个角色所有的权限
    public String getRoleSources_SidByRoleid(int roleid) {

        String roleSources = rsm.getRoleSources_SidByRoleid(roleid);

        return roleSources;
    }

    //    修改角色
    public int updRole(Role role, String sid) {
//        修改角色
        int i = rm.updateByPrimaryKeySelective(role);
//        清楚原有权限
        RoleSourcesExample rse = new RoleSourcesExample();
        RoleSourcesExample.Criteria cc = rse.createCriteria();
        cc.andRoleidEqualTo(role.getRoleid());
        rsm.deleteByExample(rse);
//         重新录入
        int i1 = saveRoleSourcesAll(role, sid);

        if (i > 0 && i1 > 0) {
            return i;
        } else {
            return 0;
        }
    }

//    显示菜单
    public List<Sources> getSource(Map map) {
//        获取二级节点（一级节点）
        List<Sources> sourcesList = sm.getSource(map);
        for (Sources s : sourcesList) {
            map.put("pid",s.getId());
            List<Sources> source = sm.getSource(map);
            s.setChildren(source);

        }
        return sourcesList;
    }


    public void getChild(Sources root) {
//        查找二级节点
        SourcesExample se = new SourcesExample();
        SourcesExample.Criteria cc = se.createCriteria();
        cc.andPidEqualTo(root.getId());
        List<Sources> slist = sm.selectByExample(se);
//        查找二级节点
        for (Sources s : slist) {
//            递归
            getChild(s);
        }
        root.setChildren(slist);
    }


    //    批量保存权限
    public int saveRoleSourcesAll(Role role, String sids) {
        String[] split = sids.split(",");
        ArrayList<RoleSources> rsList = new ArrayList<RoleSources>();
        for (String sid : split) {
            RoleSources rs = new RoleSources();
            rs.setSid(Integer.parseInt(sid));
            rs.setRoleid(role.getRoleid());
            rs.setRsdis(role.getRolename() + ":水性杨花");
            rsList.add(rs);
        }
        int i = rsm.insertAll(rsList);
        return i;
    }

}
