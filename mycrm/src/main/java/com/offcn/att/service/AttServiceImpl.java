package com.offcn.att.service;

import com.offcn.att.bean.Attachment;
import com.offcn.att.dao.AttachmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AttServiceImpl implements AttService {

    @Autowired
    AttachmentMapper am;

    public List<Attachment> getAList() {
        List<Attachment> alist = am.getAlist();

        return alist;
    }

    public int saveInfo(Attachment att) {
        int i = am.insertSelective(att);

        return i;
    }

    public int update(Attachment att) {
        int i = am.updateByPrimaryKeySelective(att);

        return i;
    }

    public Attachment getAtt(int id) {
        Attachment attachment = am.selectByPrimaryKey(id);

        return attachment;
    }

    public int delById(int id) {
        int i = am.deleteByPrimaryKey(id);

        return i;
    }
}
