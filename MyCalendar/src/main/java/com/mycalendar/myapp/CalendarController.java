package com.mycalendar.myapp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/calendar.do")
public class CalendarController {
	
	@Autowired
	private CalendarService calendarService;
	
	
	@RequestMapping(params="method=main")
	public String getMonthList(HttpServletRequest request, HttpSession session) throws Exception{
	
		
		return "main";
	
	}
	
	@RequestMapping(params="method=maintest")
	public String getCalendar(Abc abc,HttpServletRequest request,HttpSession session) throws Exception{
		
		int[] result = calendarService.getCalendar();
		abc.setYear(result[0]);
		abc.setMonth(result[1]);
		abc.setFirstDate(result[2]);
		abc.setLastDay(result[3]);
		request.setAttribute("abc", abc);
		
	
		return "main2";
	}
	@RequestMapping(params="method=test")
	public String getInputForm(Abc abc,HttpServletRequest request,HttpSession session) throws Exception{
			
		abc.setDate(Integer.parseInt(request.getParameter("date")));
		abc.setYear(Integer.parseInt(request.getParameter("year")));
		abc.setMonth(Integer.parseInt(request.getParameter("month")));
		
		return "insertForm";
	}
	@RequestMapping(params="method=insert")
	public String insert(Abc abc,HttpServletRequest request,HttpSession session) throws Exception{
		calendarService.insert();
		return "";
	}
}
