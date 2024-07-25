package com.kh.project;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import vo.InquiryVO;
import dao.InquiryDAO;
import util.Common;

@Controller
public class InquiryController {

	@Autowired
	ServletContext app;
	
	@Autowired
	HttpServletRequest request;
	
	 private final InquiryDAO inquiry_dao;
	
	public InquiryController(InquiryDAO inquiry_dao) {
		this.inquiry_dao = inquiry_dao;
	}
	
	//전체목록 보기
	@RequestMapping("/faqList.do")
	public String faqList(Model model) {
		
		List<InquiryVO> list = inquiry_dao.selectList();
		model.addAttribute("list",list);
		
		return Common.Qna.VIEW_PATH_QNA + "inquiry.jsp";
	}
	
	


}