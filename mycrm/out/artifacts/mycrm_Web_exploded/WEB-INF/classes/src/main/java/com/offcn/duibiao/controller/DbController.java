package com.offcn.duibiao.controller;

import com.offcn.duibiao.bean.Datacollect;
import com.offcn.duibiao.bean.DatacollectSearch;
import com.offcn.duibiao.bean.Indexvalue;
import com.offcn.duibiao.service.DbService;
import com.offcn.emp.bean.Employee;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("duibiao")
public class DbController {

    @Autowired
    DbService ds;


    //    查找所有标杆
    @RequestMapping("getCollectList")
    public String getCollectList(Model model,
                                 Map map) {
        List<Datacollect> cLits = ds.getCollectList(map);
        model.addAttribute("cList", cLits);

        return "duibiao-base";
    }


    //    查看指标
    @RequestMapping("getIndexvalueList")
    public String getIndexvalueList(Model model,
                                    Map map) {
        List<Indexvalue> iList = ds.getIndexvalueList(map);
        model.addAttribute("iList", iList);
        return "indexvalue-base";
    }


    //    添加指标
    @RequestMapping("addIndexvalue")
    @ResponseBody
    public List<Datacollect> addIndexvalue() {

        List<Datacollect> list = ds.getCollectName();

        return list;
    }


