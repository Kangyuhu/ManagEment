package com.offcn.email.service;

import com.offcn.email.bean.Email;
import com.offcn.email.bean.EmailExample;
import com.offcn.email.dao.EmailMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmailServiceImpl implements EmailService {

    @Autowired
    EmailMapper em;

//    保存邮件
    public int saveEmail(Email email) {

        return em.insertSelective(email);
    }

//    获取当前用户接收的邮件
    public List<Email> getMyReceiveEmail(Integer eid) {
        EmailExample ee = new EmailExample();
        EmailExample.Criteria cc = ee.createCriteria();
        cc.andEmpFk2EqualTo(eid);

        return em.selectByExample(ee);
    }

    //    获取当前用户发送的邮件
    public List<Email> getMySendEmail(Integer eid) {
        EmailExample ee = new EmailExample();
        EmailExample.Criteria cc = ee.createCriteria();
        cc.andEmpFkEqualTo(eid);

        return em.selectByExample(ee);
    }
}
