package com.mycalendar.myapp;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user.do")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(params="method=login")
	public String login(UserVO userVO, HttpSession session) throws Exception{
		UserVO vo = userService.login(userVO);
		
		if(vo != null){
			session.setAttribute("vo", vo);
			
			return "redirect:/schedule.do?method=main&showYear=0";			
		} else {
			return "loginForm";
		}
	}
	@RequestMapping(params="method=join")
	public String join(UserVO userVO) throws Exception{
		userService.join(userVO);
		
		return "loginForm";					
	}	
	
	@RequestMapping(params="method=logout")
	public String logout(HttpSession session) throws Exception{
		session.invalidate();
		return "loginForm";
	}
	@RequestMapping(params="method=loginform")
	public String loginForm() {
		
		return "loginForm";
	}
	@RequestMapping(params="method=joinform")
	public String joinForm() {
		
		return "joinForm";
	}
}
