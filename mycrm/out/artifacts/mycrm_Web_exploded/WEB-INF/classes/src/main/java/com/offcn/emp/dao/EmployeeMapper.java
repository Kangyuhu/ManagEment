package com.offcn.emp.dao;

import com.offcn.emp.bean.Employee;
import com.offcn.emp.bean.EmployeeExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int deleteByPrimaryKey(Integer eid);

    int insert(Employee record);

    int insertSelective(Employee record);

    List<Employee> selectByExample(EmployeeExample example);

    Employee selectByPrimaryKey(Integer eid);

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);

    //    查找档案
    List<Employee> getArcList(Map map);

    //   收件人
    List<Employee> getEmpNameNotInMyId(int eid);

//    人员管理
    List<Employee> getEmpAll(Map map);
}