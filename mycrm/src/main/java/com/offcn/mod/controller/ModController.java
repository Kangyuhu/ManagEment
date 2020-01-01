package com.offcn.mod.controller;

import com.offcn.ana.service.AnaService;
import com.offcn.ana.bean.Analysis;
import com.offcn.mod.bean.Module;
import com.offcn.mod.modservice.ModService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("mod")
public class ModController {

    @Autowired
    ModService ms;

    @Autowired
    AnaService as;

//    查找所有
    @RequestMapping
    public String getMList(Model model) {
        List<Module> mList = ms.getMList();
        model.addAttribute("mlist",mList);

        return "project-model";
    }

//    回显需求
    @RequestMapping("getAna")
    @ResponseBody
    public Analysis getAna(@RequestParam(defaultValue = "0") int pid) {
        if (pid != 0){
            Analysis ana = as.getById(pid);
            System.out.println();

            return ana;
        }else {
            return null;
        }
    }

//    保存
    @RequestMapping("saveInfo")
    public String saveInfo(Module mod) {
        int i = 0;
        Integer id = mod.getId();
        if (null != id && id != 0){
//            修改
            i = ms.update(mod);
        }else {
//            保存
            i = ms.saveInfo(mod);
        }

        if (i > 0){
            return "redirect:/mod";
        }else {
            return "error";
        }
    }

//    跳转到修改页面
    @RequestMapping("updateEcho")
    public String updateEcho(@RequestParam(defaultValue = "0") int id,Model model) {
        if (id > 0 ) {
            Module module = ms.getByIdO(id);
            model.addAttribute("module",module);
            return "project-model-edit";
        }else {
            return "error";
        }
    }


}
