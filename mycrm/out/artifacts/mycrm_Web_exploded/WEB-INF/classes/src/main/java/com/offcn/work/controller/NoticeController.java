package com.offcn.work.controller;

import com.github.pagehelper.PageInfo;
import com.offcn.work.bean.Notice;
import com.offcn.work.bean.TaskView;
import com.offcn.work.service.NoticeService;
import com.offcn.work.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("noc")
public class NoticeController {

    @Autowired
    NoticeService ns;

    @Autowired
    TaskService ts;


//    查找所有
    @RequestMapping()
    public String getNList(Model model) {
        List<Notice> nlist = ns.getNList();
        model.addAttribute("nlist",nlist);

    		return "notice";
    }


//    查找前4条数据
    @RequestMapping("getNdate4")
    @ResponseBody
    public List<Notice> getNdate4() {
        List<Notice> ndate4 = ns.getNdate4();
        return ndate4;
    }


//    未完成的任务
    @RequestMapping("getNoTask")
    @ResponseBody
    public List<TaskView> getNoTask(@RequestParam(defaultValue = "0") int status) {
        if (status > 0 ){
            Map map = new HashMap();
            map.put("status",status);
            map.put("pageNO",1);
            PageInfo<TaskView> tList = ts.getTList(map);
            return tList.getList();
        }else {

            return null;
        }

    }

}
