package com.offcn.emp.controller;

import com.github.pagehelper.PageInfo;
import com.offcn.emp.bean.Archives;
import com.offcn.emp.bean.Employee;
import com.offcn.emp.service.EmpService;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("emp")
public class EmpController {

    @Autowired
    EmpService es;

    //    查找档案
    @RequestMapping("getArcList")
    public String getArcList(@RequestParam(defaultValue = "1") int pageNO,
                             Model model) {
        Map map = new HashMap();
        map.put("pageNo", pageNO);

        PageInfo info = es.getArcList(map);
        model.addAttribute("arcList", info.getList());
        model.addAttribute("count", info.getTotal());
        model.addAttribute("size", 4);
        model.addAttribute("pageNO", pageNO);

        return "archives";
    }

    //    我的档案
    @RequestMapping("getMyArcList")
    public String getMyArcList(HttpSession session,
                               Model model,
                               @RequestParam(defaultValue = "0") int arc,
                               @RequestParam(defaultValue = "0") int eid) {
        if (arc == 1) {
//            别人的档案
            if (eid > 0) {
                Employee myArc = es.getMyArcList(eid);
                model.addAttribute("myArc", myArc);
                model.addAttribute("sign", arc);

            }
        } else {
//            自己的档案
            Employee usr = (Employee) session.getAttribute("usr");
            Employee myArc = es.getMyArcList(usr.getEid());
            model.addAttribute("myArc", myArc);
            model.addAttribute("sign", arc);
        }
        return "myarchives";

    }

    //    保存我的档案
    @RequestMapping("saveInfo")
    public String saveInfo(Employee employee,
                           HttpSession session) {

        Integer id = employee.getEid();

        Employee usr = (Employee) session.getAttribute("usr");
        Integer eid = usr.getEid();

        int i = es.update(employee);

        if (eid != id) {
            return "redirect:/emp/getArcList";
        } else {
            return "redirect:/emp/getMyArcList";
        }

    }


    //    添加档案
    @RequestMapping("addArchives")
    public String addArchives(MultipartFile files) {
//        创建一个集合存放所有的数据
        ArrayList<Archives> aList = new ArrayList();
        try {
            InputStream is = files.getInputStream();
//            创建新excel文档
            HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
//            循环工作表
            for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
//                获取指定索引的页
                HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
                if (null == hssfSheet) {
                    continue;
                }
//                循环当前页中的具体行
                for (int rowNuw = 1; rowNuw <= hssfSheet.getLastRowNum(); rowNuw++) {
//                    根据索引获取具体的行，第一行为表头所以索引从1开始
                    HSSFRow hssfRow = hssfSheet.getRow(rowNuw);
                    if (null != hssfRow) {
//                        获取当前行指定索引的列对象
                        HSSFCell dnum = hssfRow.getCell(0);
                        HSSFCell landline = hssfRow.getCell(1);
                        HSSFCell school = hssfRow.getCell(2);
                        HSSFCell zhuanye = hssfRow.getCell(3);
                        HSSFCell sosperson = hssfRow.getCell(4);
                        HSSFCell biyedate = hssfRow.getCell(5);
                        HSSFCell zzmm = hssfRow.getCell(6);
                        HSSFCell minzu = hssfRow.getCell(7);
                        HSSFCell xueli = hssfRow.getCell(8);
                        HSSFCell email = hssfRow.getCell(9);
                        HSSFCell emp_fk = hssfRow.getCell(10);
                        HSSFCell remark = hssfRow.getCell(11);
                        HSSFCell hirdate = hssfRow.getCell(12);

//                        创建一个对象接收
                        Archives a = new Archives();
                        a.setDnum(dnum.getStringCellValue());
                        a.setLandline(landline.getStringCellValue());
                        a.setSchool(school.getStringCellValue());
                        a.setZhuanye(zhuanye.getStringCellValue());
                        a.setSosperson(sosperson.getStringCellValue());
                        a.setBiyedate(biyedate.getDateCellValue());
                        a.setZzmm(zzmm.getStringCellValue());
                        a.setMinzu(minzu.getStringCellValue());
                        a.setXueli(xueli.getStringCellValue());
                        a.setEmail(email.getStringCellValue());
                        a.setEmpFk((int) emp_fk.getNumericCellValue());
                        a.setRemark(remark.getStringCellValue());
                        a.setHirdate(hirdate.getDateCellValue());
//                        保存到集合中
                        aList.add(a);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
//        将集合中的所有数据保存到数据库中
        int i = es.saveArc(aList);

        System.out.println();


        if (i > 0) {
            return "redirect:/emp/getArcList";
        } else {
            return "error";
        }

    }


}
