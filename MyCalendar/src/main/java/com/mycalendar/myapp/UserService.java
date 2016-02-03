package com.mycalendar.myapp;

public interface UserService {
	public UserVO login(UserVO userVO) throws Exception;	
	public void join(UserVO userVO) throws Exception;
}
