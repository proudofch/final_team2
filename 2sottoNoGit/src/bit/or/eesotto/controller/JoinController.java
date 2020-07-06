package bit.or.eesotto.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import bit.or.eesotto.dto.User;
import bit.or.eesotto.service.JoinService;

@Controller
public class JoinController {
	
	private static final Logger logger = LoggerFactory.getLogger(JoinController.class);

	@Autowired
	BCryptPasswordEncoder pwEncoder;
	
	@Autowired
	JoinService joinService;
	

	// 회원가입 화면 보러가기
	@RequestMapping(value = "register.bit", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView register(HttpSession session) throws IOException {

		/* 구글code 발행 */
		// OAuth2Operations oauthOperations =
		// googleConnectionFactory.getOAuthOperations();
		/* SNS 로그인 인증을 위한 url 생성 */

		/* 생성한 url 전달 */
		ModelAndView mav = new ModelAndView();
		mav.setViewName("join/register");

		return mav;
	}

	// 회원가입 view
	@RequestMapping(value = "joinForm.bit", method = { RequestMethod.GET, RequestMethod.POST })
	public String joinForm(HttpSession session, Model model) throws IOException {
		// 이메일 인증번호 확인을 위한 랜덤숫자 생성
		// int ran = new Random().nextInt(900000) + 100000;
		// model.addAttribute("random", ran);

		return "join/joinForm";
	}

	// 일반 회원가입 처리
	@RequestMapping(value = "normalJoin.bit", method = RequestMethod.POST)
	public String normalJoin(User user, HttpServletRequest request, HttpSession session, RedirectAttributes redirectAttributes,
			Model model){
		
		
		//비밀번호 암호화 
		String inputPwd = user.getPwd();
		String encodingPW = pwEncoder.encode(inputPwd);
		user.setPwd(encodingPW);		
		logger.info("비밀번호 암호화 완료");		
		
		int result = joinService.normalJoin(user);
		if(result==1) {
			session.setAttribute("userid", user.getUserid());
			logger.info("회원가입 처리 완료");
 
			return "redirect:/";
			
		}else { //회원가입 실패시 어찌할지 로직구현해야 함
			redirectAttributes.addFlashAttribute("failedLogin", "failed");
			logger.info("회원가입 실패");

			return "redirect:/";
		}
	} 

	// ID 중복체크 Ajax 호출
	@ResponseBody
	@RequestMapping(value = "idCheck.bit", method = { RequestMethod.POST })
	public List<String> idCheck(HttpServletRequest request, Model model) throws IOException {

		String id = request.getParameter("userid");

		return joinService.idCheck(id);
	}

}