package com.mycalendar.myapp;

public interface UserService {
	public UserVO login(UserVO userVO) throws Exception;	
	public boolean join(UserVO userVO) throws Exception;
	public int idCheck(String id);
}
