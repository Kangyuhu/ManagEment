package com.offcn.baoxiao.controller;

import com.github.pagehelper.PageInfo;
import com.offcn.baoxiao.bean.Baoxiao;
import com.offcn.baoxiao.service.BxService;
import com.offcn.emp.bean.Employee;
import com.offcn.emp.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("bx")
public class BxController {

    @Autowired
    BxService bs;

    @Autowired
    EmpService es;

//    查所有
    @RequestMapping("getBaoXiao")
    public String getBaoXiao(Model model,
                             @RequestParam(defaultValue = "0") int flag,
                             HttpSession session,
                             @RequestParam(defaultValue = "0")int examine) {
        Map map = new HashMap();
        map.put("flag",flag);


        if (flag == 1){
//            自己的
            Employee usr = (Employee) session.getAttribute("usr");
            map.put("eid",usr.getEid());
            PageInfo<Baoxiao> pageInfo = bs.getBaoXiao(map);
            model.addAttribute("bList",pageInfo.getList());
            return "mybaoxiao-base";
        }else {
//            别人的
            if (examine == 1){
//                审批过得
                map.put("examine",1);
                model.addAttribute("examine",1);
            }else {
//                审批通过的
                map.put("bxstatus1",1);
                model.addAttribute("examine",0);
            }
            PageInfo<Baoxiao> pageInfo = bs.getBaoXiao(map);
            model.addAttribute("bList",pageInfo.getList());

            return "baoxiao-task";
        }
    }


//    ID查找
    @RequestMapping("getByBaoXiao")
    public String getByBaoXiao(String bxid,
                               Model model,
                               @RequestParam(defaultValue = "0")int flag) {

        if (!"".equals(bxid)){
            Baoxiao baoXiao = bs.getByBaoXiao(bxid);
            Employee emp = es.getEmp(baoXiao.getEmpFk());
            baoXiao.setEmployee(emp);

            model.addAttribute("baoXiao",baoXiao);
        }else {
            return "mybaoxiao-add";
        }

        if (flag == 1){
//            自己的
            return "mybaoxiao-edit";
        }else {
//                别人的
            return "baoxiao-task-edit";
        }
    }


//    保存and修改
    @RequestMapping("saveBaoXiao")
    public String updBaoXiao(Baoxiao baoxiao,
                             @RequestParam(defaultValue = "0") int flag,
                             HttpSession session) {
        int i = 0;
        String bxid = baoxiao.getBxid();
        if (null != bxid && !"空".equals(bxid)){
//            修改
            i = bs.updaBaoXiao(baoxiao);
            System.out.println();

        }else {
            baoxiao.setBxid(UUID.randomUUID().toString());
            baoxiao.setBxstatus(0);
            Employee usr = (Employee) session.getAttribute("usr");
            baoxiao.setEmpFk(usr.getEid());
            Employee emp = new Employee();
            String ename = usr.getEname();
            emp.setEname(ename);
            baoxiao.setEmployee(emp);

            i = bs.saveBaoXiao(baoxiao);
            System.out.println();

        }

        if (i > 0){
            if (flag == 1){
                return "redirect:/bx/getBaoXiao?flag=1";
            }else {
                return "redirect:/bx/getBaoXiao";
            }
        }else {
            return "error";
        }
    }

//    如添加
    @RequestMapping("addBaoXiao")
    public String addBaoXiao() {
    		return "mybaoxiao-add";
    }

}
