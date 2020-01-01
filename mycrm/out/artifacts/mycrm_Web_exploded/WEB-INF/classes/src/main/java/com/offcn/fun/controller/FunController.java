package com.offcn.fun.controller;

import com.offcn.fun.bean.FunList;
import com.offcn.fun.bean.Function;
import com.offcn.fun.service.FunService;
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
@RequestMapping("fun")
public class FunController {

    @Autowired
    FunService fs;

    @Autowired
    ModService ms;

//    查找所有
    @RequestMapping
    public String getFList(Model model) {
        List<FunList> fList = fs.getFList();
        model.addAttribute("fList",fList);
        return "project-function";
    }

//    回显模块下拉框
    @RequestMapping("getMod")
    @ResponseBody
    public List<Module> getMod(@RequestParam(defaultValue = "0") int mid) {
        if (mid != 0) {
            List<Module> module = ms.getById(mid);
            System.out.println(module);

            return module;
        }else {
            return null;
        }
    }

    @RequestMapping("saveInfo")
    public String saveInfo(Function fun) {
           int i = fs.saveInfo(fun);
    		return "redirect:/fun";
    }

}
