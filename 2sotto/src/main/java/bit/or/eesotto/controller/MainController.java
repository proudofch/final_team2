package bit.or.eesotto.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import bit.or.eesotto.dao.PetDao;
import bit.or.eesotto.dto.*;
import bit.or.eesotto.service.*;

@Controller
public class MainController {
	
	@Autowired
	BlogService bs;
	
	@Autowired
	MainService ms;
	
	@Autowired
	DonationService ds;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
//		@Autowired
//		LoginService ls;
		
		//index페이지
		//초기 랜딩 페이지 
		@RequestMapping("/")
		public String index(String cp, String ps, Principal principal, Model model) {
			
			String userid=null;
			
			//블로그 인기글 조회
			if(principal!=null) {
				userid =  principal.getName();
				logger.info("로그인 유저 아이디: " + userid);
			}
			HashMap<String, Object> map = bs.mainView(cp, "30", userid);
			logger.info("블로그 인기글 리스트 조회 완료");
			
//			//반려동물 정보 조회
//			List<Pet> petList = ms.getPetPicture(userid);
			
			//후원글 조회
			HashMap<String, Object> donationList = ds.main(cp, ps);
			System.out.println("도네이션 리스트: " + donationList);
			
//			//팔로우(좋아요)한 반려동물 목록 조회
//			List<PetLike> list = ms.getPetLike(userid);
			
			
			// view까지 전달 (forward)
			model.addAttribute("cpage", map.get("cpage"));
			model.addAttribute("pageSize", map.get("pageSize"));
			model.addAttribute("postList", map.get("postList")); 		
			model.addAttribute("pageCount", map.get("pageCount"));
			model.addAttribute("totalPostCount", map.get("totalPostCount"));
//			model.addAttribute("petList", petList); 
			model.addAttribute("donationList", donationList.get("donationList")); 
//			model.addAttribute("petLikeList", list);
			
			return "index";
		}
	
	    //로그인 메인 페이지 
		@RequestMapping("main.bit")
		/*
		public String nomalLogin(String userid, String pwd, HttpSession session, Model model) {
			return "redirect:/";
		}*/
		public String main(String cp, String ps, HttpSession session, Principal principal, Model model) {
			
			String userid=null;
			
			if(principal!=null) {
				userid =  principal.getName();
				logger.info("로그인 유저 아이디: " + userid);
			}
			
			User user = (User)session.getAttribute(userid);
			System.out.println("유저 객체체체체체체체 " + user);
			
			//블로그 인기글 조회
			HashMap<String, Object> map = bs.popularPostList(cp, ps, userid);
			logger.info("블로그 인기글 리스트 조회 완료");
			
			//반려동물 정보 조회
			List<Pet> petList = ms.getPetPicture(userid);
			
			//후원글 조회
			HashMap<String, Object> donationList = ds.main(cp, ps);
			System.out.println("도네이션 리스트: " + donationList);
			
			//팔로우(좋아요)한 반려동물 목록 조회
			List<PetLike> list = ms.getPetLike(userid);
			
			System.out.println("나의 펫 리스트: "+ petList);
			//동물 친구 추천 리스트 조회
			List<Pet> recommendPetList = ms.getRecommendPetList(petList, user);
			
			
			// view까지 전달 (forward)
			model.addAttribute("cpage", map.get("cpage"));
			model.addAttribute("pageSize", map.get("pageSize"));
			model.addAttribute("postList", map.get("postList")); 		
			model.addAttribute("pageCount", map.get("pageCount"));
			model.addAttribute("totalPostCount", map.get("totalPostCount"));
			model.addAttribute("petList", petList); 
			model.addAttribute("donationList", donationList.get("donationList")); 
			model.addAttribute("petLikeList", list);
			model.addAttribute("recommendPetList", recommendPetList);
			
			 return "main";
		 }
		
		// 비로그인 메인 페이지 (현재 비로그인하면 index페이지로 보냄. 여기 안씀)
		@RequestMapping(value = "mainTest.bit", method = RequestMethod.GET)
		public String mainView(String cp, String ps, Principal principal, Model model) {
			
		
			logger.info("작업시작이다..." );
			
			String userid=null;
			
			//블로그 인기글 조회
			if(principal!=null) {
				userid =  principal.getName();
				logger.info("로그인 유저 아이디: " + userid);
			}
			
			
			HashMap<String, Object> map = bs.myMainView(cp, ps, userid);
			logger.info("모두의 블로그 글 리스트 조회 완료");
			
			// view까지 전달 (forward)
			model.addAttribute("cpage", map.get("cpage"));
			model.addAttribute("pageSize", map.get("pageSize"));
			model.addAttribute("postList", map.get("postList")); 		
			model.addAttribute("pageCount", map.get("pageCount"));
			model.addAttribute("totalPostCount", map.get("totalPostCount"));
			
			
			return "main";
		}
		
		// 로그인 메인 페이지 
		@RequestMapping(value = "mainTest2.bit", method = RequestMethod.GET)
		public String mainViewTest(String cp, String ps, Principal principal, Model model) {
			
			String userid = principal.getName();

			List<PetLike> list = ms.getPetLike(userid);
			model.addAttribute("petLikeList", list);
			
			List<Pet> list2 = ms.getPetPicture(userid);
			model.addAttribute("petPictureList", list2);
		
			
			logger.info("mainTest2로 petLike보내기");
			
			return "mainTest2";
		}
		

		// 알림테스트 메인 페이지 
		@RequestMapping(value = "alarmTest.bit", method = RequestMethod.GET)
		public String alarmViewTest(String cp, String ps, Principal principal, Model model) {
			
			logger.info("다시작업시작이다..." );

			return "/alarmTest";
		}
		
}
