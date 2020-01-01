package com.offcn.email.controller;

import com.offcn.email.bean.Email;
import com.offcn.email.service.EmailService;
import com.offcn.emp.bean.Employee;
import com.offcn.emp.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Properties;

@Controller
@RequestMapping("email")
public class EmailController {

    @Autowired
    EmpService empService;

    @Autowired
    EmailService es;

    //    去发邮件页面
    @RequestMapping("toSendMail")
    public String toSendMail(Model model,
                             HttpSession session) {
        Employee usr = (Employee) session.getAttribute("usr");
        List<Employee> emplist = empService.getEmpNameNotInMyId(usr.getEid());
        model.addAttribute("emplist", emplist);

        return "email-send";
    }


    //    发送邮件
    @RequestMapping("sendMail")
    public String sendMail(Email email,
                           HttpSession sess,
                           MultipartFile files,
                           String revemail) throws IOException {
        String path = "E:\\attfile\\" + files.getOriginalFilename();
        File f = new File(path);
        files.transferTo(f);
        int i = 0;


// 发件人的邮箱和密码
        String myEmailAccount = "kangyuhu_zrr@126.com";
        String myEmailPassword = "54huhu";// 邮箱密码

        // 发件人邮箱的 SMTP 服务器地址, 必须准确, 不同邮件服务器地址不同, 一般(只是一般, 绝非绝对)格式为: smtp.xxx.com
        // 网易163邮箱的 SMTP 服务器地址为: smtp.163.com
        String myEmailSMTPHost = "smtp.126.com";
        // 收件人邮箱
        String receiveMailAccount = revemail;

        // 1. 创建参数配置, 用于连接邮件服务器的参数配置
        Properties props = new Properties();                    // 参数配置
        props.setProperty("mail.transport.protocol", "smtp");   // 使用的协议（JavaMail规范要求）
        props.setProperty("mail.smtp.host", myEmailSMTPHost);   // 发件人的邮箱的 SMTP 服务器地址
        props.setProperty("mail.smtp.auth", "true");            // 需要请求认证


        // 创建验证器
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                // 密码验证
                return new PasswordAuthentication("kangyuhu_zrr", "kyh123");// 邮箱的授权码
            }
        };

        // 2. 根据配置创建会话对象, 用于和邮件服务器交互（当前java程序和网易邮箱服务器之间的关联）
        Session session = Session.getInstance(props, auth);
        session.setDebug(true);
        try {
            // 3. 创建一封邮件（会话 发件邮箱账号 ，接收邮件的账号）
            MimeMessage message = createMimeMessage(session, myEmailAccount, receiveMailAccount, email, path);
            // 4. 根据 Session 获取邮件传输对象
            Transport transport = session.getTransport();
            // 5. 使用 邮箱账号 和 密码 连接邮件服务器, 这里认证的邮箱必须与 message 中的发件人邮箱一致, 否则报错
            transport.connect(myEmailAccount, myEmailPassword);
            // 6. 发送邮件, 发到所有的收件地址, message.getAllRecipients() 获取到的是在创建邮件对象时添加的所有收件人, 抄送人, 密送人
            transport.sendMessage(message, message.getAllRecipients());
            // 7. 关闭连接
            transport.close();
            //8.将发送的邮件保存到本地
            //        发件人
            Employee usr = (Employee) sess.getAttribute("usr");
            email.setEmpFk(usr.getEid());
//        发件时间
            email.setSendtime(new Date());
//        文件
            email.setPath(path);

            i = es.saveEmail(email);

            System.out.println();


        } catch (Exception e) {
            e.printStackTrace();
        } finally {

        }

        if (i > 0) {
            return "redirect:/email/getMyMailList";
        } else {
            return "error";
        }
    }

    //    发邮件
    public static MimeMessage createMimeMessage(Session session, String sendMail, String receiveMail, Email email, String relpath) throws Exception {
        // 1. 创建一封邮件
        MimeMessage message = new MimeMessage(session);

        // 2. From: 发件人（昵称有广告嫌疑，避免被邮件服务器误认为是滥发广告以至返回失败，请修改昵称）
        message.setFrom(new InternetAddress(sendMail, "发件人", "UTF-8"));

        // 3. To: 收件人（可以增加多个收件人、抄送、密送）
        message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(receiveMail, "接收人", "UTF-8"));
        message.addRecipients(MimeMessage.RecipientType.CC, InternetAddress.parse(sendMail));
        // 4. Subject: 邮件主题（标题有广告嫌疑，避免被邮件服务器误认为是滥发广告以至返回失败，请修改标题）
        message.setSubject(email.getTitle(), "UTF-8");


        // 创建消息部分
        BodyPart messageBodyPart = new MimeBodyPart();

        // 消息
        messageBodyPart.setText(email.getContent());

        // 创建多重消息
        Multipart multipart = new MimeMultipart();

        // 设置文本消息部分
        multipart.addBodyPart(messageBodyPart);

        // 附件部分
        messageBodyPart = new MimeBodyPart();
        // 设置要发送附件的文件路径
        DataSource source = new FileDataSource(relpath);
        messageBodyPart.setDataHandler(new DataHandler(source));


        messageBodyPart.setFileName(MimeUtility.encodeText(relpath));
        multipart.addBodyPart(messageBodyPart);

        // 5. Content: 邮件正文（可以使用html标签）（内容有广告嫌疑，避免被邮件服务器误认为是滥发广告以至返回失败，请修改发送内容）
        message.setContent(multipart);

        // 6. 设置发件时间
        message.setSentDate(new Date());

        // 7. 保存设置
        message.saveChanges();

        return message;
    }


    //    获取当前用户的邮件
    @RequestMapping("getMyMailList")
    public String getMyMailList(HttpSession session,
                                Model model,
                                @RequestParam(defaultValue = "0") int flag) {
        Employee usr = (Employee) session.getAttribute("usr");
        List<Email> emailList = null;
                Integer eid = usr.getEid();
        if (flag == 1) {
//                获取收件人是当前ID的邮件
            emailList =  es.getMyReceiveEmail(eid);
            for (int i = 0; i < emailList.size(); i++) {
//                收件箱
                Integer empFk = emailList.get(i).getEmpFk();
                Employee emp = empService.getEmp(empFk);
//                设置发件人name
                String ename = emp.getEname();
//                存入集合的对象中
                emailList.get(i).setEname(ename);
                System.out.println();
            }
        } else {
//            获取发件人是当前用户ID的邮件
            emailList = es.getMySendEmail(eid);
            for (int i = 0; i < emailList.size(); i++) {
//                发件箱
                Integer empFk2 = emailList.get(i).getEmpFk2();
                Employee emp = empService.getEmp(empFk2);
//                设置发件人的name
                String ename = emp.getEname();
//                保存到集合中
                emailList.get(i).setEname(ename);
                System.out.println();

            }
        }
        model.addAttribute("eList", emailList);
        model.addAttribute("flag", flag);

        return "email";
    }


}
