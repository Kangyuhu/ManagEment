package com.offcn.emp.service;

import com.github.pagehelper.PageInfo;
import com.offcn.emp.bean.Archives;
import com.offcn.emp.bean.Employee;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface EmpService {

    public List<Employee> getEmpAll();

    Employee getEmp(int id);

    Employee getEmp(Employee emp);

    List<Employee> getWorkEmpAll();

//    查找档案
    PageInfo getArcList(Map map);

    Employee getMyArcList(Integer eid);

    int update(Employee employee);

    int saveInfo(Employee employee);

    int saveArc(ArrayList<Archives> aList);

    List<Employee> getEmpNameNotInMyId(Integer eid);
}
