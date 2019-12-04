package com.yafeng.paperbackend.service;

import com.yafeng.paperbackend.config.Redis.UserKeyPrefix;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import javax.mail.MessagingException;
import javax.mail.SendFailedException;
import javax.mail.internet.MimeMessage;
import java.util.UUID;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.service
 * describe: 由开发人员自主完善
 *
 * @author : songyafeng
 * creat_time: 2019/10/15 9:46
 **/
@Service
public class EmailService {
    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    private TemplateEngine templateEngine;
    @Autowired
    private RedisService redisService;

    //读取配置文件中的参数
    @Value("${spring.mail.username}")
    private String sender;

    /**
     * 发送简单文本邮件
     */
    public void sendSimpleEmail(String email, String paperName, String operateType) {
        SimpleMailMessage message = new SimpleMailMessage();
        // 发送者
        message.setFrom(sender);
        // 接收者
        message.setTo(email);
        //邮件主题
        message.setSubject("论文状态有变化");
        // 邮件内容
        message.setText("尊敬的作者：\n\t您的论文《" + paperName + "》，已经被" + operateType + "，请及时登录系统查看！"
                + "\n\t谢谢！");
        javaMailSender.send(message);
    }

    /**
     * 发送模板邮件
     * @param email 接收方的email
     * @param template 模板的名称，有激活模板和找回密码两种，/resource/templates下
     * @param subject 邮件主题
     */

    public void sendTemplateMail(String email,String template,String subject) throws SendFailedException {
        MimeMessage message = javaMailSender.createMimeMessage();
        try {
            //为了防止接收方丢入垃圾箱，可以在header里加上Outlook
            message.addHeader("X-Mailer","Microsoft Outlook Express 6.00.2900.2869");
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            //指定源、目的地、主题
            helper.setFrom(sender);
            helper.setTo(email);
            helper.setSubject(subject);

            Context context = new Context();
            //设置模板中的变量
            context.setVariable("email", email);
            //生成UUID作为tmpKey
            String token = UUID.randomUUID().toString().replaceAll("-", "");
            redisService.set(UserKeyPrefix.TOKEN, token, email);
            context.setVariable("token", token);
            //指定template模板
            String emailContent = templateEngine.process(template, context);
            helper.setText(emailContent, true);
        } catch (MessagingException e) {
            throw new RuntimeException("Messaging  Exception !", e);
        }
        javaMailSender.send(message);
    }
}

