package com.docmall.service;

import com.docmall.dto.EmailDTO;

public interface EmailService {
	
	void sendMain(EmailDTO dto, String message);

}
