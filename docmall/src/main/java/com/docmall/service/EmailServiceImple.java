package com.docmall.service;

import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.docmall.dto.EmailDTO;

import lombok.Setter;

@Service
public class EmailServiceImple implements EmailService {
	
	@Setter(onMethod_ = {@Autowired}) // jdk 1.8 onMethod_(언더바)/ 다른버전은 _(언더바)생략
	private JavaMailSender mailSender;

	@Override
	public void sendMain(EmailDTO dto, String message) {

		//메일 구성정보를 담당하는 객체(받는사람, 보내는 사람, 전자우편주소, 본문내용)
		MimeMessage msg = mailSender.createMimeMessage();
		
		try {
			//받는사람 메일주소
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiveMail()));
			
			//보내는 사람 (메일, 이름)
			msg.addFrom(new InternetAddress[] {new InternetAddress(dto.getSenderMail(),dto.getSenderName())});
			
			//메일제목
			msg.setSubject(dto.getSubject(),"utf-8");//인코딩
			
			//본문내용
//			msg.setText(authCode, "text/html; charset=utf-8");
			msg.setText(message, "utf-8");
			
			mailSender.send(msg); // Gmail 보안설정 확인
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
