package com.kh.project;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import dao.SitterDAO;
import util.Common;
import util.SitterPaging;
import vo.ReserveVO;
import vo.SitterVO;
import vo.UserVO;

@Controller
public class SitterController {

	@Autowired
	HttpSession session;
	
	@Autowired
	ServletContext app;

	SitterDAO sitter_dao;

	public void setSitter_dao(SitterDAO sitter_dao) {
		this.sitter_dao = sitter_dao;
	}

	//시터 지원 폼
	@RequestMapping("sitterForm.do")
	public String sitterForm() {
		return Common.Sitter.VIEW_PATH_SITTER + "sitter_form.jsp";
	}

	//시터 등록
	@RequestMapping("sitterInsert.do")
	public String sitterInsert(SitterVO vo) {
		String webPath = "/resources/upload/";
		String savePath = app.getRealPath(webPath); // 절대경로
		System.out.println(savePath);

		System.out.println("제목:" + vo.getSitter_title());

		// 돌봄 공간 사진
		MultipartFile house1 = vo.getSitter_house1();
		MultipartFile house2 = vo.getSitter_house2();
		MultipartFile house3 = vo.getSitter_house3();
		List<MultipartFile> houseList = new ArrayList<MultipartFile>();
		if (house1 != null && !house1.isEmpty()) {
			houseList.add(house1);
		}
		if (house2 != null && !house2.isEmpty()) {
			houseList.add(house2);
		}
		if (house3 != null && !house3.isEmpty()) {
			houseList.add(house3);
		}

		// 시터 자격증 사진
		MultipartFile license1 = vo.getSitter_license_photo1();
		MultipartFile license2 = vo.getSitter_license_photo2();
		MultipartFile license3 = vo.getSitter_license_photo3();
		List<MultipartFile> licenseList = new ArrayList<MultipartFile>();
		if (license1 != null && !license1.isEmpty()) {
			licenseList.add(license1);
		}
		if (license2 != null && !license2.isEmpty()) {
			licenseList.add(license2);
		}
		if (license3 != null && !license3.isEmpty()) {
			licenseList.add(license3);
		}

		// 6개 사진들의 디폴트 이름 지정 (리스트에 "no_file"을 3개씩 넣는다)
		List<String> houseNameList = new ArrayList<String>();
		List<String> licenseNameList = new ArrayList<String>();
		for (int i = 0; i < 3; i++) {
			houseNameList.add("no_file");
			licenseNameList.add("no_file");
		}

		// 돌봄 공간 사진 있을 경우 사진의 실제 이름 가져오기 (실제 사진이 있으면 해당 인덱스값만 실제사진이름으로 대체. 나머지는 그대로
		// no_file)
		for (int i = 0; i < houseList.size(); i++) {
			houseNameList.set(i, houseList.get(i).getOriginalFilename());
		}
		// 자격증 사진이 있을 경우 사진의 실제 이름 가져오기
		for (int i = 0; i < licenseList.size(); i++) {
			licenseNameList.set(i, licenseList.get(i).getOriginalFilename());
		}

		// 파일 저장 경로 생성을 위한 파일 리스트 생성 (실제 사진이 존재하는 갯수 만큼만 생성)
		List<File> houseFile = new ArrayList<File>();
		for (int i = 0; i < houseList.size(); i++) {
			houseFile.add(new File(savePath, houseNameList.get(i)));
		}
		List<File> licenseFile = new ArrayList<File>();
		for (int i = 0; i < licenseList.size(); i++) {
			licenseFile.add(new File(savePath, licenseNameList.get(i)));
		}

		// 돌봄공간 파일 저장 경로 생성
		for (int i = 0; i < houseFile.size(); i++) {
			if (!houseFile.get(i).exists()) {
				houseFile.get(i).mkdirs();
			} else {
				// 동명파일 존재시 업로드시간 추가하여 이름 중복 방지
				long time = System.currentTimeMillis();
				houseNameList.set(i, String.format("%d_%s", time, houseNameList.get(i)));
				houseFile.set(i, new File(savePath, houseNameList.get(i))); // 중복이름 경로를 시간을 추가한 새로운 경로로 대체
			}

			try {
				// 실제 사진을 가져와서 위에서 생성한 경로(file)에 저장 (동일한 이름의 폴더가 존재하면 그 폴더를 파일로 대체)
				houseList.get(i).transferTo(houseFile.get(i));

			} catch (Exception e) {
				// TODO: handle exception
			}
		}

		// 자격증 파일 저장 경로 생성
		for (int i = 0; i < licenseFile.size(); i++) {
			if (!licenseFile.get(i).exists()) {
				licenseFile.get(i).mkdirs();
			} else {
				long time = System.currentTimeMillis();
				licenseNameList.set(i, String.format("%d_%s", time, licenseNameList.get(i)));
				licenseFile.set(i, new File(savePath, licenseNameList.get(i)));
			}

			try {
				licenseList.get(i).transferTo(licenseFile.get(i));

			} catch (Exception e) {
				// TODO: handle exception
			}
		}

		// vo에 파일 이름 저장
		vo.setHouse1_name(houseNameList.get(0));
		vo.setHouse2_name(houseNameList.get(1));
		vo.setHouse3_name(houseNameList.get(2));
		vo.setLicense_photo1_name(licenseNameList.get(0));
		vo.setLicense_photo2_name(licenseNameList.get(1));
		vo.setLicense_photo3_name(licenseNameList.get(2));
		
		// DB에 자료 입력
		int sitter_res = sitter_dao.sitterInsert(vo);
		int approval_res = sitter_dao.sitterApprovalinsert(vo);

		return Common.Sitter.VIEW_PATH_SITTER + "sitter_submit.jsp";
	}

