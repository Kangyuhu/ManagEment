package com.offcn.emp.controller;

import com.offcn.auth.bean.Sources;
import com.offcn.auth.service.AuthService;
import com.offcn.emp.bean.Employee;
import com.offcn.emp.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("user")
public class UserController {


    @Autowired
    EmpService es;

    @Autowired
    AuthService as;

//    登录验证
    @RequestMapping("login")
    public String login(Employee emp, HttpSession session) {
        Employee emp1 = es.getEmp(emp);
        if (null != emp1){
            session.setAttribute("usr",emp1);
//            获取当前角色登录的功能
            Map map = new HashMap();
            map.put("pid",1);
            map.put("eid",emp1.getEid());
            List<Sources> MenusList = as.getSource(map);
            session.setAttribute("menus",MenusList);
            return "index";
        }else {
            return "error";
        }

    }

//    修改密码
    @RequestMapping("updatePassword")
    public void updatePassword(HttpServletResponse resp) throws IOException {
        //修改密码
//        删除session

        resp.getWriter().write("<script>window.parent.location.href='../login.jsp';</script>");
    }


//    查看信息
    @RequestMapping("getMyMessage")
    public String getMyMessage(HttpSession session) {
        Employee usr = (Employee) session.getAttribute("usr");

        return null;
    }



}
