package com.mycalendar.myapp;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("userService")
public class UserServiceImpl implements UserService {
	
	@Autowired(required=false)
	private UserDAO userDAO=null;
	@Override
	public UserVO login(UserVO userVO) throws Exception {
		
		try{
			System.out.println("dd");
			UserVO vo = userDAO.login(userVO);
			return vo;
		}
		catch(Exception e){
			throw new Exception(userVO.getId()+"회원의 로그인 실패!",e);
		}
		
	}

	@Override
	public void join(UserVO userVO) throws Exception {
		try{			
			userDAO.Join(userVO);			
		} catch(Exception e){
			throw new Exception();
		}		
	}
}
