package com.offcn.email.service;

import com.offcn.email.bean.Email;

import java.util.List;

public interface EmailService {

    int saveEmail(Email email);

    List<Email> getMyReceiveEmail(Integer eid);

    List<Email> getMySendEmail(Integer eid);
}
