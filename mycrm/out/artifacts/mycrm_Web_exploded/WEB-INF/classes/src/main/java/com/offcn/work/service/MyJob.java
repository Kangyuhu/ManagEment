package com.offcn.work.service;

import com.offcn.work.bean.Msg;
import com.offcn.work.dao.MsgMapper;
import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class MyJob implements Job {


    public void execute(JobExecutionContext context) throws JobExecutionException {
//        获取Job自带的map集合
        JobDataMap map = context.getJobDetail().getJobDataMap();
//        获取map中的值
        Msg msg = (Msg) map.get("msg");
        MsgMapper mm = (MsgMapper) map.get("mm");

//        保存
        int i = mm.insertSelective(msg);

        System.out.println("===========================================");
        System.out.println();
        System.out.println();
        System.out.println(i);
        System.out.println();
        System.out.println();
        System.out.println("===========================================");

    }
}