	//시터 검색페이지
	@RequestMapping("findSitter.do")
	public String findSitter() {
		return Common.Sitter.VIEW_PATH_SITTER + "findSitter.jsp";
	}

	//시터 리스트
	@RequestMapping("findSitterList.do")
	public String findSitterList(Model model, SitterVO vo, String page, String orderby) {

		int nowPage = 1;
		if(page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}
		
		int start = (nowPage - 1) * Common.Sitter.BLOCKLIST + 1;
		int end = start + Common.Sitter.BLOCKLIST - 1;
		 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("vo", vo);
		map.put("orderby", orderby);
//7/9 세션에 담긴 user_idx를 map에 담아 DAO에 함께 보낸다
		UserVO user_vo= (UserVO)session.getAttribute("user");
		int user_idx = user_vo.getUser_idx();
		map.put("user_idx", user_idx);		 
		
		
		System.out.println("start: " + start);
		System.out.println("end: " + end);
		
		List<SitterVO> list = sitter_dao.selectSitterList(map);
		
		int row_total = sitter_dao.getRowTotal(map);
		String pageMenu = SitterPaging.findSittertPaging("findSitterList.do", nowPage, row_total, vo, orderby, Common.Sitter.BLOCKLIST, Common.Sitter.BLOCKPAGE);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);   

		return Common.Sitter.VIEW_PATH_SITTER + "findSitter_list.jsp";
	}

	//구/군 선택목록
	@RequestMapping(value= "getDistrict.do", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String getDistrict(String city) { 
		System.out.println("선택된 도시 : " + city);
		List<String> district_list = sitter_dao.getDistrict(city);
		
		Gson gson = new Gson();
		String json = gson.toJson(district_list); 
		System.out.println("gson변환 : " + json);
		
		return json;
	}
	
// 7/5
	//시터 자세히 보기
	@RequestMapping("findSitterView.do")
	public String findSitterView(Model model, SitterVO vo) {
		System.out.println("컨트롤러에 전달받은 sitter_idx : " + vo.getSitter_idx());
			
		Map<String, Object> map = sitter_dao.sitterSelectOne(vo);
		String user_address = (String)map.get("user_address"); //users테이블에서 가져온 시터의 주소
		SitterVO res_vo = (SitterVO)map.get("res_vo"); //sitter테이블에서 가져온 시터 vo
			
		model.addAttribute("user_address", user_address);  //users테이블에서 가져온 시터의 주소
		model.addAttribute("vo", res_vo); //sitter테이블에서 가져온 시터 vo
		return Common.Sitter.VIEW_PATH_SITTER + "findSitter_view.jsp";
	}
	
	//예약하기
	@RequestMapping("reserve.do")
	public String reserveInsert(ReserveVO vo) {
		System.out.println("reserve 컨트롤러. sitter_idx : " + vo.getReserve_sitter_idx() );
		System.out.println("reserve 컨트롤러. sitter_name : " + vo.getReserve_sitter_name() );
		int res = sitter_dao.reserveInsert(vo);
		
		return Common.Sitter.VIEW_PATH_SITTER + "reserve_submit.jsp";
	}
//즐겨찾기 추가	
	@RequestMapping("favoriteInsert.do")
	@ResponseBody
	public String favoriteInsert(int sitter_idx) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		//세션에서 user_idx 가져오기
		UserVO user_vo = (UserVO)session.getAttribute("user");
		int user_idx = user_vo.getUser_idx(); 
		map.put("user_idx", user_idx );
		map.put("sitter_idx", sitter_idx);
		//map.put("sitter_idx", vo.getSitter_idx()); //파라미터로 전달받은 시터idx
		
		//즐겨찾기에 존재하는지 확인
		int existItem = sitter_dao.favoriteExists(map);
		
		int res = 0;
		if(existItem < 1) {
			res = sitter_dao.favoriteInsert(map); //즐겨찾기에 존재하지 않으면 insert함수 호출
		}
		
		String resultStr = "";
		String result = "no"; 
		if(res > 0) {
			result = "yes";
		}
		
		resultStr = String.format("[{'result':'%s'}]", result);
		
		return resultStr;  
	}
	
// 7/8
//상단 메뉴의 댕시터 지원하기 클릭시 sitter테이블에 존재여부
		@RequestMapping("sitterSubmitted.do")
		@ResponseBody
		public String sitterSubmitted(int user_idx) {
			System.out.println("시터테이블에 존재하는지 확인 컨트롤러");
			int count = sitter_dao.sitterSubmitted(user_idx);
			System.out.println("시터테이블에 존재하는 카운트 : " + count);
				
			String resultStr = "";
			String result = "no";
			if(count > 0) { 
				result = "yes";
			}
				
			resultStr = String.format("[{'result':'%s'}]", result);
			return resultStr;
				
		}
}
