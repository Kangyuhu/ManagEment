package com.offcn.work.controller;

import com.offcn.emp.bean.Employee;
import com.offcn.emp.service.EmpService;
import com.offcn.work.bean.Msg;
import com.offcn.work.dao.MsgMapper;
import com.offcn.work.service.MsgService;
import com.offcn.work.service.MyJob;
import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("msg")
public class MsgController {

    @Autowired
    MsgService ms;

    @Autowired
    EmpService empService;

    @Autowired
    MsgMapper mm;

    //    去发消息
    @RequestMapping("toSeedMsg")
    public String toSeedMsg(Model model,
                            HttpSession session) {
        Employee usr = (Employee) session.getAttribute("usr");
        List<Employee> emplist = empService.getEmpNameNotInMyId(usr.getEid());
        model.addAttribute("emplist", emplist);
        return "message-seed";
    }


    //    发消息
    @RequestMapping("seedMsg")
    public String seedMsg(Msg msg,
                          HttpSession session) {

        Employee usr = (Employee) session.getAttribute("usr");

//        设定发件人（当前用户）
        msg.setSendp(usr.getEid());
//        设定查看状态
        msg.setMark(0);

//        定义调度器
        StdSchedulerFactory sf = new StdSchedulerFactory();
        Scheduler sch = null;
        try {
            sch = sf.getScheduler();
        } catch (SchedulerException e) {
            e.printStackTrace();
        }

//        定义任务Job
        JobDetail detail = JobBuilder.newJob(MyJob.class)
//                参数1是任务名，参数2是组名（为了确保和触发器在同一个组）
                .withIdentity("job1", "grp1")
//                创建
                .build();
        JobDataMap map = detail.getJobDataMap();
        map.put("msg", msg);
        map.put("mm", mm);
//        定义触发器
        SimpleTrigger tri = TriggerBuilder.newTrigger()
//                参数1是触发器名，参数2是组名（确保和任务Job在同样一个组）
                .withIdentity("tr1", "grp1")
                .withSchedule(SimpleScheduleBuilder.simpleSchedule())
//                设定触发时间，从页面中获取
                .startAt(msg.getMsgtime())
//                创建
                .build();
        try {
//            调度器调用任务和触发器
            sch.scheduleJob(detail, tri);
//            开启调度器
            sch.start();
        } catch (SchedulerException e) {
            e.printStackTrace();
        }

//          返回
        return "redirect:/msg/getMyMsgList";
    }


    //    查找我的消息
    @RequestMapping("getMyMsgList")
    public String getMyMsgList(Model model,
                               HttpSession session,
                               @RequestParam(defaultValue = "0") int flag) {
        Employee usr = (Employee) session.getAttribute("usr");
        Integer eid = usr.getEid();
        List<Msg> mlist = ms.getMyMsgList(eid);
        model.addAttribute("mlist", mlist);
        model.addAttribute("flag", flag);

        return "message-give";
    }


    //   getByMsgId
    @RequestMapping("getByMsgId")
    public String getByMsgId(@RequestParam(defaultValue = "0") int msgid,
                             @RequestParam(defaultValue = "0") int flag,
                             Model model) {
        if (msgid > 0) {
            if (flag == 1) {
//                查看
                Msg msg = ms.getByMsgId(msgid);
                if (null != msg) {
                    msg.setMark(1);
                    int j = ms.updateMsg_Mark(msg);
                    if (j > 0) {
                        return "redirect:/msg/getMyMsgList";
                    } else {
                        return "error";
                    }
                } else {
                    return "error";
                }
            } else {
//                删除
                int i = ms.delById(msgid);
                if (i > 0) {
                    return "redirect:/msg/getMyMsgList";
                } else {
                    return "error";
                }
            }

        } else {
            return "error";
        }
    }

    //    未读消息
    @RequestMapping("getUnreadMsg")
    @ResponseBody
    public List<Msg> getUnreadMsg(HttpSession session) {
        Employee usr = (Employee) session.getAttribute("usr");
        Integer eid = usr.getEid();
        List<Msg> msg = ms.getUnreadMsg(eid);

        return msg;
    }



}





