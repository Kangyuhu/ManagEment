package com.offcn.emp.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.emp.bean.Archives;
import com.offcn.emp.bean.Employee;
import com.offcn.emp.bean.EmployeeExample;
import com.offcn.emp.dao.ArchivesMapper;
import com.offcn.emp.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class EmpServiceImpl implements EmpService {
    @Autowired
    EmployeeMapper em;

    @Autowired
    ArchivesMapper am;

//    查找项目经理
    public List<Employee> getEmpAll() {
        EmployeeExample ee = new EmployeeExample();
        EmployeeExample.Criteria cc = ee.createCriteria();
        cc.andPFkEqualTo(4);
        List<Employee> list = em.selectByExample(ee);

        return list;
    }

//    ID查找
    public Employee getEmp(int id) {

        Employee employee = em.selectByPrimaryKey(id);

        return employee;
    }

//    查找用户
    public Employee getEmp(Employee emp) {
        EmployeeExample ex = new EmployeeExample();
        EmployeeExample.Criteria cc = ex.createCriteria();
        cc.andUsernameEqualTo(emp.getUsername());
        cc.andPasswordEqualTo(emp.getPassword());
        List<Employee> list = em.selectByExample(ex);
        if (null != list){
               return  list.get(0);
        }
        return null;
    }

//    查找执行者
    public List<Employee> getWorkEmpAll() {
        EmployeeExample ee = new EmployeeExample();
        EmployeeExample.Criteria cc = ee.createCriteria();
        cc.andPFkLessThan(4);
        List<Employee> list = em.selectByExample(ee);

        return list;
    }

//    查找档案
    public PageInfo getArcList(Map map) {
        PageHelper.startPage((Integer) map.get("pageNo"),4);
        List<Employee> arcList = em.getArcList(map);
        PageInfo<Employee> info = new PageInfo(arcList);

        return info;
    }

//    我的档案
    public Employee getMyArcList(Integer eid) {
        Map map = new HashMap();
        map.put("myArcListId",eid);
        List<Employee> arcList = em.getArcList(map);
        if (null != arcList){
            return arcList.get(0);
        }
        return null;

    }

//    修改
    public int update(Employee employee) {
        int i = em.updateByPrimaryKeySelective(employee);

        return i;
    }

//    添加
    public int saveInfo(Employee employee) {
        int i = em.insertSelective(employee);

        return i;
    }

    public int saveArc(ArrayList<Archives> aList) {
        int i = 0;
        int size = aList.size();
        for (i = 0; i < size; i++) {
            am.insertSelective(aList.get(i));
        }
        return i;
    }

//    收件人
    public List<Employee> getEmpNameNotInMyId(Integer eid) {
        return em.getEmpNameNotInMyId(eid);
    }
}
