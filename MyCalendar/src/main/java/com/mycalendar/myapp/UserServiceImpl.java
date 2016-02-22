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
			
			UserVO vo = userDAO.login(userVO);
			return vo;
		}
		catch(Exception e){
			throw new Exception(userVO.getId()+"회원의 로그인 실패!",e);
		}
		
	}

	@Override
	public boolean join(UserVO userVO) throws Exception {
		boolean success;
		try{			
			success = userDAO.Join(userVO);	
			
		} catch(Exception e){
			throw new Exception();
		}
		return success;
	}

	@Override
	public int idCheck(String id) {
		int count = 0;
		count = userDAO.idCheck(id);
		return count;
	}
}
