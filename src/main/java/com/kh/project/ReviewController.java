package com.kh.project;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import dao.ReviewDAO;
import util.Common;
import vo.ReviewVO;

@Controller
public class ReviewController {

	@Autowired
	ServletContext app;

	@Autowired
	HttpServletRequest request;

	private final ReviewDAO review_dao;

	public ReviewController(ReviewDAO review_dao) {
		this.review_dao = review_dao;
	}

	// 전체목록 보기
	@RequestMapping("/reviewList.do")
	public String reviewList(Model model, String page, String search, String search_text) {

		int nowPage = 1;
		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}

		int start = (nowPage - 1) * Common.Review.BLOCKLIST + 1;
		int end = start + Common.Review.BLOCKLIST - 1;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);

		if (search != null && !search.equals("all")) {
			if (search.equals("sitter")) {
				map.put("review_sitter_name", search_text);
			} else if (search.equals("title")) {
				map.put("review_title", search_text);
			} else if (search.equals("service")) {
				map.put("review_service", search_text);
			}
		}

		List<ReviewVO> list = review_dao.selectList(map);

		int row_total = review_dao.getRowTotal(map);

		String search_param = String.format("search=%s&search_text=%s", search, search_text);

		String pageMenu = util.Paging._getPaging("reviewList.do", nowPage, row_total, search_param,
				Common.Review.BLOCKLIST, Common.Review.BLOCKPAGE);

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("search", search);
		model.addAttribute("search_text", search_text);

		return Common.Review.VIEW_PATH_REVIEW + "review.jsp";
	}

	@RequestMapping("/review_write.do")
	public String insert_form() {
		return Common.Review.VIEW_PATH_REVIEW + "review_write.jsp";
	}

	@RequestMapping("/review_insert.do")
	public String insert(ReviewVO vo) {
		String webPath = "/resources/upload";
		String savePath = app.getRealPath(webPath);

		MultipartFile review_photo = vo.getReview_photo();
		String review_photo_name = "no_file";

		if (!review_photo.isEmpty()) {
			review_photo_name = review_photo.getOriginalFilename();

			File saveFile = new File(savePath, review_photo_name);
			if (!saveFile.exists()) {
				saveFile.mkdirs();
			} else {
				long time = System.currentTimeMillis();
				review_photo_name = String.format("%d_%s", time, review_photo_name);
				saveFile = new File(savePath, review_photo_name);
			}

			try {
				review_photo.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}

			vo.setReview_photo_name(review_photo_name);
		} else {
			vo.setReview_photo_name("no_file");
		}

		review_dao.insert(vo);

		return "redirect:reviewList.do";
	}

	@RequestMapping(value = "/reviewdelete.do", method = RequestMethod.POST)
	@ResponseBody
	public String delete(int review_user_idx) {
		int res = review_dao.delete(review_user_idx);
		if (res > 0) {
			// 삭제 성공
			return "[{'result':'clear'}]";
		} else {
			// 삭제 실패
			return "[{'result':'fail'}]";
		}
	}

}