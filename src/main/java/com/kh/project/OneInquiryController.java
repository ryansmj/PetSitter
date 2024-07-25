package com.kh.project;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import dao.OneInquiryDAO;
import util.Common;
import util.SitterPaging;
import vo.OneCommentVO;
import vo.OneInquiryVO;

@Controller
public class OneInquiryController {
	
	@Autowired 
	ServletContext app;
	
	OneInquiryDAO oneinquiry_dao;
	
	public void setOneinquiry_dao(OneInquiryDAO oneinquiry_dao) {
		this.oneinquiry_dao = oneinquiry_dao;
	}
	
	//1:1 질문 목록
	@RequestMapping("oneInquiryList.do")
	public String OneInquiryList(Model model, Integer user_idx, String page) {
		int nowPage = 1;
		if(page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}
		
		int start = (nowPage - 1) * Common.Sitter.BLOCKLIST + 1;
		int end = start + Common.Sitter.BLOCKLIST - 1;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("user_idx", user_idx);
		
		int row_total = oneinquiry_dao.myInquiryListRowTotal(map);
		String pageMenu = SitterPaging.myInquiryListPaging("myReserveList.do", nowPage, row_total, user_idx,Common.Sitter.BLOCKLIST, Common.Sitter.BLOCKPAGE);
		
		List<OneInquiryVO> list = oneinquiry_dao.oneInquiryList(map);
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		System.out.println("1:1 리스트사이즈: " + list.size());
		
		return Common.OneInquiry.VIEW_PATH_ONEINQUIRY + "myPage_oneInquiry_list.jsp";
	}
	
	//1:1 질문 폼
	@RequestMapping("oneInquiryForm.do")
	public String oneInquiryInsert() {
		return Common.OneInquiry.VIEW_PATH_ONEINQUIRY + "oneInquiry_form.jsp";
	}
	
	//1:1 질문 등록
	@RequestMapping("oneInquiryInsert.do")
	@ResponseBody
	public String oneInquiryInsert(OneInquiryVO vo) {
	
		String webPath = "/resources/upload/";
		String savePath = app.getRealPath(webPath); // 절대경로
		System.out.println(savePath);
		
		MultipartFile file = vo.getOneinquiry_file();
		String filename = "no_file";
		String filetype = "no_type";//파일종류 디폴트 선언
		if(file != null && !file.isEmpty()) {//null값 먼저 꼭 잡아야 함
			filename = file.getOriginalFilename();
			filetype = file.getContentType();//실제 파일 종류 담기
			
			File saveFile = new File(savePath, filename);
			if(!saveFile.exists()) {
				saveFile.mkdirs();
			}else {
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
			}
			
			try {
				file.transferTo(saveFile);
			} catch (Exception e) {
				// TODO: handle exception
			} 
		}
		
		vo.setOneinquiry_filename(filename); //파일이름 세터로 담기
		vo.setOneinquiry_filetype(filetype); //파일종류 세터로 담기
		
		int res = oneinquiry_dao.oneInquiryInsert(vo);
		
		String result = "no";
		if(res > 0) {
			result = "yes";
		}
		
		String resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;
		
	} 
	 
	//1:1 문의 자세히보기
	@RequestMapping("oneInquiryView.do")
	public String oneInquiryView(Model model, Integer oneinquiry_idx) {//Integer로 받아서 null검사 해야 nullpointerexception 안남
		
		if(oneinquiry_idx != null) {
			OneInquiryVO vo = oneinquiry_dao.oneInquiryView(oneinquiry_idx);
			model.addAttribute("vo", vo);
		}
		
		return Common.OneInquiry.VIEW_PATH_ONEINQUIRY + "myPage_oneInquiry_view.jsp";
	}
	
	//1:1 문의 코멘트 리스트 (**Responsebody 넣지 않는다)
	 @RequestMapping("commentList.do")
	 public String commentList(Model model, int oneinquiry_idx) {
		 List<OneCommentVO> list = oneinquiry_dao.oneCommentList(oneinquiry_idx);
		 model.addAttribute("list", list);
		 return Common.OneInquiry.VIEW_PATH_ONEINQUIRY + "oneComment_list.jsp"; 
	 }
	 
}
