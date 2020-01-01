package com.offcn.cus.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.offcn.cus.bean.Customer;
import com.offcn.cus.bean.CustomerExample;
import com.offcn.cus.dao.CustomerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CusServiceImpl implements CusService {

    @Autowired
    CustomerMapper cm;

//    分页显示
    public PageInfo getCusList(Map map) {
        PageHelper.startPage((Integer) map.get("pageNo"),4);
        List<Customer> list = cm.getCusList(map);

        PageInfo<Customer> info = new PageInfo<Customer>(list);

        return info;
    }


//    增加客户
    public int savesaveadd(Customer cus) {

        int i = cm.insertSelective(cus);

        return i;
    }

//    根据ID查找
    public Customer getCus(int id) {

        Customer customer = cm.selectByPrimaryKey(id);

        return customer;
    }

//     保存修改内容
    public int updateSave(Customer cus) {

        int i = cm.updateByPrimaryKeySelective(cus);

        return i;
    }

//    删除
    public int delCus(List<Integer> did) {

        CustomerExample ce = new CustomerExample();

        CustomerExample.Criteria cc = ce.createCriteria();

        cc.andIdIn(did);

        return  cm.deleteByExample(ce);
    }

//    查找所有
    public List<Customer> getCustomerAll() {
        List<Customer> list = cm.selectByExample(null);
        return list;
    }


}
