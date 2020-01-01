package com.offcn.ana.controller;

import com.offcn.ana.service.AnaService;
import com.offcn.ana.bean.Analysis;
import com.offcn.pro.bean.Project;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("ana")
public class AnaController {

    @Autowired
    AnaService as;


//    查找没有需求的项目
    @RequestMapping("getNoneNeed")
    public String getNoneNeed(Model model) {
        List<Analysis> alist = as.getNoneNeed();
        model.addAttribute("alist",alist);

        return "project-need-add";
    }

//    查找所有需求
    @RequestMapping()
    public String getList(Model model) {

        List<Analysis> list = as.getList();
        model.addAttribute("alist",list);
    		return "project-need";
    }


//    回显项目名称
    @RequestMapping("getPro")
    @ResponseBody
    public List<Project> getPro(@RequestParam(defaultValue = "0") int pid) {
           List<Project> list = as.getPro(pid);
    		return list;
    }

//    保存
    @RequestMapping("saveInfo")
    public String saveInfo(Analysis analysis,String newproname) {
        int i  = 0;
        Integer id = analysis.getId();
        if (null != id && id != 0){
            // 修改
            String[] split = newproname.split(",");
            analysis.setUpdatetime(new Date());
            analysis.setProname(split[1]);
            i = as.update(analysis);
        }else {
            // 保存
            analysis.setAddtime(new Date());
            i = as.saveInfo(analysis);
        }
        if (i > 0){
            return "redirect:/ana";
        }else {
            return "error";
        }
    }

//    跳转修改页面
    @RequestMapping("updateEcho")
    public String updateEcho(@RequestParam(defaultValue = "0") int id,Model model) {
            if (id != 0){
                Analysis ana = as.getById(id);
                model.addAttribute("ana",ana);
                return "project-need-edit";
            }else {
                return "error";
            }

    }


}
