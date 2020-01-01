package com.offcn.work.service;

import com.offcn.work.bean.Notice;
import com.offcn.work.dao.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    NoticeMapper nm;

//    查找前4条数据
    public List<Notice> getNdate4() {
        List<Notice> ndate4 = nm.getNdate4();

        return ndate4;
    }


//    查找所有
    public List<Notice> getNList() {
        List<Notice> notices = nm.selectByExample(null);

        return notices;
    }
}