    //    根据dacname查找对标企业
    @RequestMapping("getDatacollectByDacname")
    @ResponseBody
    public Datacollect getDatacollectById(String dacname) {

        Datacollect datacollect = ds.getDatacollectByDacname(dacname);
        return datacollect;
    }


//    添加指标
    @RequestMapping("saveIndexValueInfo")
    public String saveIndexValueInfo(Indexvalue indexvalue,
                                     MultipartFile files,
                                     HttpSession session) throws IOException {
        int i = 0;
//        上传文件
        String path = "E:\\attfile\\" + files.getOriginalFilename();
        File file = new File(path);
        files.transferTo(file);
        indexvalue.setInFile(files.getOriginalFilename());
//        立标人
        Employee usr = (Employee) session.getAttribute("usr");
        indexvalue.setEmpFk5(usr.getEid());

//        保存到数据库
        i = ds.saveIndexValueInfo(indexvalue);
        if (i > 0) {
            return "redirect:/duibiao/getIndexvalueList";
        } else {
            return "error";
        }

    }


//    添加采集信息
    @RequestMapping("saveCollectMsg")
    public String saveCollectMsg(MultipartFile files) {
//        创建一个存放数据的集合
        ArrayList<Datacollect> dList = new ArrayList();
        try {
            InputStream is = files.getInputStream();
//            创建新excel文档
            XSSFWorkbook workbook = new XSSFWorkbook(is);
//            循环工作表
            for (int numSheet = 0; numSheet < workbook.getNumberOfSheets() ; numSheet++) {
//                获取指定索引的页
                XSSFSheet sheetAt = workbook.getSheetAt(numSheet);
                if (null == sheetAt){
                    continue;
                }
//                循环当前页中具体的行
                for (int rowNuw = 1; rowNuw <= sheetAt.getLastRowNum(); rowNuw++) {
                    XSSFRow sheetRow = sheetAt.getRow(rowNuw);
                    if (null != sheetRow){
//                    获取当前页指定索引具体的列
                        XSSFCell daid = sheetRow.getCell(0);
                        XSSFCell dacname = sheetRow.getCell(1);
                        XSSFCell daturnover = sheetRow.getCell(2);
                        XSSFCell datime = sheetRow.getCell(3);
                        XSSFCell dabusiness = sheetRow.getCell(4);
                        XSSFCell dasuperiority = sheetRow.getCell(5);
                        XSSFCell dainforiority = sheetRow.getCell(6);
                        XSSFCell dasort = sheetRow.getCell(7);
                        XSSFCell empcount = sheetRow.getCell(8);
                        XSSFCell buildtime = sheetRow.getCell(9);
                        XSSFCell remark = sheetRow.getCell(10);
                        XSSFCell daother = sheetRow.getCell(11);

//                        创建一个对象接收
                        Datacollect data = new Datacollect();
                        data.setDaid((int) daid.getNumericCellValue());
                        data.setDacname(dacname.getStringCellValue());
                        data.setDaturnover(daturnover.getNumericCellValue());
                        data.setDatime(datime.getDateCellValue());
                        data.setDabusiness(dabusiness.getStringCellValue());
                        data.setDasuperiority(dasuperiority.getStringCellValue());
                        data.setDainforiority(dainforiority.getStringCellValue());
                        data.setDasort((int) dasort.getNumericCellValue());
                        data.setEmpcount((int) empcount.getNumericCellValue());
                        data.setBuildtime(buildtime.getDateCellValue());
                        data.setRemark(remark.getStringCellValue());
                        data.setDaother(daother.getStringCellValue());
//                      保存到集合汇总
                        dList.add(data);

                        System.out.println();


                    }
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

//        将集合中的所有数据保存到数据库
        int i = ds.saveCollectMsg(dList);

        if (i > 0){
            return "redirect:/duibiao/getCollectList";
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
    public ResponseEntity<byte[]> exportExcel(Map map) throws IOException {
//        获取所有数据
        List<Datacollect> dcsList = ds.getCollectList(map);
//        创建新excel文档，
        HSSFWorkbook workbook = new HSSFWorkbook();
//        创建新工作表
        HSSFSheet sheet = workbook.createSheet("第一页");
//        创建第一行
        HSSFRow row = sheet.createRow(0);
//        创建单元格
        HSSFCell[] cells = new HSSFCell[12];
        for (int i = 0; i < cells.length; i++) {
            sheet.setColumnWidth(i,25*256);
            cells[i] = row.createCell(i);
        }
//        为单元格赋值
        cells[0].setCellValue("daid");
        cells[1].setCellValue("dacname");
        cells[2].setCellValue("daturnover");
        cells[3].setCellValue("datime");
        cells[4].setCellValue("dabusiness");
        cells[5].setCellValue("dasuperiority");
        cells[6].setCellValue("dainforiority");
        cells[7].setCellValue("dasort");
        cells[8].setCellValue("empcount");
        cells[9].setCellValue("buildtime");
        cells[10].setCellValue("remark");
        cells[11].setCellValue("daother");

//        写入数据
        for (int i = 0; i < dcsList.size(); i++) {
            Datacollect datacollect = dcsList.get(i);
            HSSFRow row2 = sheet.createRow(i+1);
//        创建单元格
            HSSFCell[] cells2 = new HSSFCell[12];
            for (int j = 0; j < cells.length; j++) {
                cells2[j] = row2.createCell(j);
            }
            cells2[0].setCellValue(datacollect.getDaid());
            cells2[1].setCellValue(datacollect.getDacname());
            cells2[2].setCellValue(datacollect.getDaturnover());
            cells2[3].setCellValue(datacollect.getDatime());
            cells2[4].setCellValue(datacollect.getDabusiness());
            cells2[5].setCellValue(datacollect.getDasuperiority());
            cells2[6].setCellValue(datacollect.getDainforiority());
            cells2[7].setCellValue(datacollect.getDasort());
            cells2[8].setCellValue(datacollect.getEmpcount());
            cells2[9].setCellValue(datacollect.getBuildtime());
            cells2[10].setCellValue(datacollect.getRemark());
            cells2[11].setCellValue(datacollect.getDaother());
//            创建样式
            HSSFCellStyle cellStyle = workbook.createCellStyle();
//            日期
            HSSFDataFormat format = workbook.createDataFormat();
            cellStyle.setDataFormat(format.getFormat("yyyy-MM-dd"));
            cells2[3].setCellStyle(cellStyle);
            cells2[9].setCellStyle(cellStyle);
//            单元格

        }
//          导出
        File file = new File("E:\\exportExcel\\Datacollect.xls");
        FileOutputStream fos = new FileOutputStream(file);
        workbook.write(fos);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentDispositionFormData("attachment","Datacollect.xls");
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

        ResponseEntity<byte[]> entity = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);

        return entity;
    }


//    删除
    @RequestMapping("deleDuiBiao")
    public String deleDuiBiao(@RequestParam("daid")int[] id) {

    		return null;
    }

//    下载指标附件
    @RequestMapping("downloadIndexValue")
    public ResponseEntity<byte[]> downloadIndexValue(String inFile) throws IOException {

        File file = new File("E:\\attfile\\" + inFile);
        HttpHeaders hh = new HttpHeaders();
        hh.setContentDispositionFormData("attachment", inFile);
        hh.setContentType(MediaType.APPLICATION_OCTET_STREAM);

        ResponseEntity<byte[]> responseEntity = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), hh, HttpStatus.OK);
        return responseEntity;
    }



//    目标营业额分析
    @RequestMapping("getDatacollectSearch")
    @ResponseBody
    public List<Datacollect> getDatacollectSearch(DatacollectSearch datas) {
        List<Datacollect> datacollect = ds.getDatacollectSearch(datas);

    		return datacollect;
    }


}
