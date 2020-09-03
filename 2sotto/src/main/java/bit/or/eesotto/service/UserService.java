package bit.or.eesotto.service;

import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import bit.or.eesotto.dao.*;
import bit.or.eesotto.dto.*;

@Service
public class UserService {

	private static final Logger logger = LoggerFactory.getLogger(UserService.class);

	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	@Autowired
	UserDao userDao;
	@Autowired
	private JavaMailSender mailSender;

	// 어드민 > 유저 리스트 조회
	public List<User> getUserList(String userid) {

		List<User> userList = null;

		try {

			userDao = sqlsession.getMapper(UserDao.class);
			userList = userDao.getUserList(userid);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return userList;
	}

	// 어드민 > 유저 가입 확인 시작
	public int getUserCount() {
		
		int result = 0;
		
		try {
			userDao = sqlsession.getMapper(UserDao.class);
			result = userDao.getUserCount();
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return result;
	}
	// 어드민 > 유저 가입 확인 끝
	// -----------이메일 체크 시작-----------
	// 중복된 코드같은데 일단 가지고있음.
	/*
	 * public List<String> idCheck(String userid) {
	 * 
	 * List<String> list = null;
	 * 
	 * try {
	 * 
	 * userDao = sqlsession.getMapper(UserDao.class); list =
	 * userDao.getUserId(userid);
	 * 
	 * } catch (Exception e) { System.out.println(e.getMessage()); }
	 * 
	 * return list; }
	 */

	// -----------이메일 체크 끝-----------
	// ------------이메일 발송 서비스 시작------------
	public int sendConfirmEmail(Email email) throws Exception {
		MimeMessage messagedto = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(messagedto, true, "utf-8");

		Random random = new Random(System.currentTimeMillis());
		int confirmation = 0;

		while (true) {
			confirmation = (random.nextInt(10000));
			if (confirmation < 10000 && confirmation > 1000) {
				break;
			}
		}

		messageHelper.setFrom("2sotto.bit155@gmail.com"); // 보내는 메일주소는 수정하자 dispatcher-servlet이랑 맞춰주자.
		messageHelper.setTo(email.getReceiveMail());
		messageHelper.setSubject("슬기로운 반려생활 회원가입을 위해 요청하신 인증번호입니다.");
		messageHelper.setText("요청하신 인증번호는 " + confirmation + "입니다.");

		mailSender.send(messagedto);

		return confirmation;
	}
	// ------------이메일 발송 서비스 끝------------

	// 일자 별 가입자 수
	public List<Map<String, Object>> signUpCountbyDay() {

		List<Map<String, Object>> map = null;

		try {

			userDao = sqlsession.getMapper(UserDao.class);
			map = userDao.signUpCountbyDay();

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return map;
	}

}
