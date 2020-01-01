package com.offcn.pro.controller;

import com.github.pagehelper.PageInfo;
import com.offcn.cus.bean.Customer;
import com.offcn.cus.service.CusService;
import com.offcn.emp.bean.Employee;
import com.offcn.emp.service.EmpService;
import com.offcn.pro.bean.Project;
import com.offcn.pro.proService.ProService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("pro")
public class ProController {

    @Autowired
    ProService ps;

    @Autowired
    CusService cs;

    @Autowired
    EmpService es;


    /**
     * 分页查找
     * @param pageNO
     * @param cid
     * @param keyword
     * @param orderby
     * @param model
     * @return
     */
    @RequestMapping
    public String getPage(@RequestParam(defaultValue = "1") int pageNO,
                          @RequestParam(defaultValue = "0") int cid,
                          String keyword,
                          @RequestParam(defaultValue = "0")int orderby,Model model) {

        Map<Object, Object> map = new HashMap<Object, Object>();
        map.put("pageNO",pageNO);
        map.put("cid",cid);
        map.put("keyword",keyword);
        map.put("orderby",orderby);

        PageInfo<Project> plist = ps.getPage(map);
        model.addAttribute("plist",plist.getList());
        model.addAttribute("count",plist.getTotal());
        model.addAttribute("pageNO",pageNO);
        model.addAttribute("size",4);
        model.addAttribute("cid",cid);
        model.addAttribute("keyword",keyword);
        model.addAttribute("orderby",orderby);
        return "project-base";
    }

    /**
     * 添加修改
     * @param model
     * @return
     */
    @RequestMapping("getList")
    public String getList(@RequestParam(defaultValue = "0") int id,
                          Model model) {
        List<Customer> clist = cs.getCustomerAll();
        List<Employee> elist = es.getEmpAll();
        model.addAttribute("clist",clist);
        model.addAttribute("elist",elist);
        if (id > 0){
//            修改
            Project pro = ps.getPro(id);
            model.addAttribute("pro",pro);
            return "project-base-edit";
        }else {
//            添加
            List<Project> plist = ps.getList();
            model.addAttribute("plist",plist);
            return "project-base-add";
        }
    }


    /**
     * 保存用户信息
     * @param pro
     * @param newcomname
     * @return
     */
    @RequestMapping("saveInfo")
    public String saveInfo(Project pro,String newcomname) {
        pro.setComname(Integer.parseInt(newcomname.split(",")[0]));
        int i = 0;
        Integer pid = pro.getPid();
        if (pid != null && pid != 0){
//            修改
            i = ps.update(pro);
        }else {
//              添加
            i = ps.saveInfo(pro);
        }

        if (i > 0){
            return "redirect:/pro";
        }
    		return "error";
    }

//跳转修改页面
    @RequestMapping("updateEcho")
    public String updateEcho(@RequestParam(defaultValue = "0") int id,
                             Model model) {
        if (id > 0){
            Project pro = ps.getPro(id);
            List<Customer> clist = cs.getCustomerAll();
            List<Employee> elist = es.getEmpAll();
            model.addAttribute("pro",pro);
            model.addAttribute("cus",clist);
            model.addAttribute("emp",elist);
            return "project-base-edit";
        }

    		return "error";
    }


//    删除
    @RequestMapping("delePro")
    public String delePro(@RequestParam("id") List<Integer> id) {
        int i = ps.delePro(id);
        if (i > 0){
            return "redirect:/pro";
        }else {
            return "error";
        }
    }
}
