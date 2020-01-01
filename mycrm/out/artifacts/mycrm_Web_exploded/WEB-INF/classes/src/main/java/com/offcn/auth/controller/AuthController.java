package com.offcn.auth.controller;

import com.github.pagehelper.PageInfo;
import com.offcn.auth.bean.EmpRole;
import com.offcn.auth.bean.Role;
import com.offcn.auth.bean.Sources;
import com.offcn.auth.service.AuthService;
import com.offcn.emp.bean.Dept;
import com.offcn.emp.bean.Employee;
import com.offcn.emp.bean.Level;
import com.offcn.emp.bean.Position;
import com.offcn.emp.service.EmpService;
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
@RequestMapping("auth")
public class AuthController {

    @Autowired
    AuthService as;

    @Autowired
    EmpService emps;


    //    添加用户下拉框
    @RequestMapping("getAll")
    @ResponseBody
    public Map getAll() {
        List<Position> positionAll = as.getPositionAll();
        List<Level> levelList = as.getLevelAll();
        List<Dept> deptList = as.getDeptAll();
        List<Role> roleList = as.getRoleAll();
        Map map = new HashMap();
        map.put("pot", positionAll);
        map.put("lev", levelList);
        map.put("dep", deptList);
        map.put("rol", roleList);
        return map;
    }

//查所有用户

    @RequestMapping("getEmpAll")
    public String getEmpAll(Model model,
                            @RequestParam(defaultValue = "1") int pageNO) {
        Map map = new HashMap();
        map.put("pageNO", pageNO);
//        map.put("cid",pageNO);
//        map.put("kd",pageNO);
//        map.put("od",pageNO);
        PageInfo<Employee> info = as.getEmpAll(map);
        List<Position> pl = as.getPositionAll();
        model.addAttribute("empAll", info.getList());
        model.addAttribute("pl", pl);
        model.addAttribute("count", info.getTotal());
        model.addAttribute("size", 5);
        model.addAttribute("pageNO", pageNO);
        return "user";
    }


    //    保存
    @RequestMapping("SaveEmp")
    public String SaveEmp(Employee employee,
                          String roleid) {
        Integer eid = employee.getEid();
        int i = 0;
        if (eid != null && eid != 0) {
            i = as.UpdateEmp(employee, roleid);
        } else {
            i = as.SaveEmp(employee, roleid);
        }

        if (i > 0) {
            return "redirect:/auth/getEmpAll";
        } else {
            return "error";
        }

    }

    //    去修改用户页面
    @RequestMapping("toUpdate")
    public String toUpdate(@RequestParam(defaultValue = "0") int eid,
                           Model model) {
        int i = 0;
        if (eid > 0) {
            Employee emp = emps.getEmp(eid);
            EmpRole eRole = as.getEmp_RoleEmpFkTo(eid);
            model.addAttribute("emp", emp);
            model.addAttribute("eRole", eRole);
            return "user-edit";
        } else {
            return "error";
        }
    }


    //   权限维护
    @RequestMapping("showAuth")
    @ResponseBody
    public List<Sources> showAuth() {
        List<Sources> list = as.getSources();
        return list;
    }

    //    保存资源
    @RequestMapping("addSources")
    public String addSources(Sources sources) {
        int i = 0;
        i = as.saveSources(sources);
        if (i > 0) {
            return "redirect:../pm.jsp";
        } else {
            return "error";
        }
    }

    //    去修改资源页面
    @RequestMapping("getSourcesById")
    public String getSourcesById(@RequestParam(defaultValue = "0") int id,
                                 Model model) {
        Sources sources = as.getSourcesById(id);
        model.addAttribute("onesource", sources);
        return "pm-edit";
    }

    //    跟新资源
    @RequestMapping("updateSources")
    public String updateSources(Sources sources) {
        int i = as.updateSources(sources);
        if (i > 0) {
            return "redirect:../pm.jsp";
        } else {
            return "error";
        }
    }

    //    删除资源
    @RequestMapping("deleteSources")
    @ResponseBody
    public int deleteSources(@RequestParam(defaultValue = "0") int id) {
        int i = as.deleteSources(id);
        return i;
    }


    //    查找所有角色
    @RequestMapping("getRoleList")
    public String getRoleList(Model model) {
        List<Role> roleList = as.getRoleAll();
        model.addAttribute("roleList", roleList);

        return "role";
    }


    //    添加角色
    @RequestMapping("saveRole")
    public String saveRole(String sids, Role role) {

        int i = 0;
        i = as.saveRole(sids, role);
        if (i > 0) {
            return "redirect:/auth/getRoleList";
        } else {
            return "error";
        }
    }


    //    删除角色
    @RequestMapping("deleRole")
    public String deleRole(@RequestParam(defaultValue = "0") int roleid) {
        int i = as.deleRole(roleid);
        if (i > 0) {
            return "redirect:/auth/getRoleList";
        } else {
            return "error";
        }
    }


    //    跳转修改角色页面
    @RequestMapping("updateRole")
    public String updateRole(@RequestParam(defaultValue = "0") int roleid,
                             Model model) {
        if (roleid > 0) {
            Role role = as.getRoleById(roleid);
            String rsis = as.getRoleSources_SidByRoleid(roleid);
            model.addAttribute("role", role);
            model.addAttribute("rsisList", rsis);

            return "role-edit";
        } else {
            return "error";
        }
    }


//    修改角色
    @RequestMapping("updRole")
    public String updRole(String sid, Role role) {

        int i = as.updRole(role,sid);

    		return "redirect:/auth/getRoleList";
    }


}
