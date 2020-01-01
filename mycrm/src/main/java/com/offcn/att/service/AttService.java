package com.offcn.att.service;

import com.offcn.att.bean.Attachment;

import java.util.List;

public interface AttService {
//     查找所有
    List<Attachment> getAList();

    int saveInfo(Attachment att);

    int update(Attachment att);

    Attachment getAtt(int id);

    int delById(int id);
}
