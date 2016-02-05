package com.mycalendar.myapp;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/schedule.do")
public class ScheduleController {
	
	@Autowired
	private ScheduleService scheduleService;
			
	@RequestMapping(params="method=main")
	public String getCalendar(Model model, CalendarVO vo, HttpServletRequest request,HttpSession session) throws Exception{
		CalendarVO calendarVO = null;	
		
		calendarVO = scheduleService.getCalendar();
		
		model.addAttribute("calendarVO", calendarVO);
		UserVO userVO = (UserVO)session.getAttribute("vo");
		String id = userVO.getId();
		ArrayList<ScheduleVO> list = scheduleService.getScheduleList(calendarVO, id);
		model.addAttribute("list", list);
	
		return "main";
	}
	@RequestMapping(params="method=insertForm")
	public String getInputForm(CalendarVO calendarVO,HttpServletRequest request,HttpSession session) throws Exception{
			
		calendarVO.setDate(Integer.parseInt(request.getParameter("date")));
		calendarVO.setYear(Integer.parseInt(request.getParameter("year")));
		calendarVO.setMonth(Integer.parseInt(request.getParameter("month")));
		
		return "insertForm";
	}
	@RequestMapping(params="method=addSchedule")
	public String addSchedule(ScheduleVO scheduleVO,HttpSession session) throws Exception{
		try{
			scheduleService.addSchedule(scheduleVO);
			
			
			return "main";
		} catch(Exception e){
			
			return "insertForm";
		}
	}
}
