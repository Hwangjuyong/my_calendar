package com.spring.springboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("userService")
public class UserServiceImpl implements UserService {
	
	@Autowired(required=false)
	private UserDAO userDAO=null;
	@Override
	public UserVO login(UserVO userVO) throws Exception {
		// TODO Auto-generated method stub
		try{
			System.out.println("BOARD"+userDAO);
			UserVO vo = userDAO.login(userVO);
			return vo;
		}
		catch(Exception e){
			throw new Exception(userVO.getId()+"회원의 로그인 실패!",e);
		}
		
	}

}
