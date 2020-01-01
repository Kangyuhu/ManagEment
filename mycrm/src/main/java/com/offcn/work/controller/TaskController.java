package com.offcn.work.controller;

import com.github.pagehelper.PageInfo;
import com.offcn.emp.bean.Employee;
import com.offcn.emp.service.EmpService;
import com.offcn.fun.bean.Function;
import com.offcn.fun.service.FunService;
import com.offcn.work.bean.Task;
import com.offcn.work.bean.TaskView;
import com.offcn.work.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("task")
public class TaskController {

    @Autowired
    TaskService ts;

    @Autowired
    FunService fs;

    @Autowired
    EmpService es;



    //    查找所有
    @RequestMapping()
    public String getTList(@RequestParam(defaultValue = "1") int pageNO,
                           Model model,
                           @RequestParam(defaultValue = "0") int status,
                           @RequestParam(defaultValue = "0") int cid,
                           String keyword,
                           @RequestParam(defaultValue = "0") int orderby) {

        Map map = new HashMap();
        map.put("pageNO", pageNO);
        map.put("status", status);
        map.put("cid", cid);
        map.put("orderby", orderby);
        map.put("keyword", keyword);

        PageInfo<TaskView> tList = ts.getTList(map);
        model.addAttribute("tList", tList.getList());
        model.addAttribute("pageNO", pageNO);
        model.addAttribute("size", 3);
        model.addAttribute("count", tList.getTotal());
        model.addAttribute("status", status);
        model.addAttribute("cid", cid);
        model.addAttribute("orderby", orderby);
        model.addAttribute("keyword", keyword);

        return "task";
    }


    //    回显功能下拉框
    @RequestMapping("getFun")
    @ResponseBody
    public List<Function> getFun(@RequestParam(defaultValue = "0") int mid) {
        List<Function> f = fs.getFunByMid(mid);

        System.out.println("哈哈哈啊哈哈啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊");

        return f;
    }

    //    任务执行者
    @RequestMapping("getEmpList")
    @ResponseBody
    public List<Employee> getEmpList() {
        List<Employee> list = es.getWorkEmpAll();
        return list;
    }

    //    保存
    @RequestMapping("saveInfo")
    public String saveInfo(Task taskView,
                           HttpSession session) {
        Employee usr = (Employee) session.getAttribute("usr");
        int i = 0;
        Integer id = 0;
        id = taskView.getId();
        if (null != id && 0 != id) {
//              修改
            i = ts.update(taskView);
        } else {
//              保存
            Integer eid = usr.getEid();
            taskView.setEmpFk(eid);
            taskView.setStatus(1);
            i = ts.saveInfo(taskView);
        }

        if (i > 0) {
            return "redirect:/task";
        } else {
            return "error";
        }
    }


//    跳转修改页面
    @RequestMapping("updateEcho")
    public String updateEcho(@RequestParam(defaultValue = "0") int id,Model model) {
        if (id > 0){
            Task t = ts.getById(id);
            Function fun = fs.getById(t.getFunFk());
            model.addAttribute("task",t);
            model.addAttribute("fun",fun);
            return "task-edit";
        }
    		return "error";
    }



}
