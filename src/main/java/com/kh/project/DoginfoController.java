package com.kh.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import dao.DoginfoDAO;
import util.Common;
import vo.DoginfoVO;
import vo.UserVO;

@Controller
public class DoginfoController {

    private  DoginfoDAO doginfo_dao;
    private  HttpSession session;
	@Autowired
	HttpServletRequest request;
	
	 @Autowired
	 ServletContext app;

    @Autowired
    public DoginfoController(DoginfoDAO doginfo_dao, HttpSession session) {
        this.doginfo_dao = doginfo_dao;
        this.session = session;
    }

    
   
    @RequestMapping("/dogList.do")
    public String list(Model model, @RequestParam(value = "user_idx", required = false, defaultValue = "0") int user_idx) {
        System.out.println(user_idx );
        List<DoginfoVO> list = doginfo_dao.selectList(user_idx);
        model.addAttribute("list", list);
        return Common.Doginfo.VIEW_PATH_DOGINFO + "doginfo_my.jsp";
    }
    
    @RequestMapping("/dogwrite.do")
    public String insert_form() {
    	System.out.println("컨트롤러1");
    	return Common.Doginfo.VIEW_PATH_DOGINFO + "dog_submit.jsp";
    }
    
    @RequestMapping("/dog_insert.do")
    public String insert(DoginfoVO vo) {
    	
    	UserVO user = (UserVO) session.getAttribute("user");
        user.setDog_name(vo.getDog_name());
        user.setDog_age(vo.getDog_age());
        session.setAttribute("user", user);
    	String webPath = "/resources/upload";
        String savePath = app.getRealPath(webPath);
        
        MultipartFile dog_photo = vo.getDog_photo();
        String dog_photo_name = "no_file";

        if (!dog_photo.isEmpty()) {
            dog_photo_name = dog_photo.getOriginalFilename();

            File saveFile = new File(savePath, dog_photo_name);
            if (!saveFile.exists()) {
                saveFile.mkdirs();
            } else {
                long time = System.currentTimeMillis();
                dog_photo_name = String.format("%d_%s", time, dog_photo_name);
                saveFile = new File(savePath, dog_photo_name);
            }

            try {
                dog_photo.transferTo(saveFile);
            } catch (Exception e) {
                e.printStackTrace();
            }

            vo.setDog_photo_name(dog_photo_name);
        } else {
            vo.setDog_photo_name("no_file");
        }
        
        
    
    	
    	doginfo_dao.insert(vo);
    	return "redirect:dogList.do?user_idx=" + vo.getDog_user_idx();
    }
    
    
    @RequestMapping("/dog_modify.do")
    public String modify_form(int dog_idx, Model model) {
    	
    	DoginfoVO vo = doginfo_dao.selectOne(dog_idx);
    	model.addAttribute("vo",vo);
    	return Common.Doginfo.VIEW_PATH_DOGINFO + "dog_modify.jsp";
    }
    
    
    
    
    @RequestMapping("/dog_update.do")
    public String update(DoginfoVO vo) {
    	
    	String webPath = "/resources/upload";
        String savePath = app.getRealPath(webPath);
        
        MultipartFile dog_photo = vo.getDog_photo();
        String dog_photo_name = "no_file";

        if (!dog_photo.isEmpty()) {
            dog_photo_name = dog_photo.getOriginalFilename();

            File saveFile = new File(savePath, dog_photo_name);
            if (!saveFile.exists()) {
                saveFile.mkdirs();
            } else {
                long time = System.currentTimeMillis();
                dog_photo_name = String.format("%d_%s", time, dog_photo_name);
                saveFile = new File(savePath, dog_photo_name);
            }

            try {
                dog_photo.transferTo(saveFile);
            } catch (Exception e) {
                e.printStackTrace();
            }

            vo.setDog_photo_name(dog_photo_name);
        } else {
            vo.setDog_photo_name("no_file");
        }
    	

    	
    	int res = doginfo_dao.update(vo);
		
    	 if (res > 0) {
    		 UserVO user = (UserVO) session.getAttribute("user");
             user.setDog_name(vo.getDog_name());
             user.setDog_age(vo.getDog_age());
             session.setAttribute("user", user);
    	        return "redirect:dogList.do?user_idx=" + vo.getDog_user_idx();
    	    } else {
    	        return "redirect:dogList.do?user_idx=" + vo.getDog_user_idx() + "&result=fail";
    	    }
    	
    }
    
    @RequestMapping("/dog_delete.do")
	@ResponseBody
	public String delete(int dog_idx){
		int res = doginfo_dao.delete(dog_idx);
		if (res > 0) {
           // 삭제 성공
           return "[{'result':'clear'}]";
       } else {
           // 삭제 실패
           return "[{'result':'fail'}]";
       }	
	}
    
    @RequestMapping(value = "/checkDogCount.do", method = RequestMethod.GET)
    @ResponseBody
    public int checkDogCount(@RequestParam("user_idx") int user_idx) {
        return doginfo_dao.countDogsByUser(user_idx);
    }

    @RequestMapping("/dogcheck_insert.do")
    public String insert(DoginfoVO vo, Model model) {
        int dogCount = doginfo_dao.countDogsByUser(vo.getDog_user_idx());
        if (dogCount > 0) {
            model.addAttribute("error", "한 명의 유저는 한 마리의 강아지만 등록할 수 있습니다.");
            return Common.Doginfo.VIEW_PATH_DOGINFO + "dog_submit.jsp";
        }

        // 나머지 insert 로직
        return "redirect:dogList.do?user_idx=" + vo.getDog_user_idx();
    }
    

}
