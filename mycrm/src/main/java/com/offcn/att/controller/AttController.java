package com.offcn.att.controller;

import com.offcn.att.bean.Attachment;
import com.offcn.att.service.AttService;
import com.offcn.pro.bean.Project;
import com.offcn.pro.proService.ProService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("att")
public class AttController {

    @Autowired
    AttService as;

    @Autowired
    ProService ps;


    //    查找所有
    @RequestMapping
    public String getAlist(Model model) {
        List<Attachment> aList = as.getAList();
        model.addAttribute("aList", aList);

        return "project-file";
    }

    //    保存
    @RequestMapping("saveInfo")
    public String saveInfo(Attachment att, MultipartFile files, String newpath) throws IOException {
        int i = 0;
        Integer attId = att.getId();
        String newname = UUID.randomUUID().toString().substring(23, 32) + files.getOriginalFilename();
        File file = new File("E:/attfile", newname);

        if (0 < files.getSize()) {
            if (null != newpath && "".equals(newpath)) {
                File file1 = new File("E:/attfile", newpath);
                if (file1.exists()) {
                    file1.delete();
                }
            }
            files.transferTo(file);
            att.setPath(newname);
        }

        if (null != attId && attId != 0) {
//            修改
            i = as.update(att);
        } else {
//             增加
            i = as.saveInfo(att);
        }

        if (i > 0) {
            return "redirect:/att";
        } else {
            return "error";
        }

    }


    //      跳转编辑页面
    @RequestMapping("updateEcho")
    public String updateEcho(@RequestParam(defaultValue = "0") int id, Model model) {
        if (id > 0) {
            Attachment att = as.getAtt(id);
            model.addAttribute("att", att);
            return "project-file-edit";
        } else {
            return "error";
        }
    }

    //    下载
    @RequestMapping("download")
    public ResponseEntity<byte[]> download(String path) throws IOException {

        File file = new File("E:\\attfile\\" + path);
        HttpHeaders hh = new HttpHeaders();
        hh.setContentDispositionFormData("attachment", path.substring(8));
        hh.setContentType(MediaType.APPLICATION_OCTET_STREAM);

        ResponseEntity<byte[]> responseEntity = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), hh, HttpStatus.OK);
        return responseEntity;
    }

    //    删除
    @RequestMapping("delById")
    public String delById(@RequestParam(defaultValue = "0") int id,String newpath) {
        int i = 0;
        if (id != 0) {
            i = as.delById(id);
            File file1 = new File("E:/attfile", newpath);
            if (file1.exists()) {
                file1.delete();
            }
        }else {
            return "error";
        }

        if (i > 0) {
            return "redirect:/att";
        }else {
            return "error";
        }
    }

//    查看详情
    @RequestMapping("look")
    public String look(@RequestParam(defaultValue = "0") int id,Model model) {
        if (id > 0) {
            Attachment att = as.getAtt(id);

            Project pro = ps.getPro(att.getProFk());
            att.setPro(pro);
            model.addAttribute("att", att);
            return "project-file-look";
        } else {
            return "error";
        }
    }

}
