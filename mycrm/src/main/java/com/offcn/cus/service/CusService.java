package com.offcn.cus.service;

import com.github.pagehelper.PageInfo;
import com.offcn.cus.bean.Customer;

import java.util.List;
import java.util.Map;

public interface CusService {

//    分页查找
    public PageInfo getCusList(Map map) ;

//   增加客户
    int savesaveadd(Customer cus);

//    根据ID查找
    Customer getCus(int id);

//    保存修改
    int updateSave(Customer cus);

//    删除
    int delCus(List<Integer> did);

//    查找所有
    List<Customer> getCustomerAll();
}
