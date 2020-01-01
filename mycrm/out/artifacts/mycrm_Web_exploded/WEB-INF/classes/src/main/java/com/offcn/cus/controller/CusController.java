package com.offcn.cus.controller;

import com.github.pagehelper.PageInfo;
import com.offcn.cus.bean.Customer;
import com.offcn.cus.service.CusService;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("cus")
public class CusController {

    @Autowired
    CusService cs;

    /**
     * 分页显示
     * @param pageNO
     * @param cid
     * @param keyword
     * @param orderby
     * @param model
     * @return
     */
    @RequestMapping()
    public String getCusList(@RequestParam(defaultValue = "1") int pageNO,
                  @RequestParam(defaultValue = "0") int cid,
                  String keyword,
                  @RequestParam(defaultValue = "0")int orderby,Model model) {
        Map map = new HashMap();
        map.put("pageNo",pageNO);
        map.put("cid",cid);
        map.put("kd",keyword);
        map.put("od",orderby);

        PageInfo info = cs.getCusList(map);
        model.addAttribute("count",info.getTotal());
        model.addAttribute("size",4);
        model.addAttribute("pageNO",pageNO);
        model.addAttribute("cList",info.getList());
        model.addAttribute("cid",cid);
        model.addAttribute("kd",keyword);
        model.addAttribute("od",orderby);

    		return "customer";
    }


    /**
     * 保存客户
     * @param cus
     * @return
     */
    @RequestMapping("saveInfo")
    public String saveadd(Customer cus) {
        int i = 0;

        Integer id = cus.getId();
        if (null != id && 0 != id){
            //修改
            i = cs.updateSave(cus);
        }else {
            //增加
            cus.setAddtime(new Date());
            i =  cs.savesaveadd(cus);

        }

        if (i > 0) {
           return "redirect:/cus";
       }else{
            return "reeor";
        }
    }


    /**
     * 跳转修改页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("updateEcho")
    public String updateEcho(@RequestParam(defaultValue = "0") int id, int dbf,Model model) {

        if (id != 0) {
            Customer customer  = cs.getCus(id);
            model.addAttribute("cus",customer);
            if (dbf == 1){
                //去修改
                return "customer-edit";
            }else {
                //去查看
                return "customer-look";
            }
        }
        return "error";
    }


    /**
     * 删除
     * @param did
     * @return
     */
    @RequestMapping("delCus")
    public String delCus(@RequestParam("id") List<Integer> did) {

        int i = cs.delCus(did);

        if (i > 0 ){
            return "redirect:/cus";
        }else {
            return "error";
        }
    }


    /**
     * 导出excel表格
     * @return
     * @throws IOException
     */
    @RequestMapping("exportExcel")
    public ResponseEntity<byte[]> exportExcel() throws IOException {
//        获取所有数据
        List<Customer> cusList = cs.getCustomerAll();
//        创建新excel文档，
        HSSFWorkbook workbook = new HSSFWorkbook();
//        创建新工作表
        HSSFSheet sheet = workbook.createSheet("第一页");
//        创建第一行
        HSSFRow row = sheet.createRow(0);
//        创建单元格
        HSSFCell[] cells = new HSSFCell[5];
        for (int i = 0; i < cells.length; i++) {
            sheet.setColumnWidth(i,25*256);
            cells[i] = row.createCell(i);
        }
//        为单元格赋值
        cells[0].setCellValue("ID");
        cells[1].setCellValue("联系人");
        cells[2].setCellValue("公司名");
        cells[3].setCellValue("时间");
        cells[4].setCellValue("电话");

//        写入数据
        for (int i = 0; i < cusList.size(); i++) {
            Customer c = cusList.get(i);
            HSSFRow row2 = sheet.createRow(i+1);
//        创建单元格
            HSSFCell[] cells2 = new HSSFCell[5];
            for (int j = 0; j < cells.length; j++) {
                cells2[j] = row2.createCell(j);
            }
            cells2[0].setCellValue(c.getId());
            cells2[1].setCellValue(c.getCompanyperson());
            cells2[2].setCellValue(c.getComname());
            cells2[3].setCellValue(c.getAddtime());
            cells2[4].setCellValue(c.getComphone());
//            创建样式
            HSSFCellStyle cellStyle = workbook.createCellStyle();
//            日期
            HSSFDataFormat format = workbook.createDataFormat();
            cellStyle.setDataFormat(format.getFormat("yyyy-MM-dd"));
            cells2[3].setCellStyle(cellStyle);
//            单元格

        }
//          导出
        File file = new File("E:\\exportExcel\\cus.xls");
        FileOutputStream fos = new FileOutputStream(file);
        workbook.write(fos);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentDispositionFormData("attachment","cus.xls");
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

        ResponseEntity<byte[]> entity = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);

        return entity;
    }
}
