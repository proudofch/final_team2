package bit.or.eesotto.service;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.or.eesotto.dao.UserDao;
import bit.or.eesotto.dto.User;

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
	

	//어드민 > 유저 리스트 조회
	public List<User> getUserList(String userid) {
		
		List<User> userList = null;

		try {

			userDao = sqlsession.getMapper(UserDao.class);
			userList = userDao.getUserList(userid);
			System.out.println(userList);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return userList;
	}
	
	
	//어드민 > 유저 가입 확인
		public int getUserCount(User user) {
			
			int result = 0;

			try {

				userDao = sqlsession.getMapper(UserDao.class);
				result = userDao.getUserCount(user);
				System.out.println("너는 값이 뭐로 나오나??");
				
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}

			return result;
		}
	
	
}

