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
	public String getCalendar(Model model, CalendarVO calendarVO, HttpServletRequest request,HttpSession session) throws Exception{
				
		if(request.getParameter("showYear")==null||Integer.parseInt(request.getParameter("showYear"))==0){
			calendarVO = scheduleService.getCalendar();
		} else{
			int year=Integer.parseInt(request.getParameter("showYear"));
			int month=Integer.parseInt(request.getParameter("showMonth"));
			calendarVO= scheduleService.getCalendar(year, month);
		}
		ArrayList<HolidayVO> holidayList = scheduleService.getHolidayList(calendarVO);
		model.addAttribute("calendarVO", calendarVO);
		UserVO userVO = (UserVO)session.getAttribute("vo");
		String id = userVO.getId();
		ArrayList<ScheduleVO> list = scheduleService.getScheduleList(calendarVO, id);
		model.addAttribute("list", list);
		model.addAttribute("holidayList", holidayList);
		ArrayList<DDayVO> dDayList = scheduleService.getDDayList(id);
		model.addAttribute("dDayList",dDayList);
		return "main";
	}
	
	@RequestMapping(params="method=insertForm")
	public String getInputForm(CalendarVO calendarVO,HttpServletRequest request,HttpSession session) throws Exception{
			
		calendarVO.setDate(Integer.parseInt(request.getParameter("date")));
		calendarVO.setYear(Integer.parseInt(request.getParameter("year")));
		calendarVO.setMonth(Integer.parseInt(request.getParameter("month")));
		
		return "insertForm";
	}
	
	@RequestMapping(params="method=detail")
	public String getDetail(HttpServletRequest request,HttpSession session) throws Exception{
		
		ScheduleVO scheduleVO = null;
		
		String content_id = request.getParameter("content_id");
		scheduleVO = scheduleService.getDetail(content_id);
		
		request.setAttribute("scheduleVO", scheduleVO);
		return "detail";
	}
	
	@RequestMapping(params="method=addSchedule")
	public String addSchedule(ScheduleVO scheduleVO,HttpSession session) throws Exception{
		
		scheduleService.addSchedule(scheduleVO);
						
		return "redirect:/schedule.do?method=main";
		
	}
	
	@RequestMapping(params="method=deleteSchedule")
	public String deleteSchedule(HttpServletRequest request,HttpSession session) throws Exception{
		
		String content_id = request.getParameter("content_id");
		scheduleService.deleteSchedule(content_id);
						
		return "redirect:/schedule.do?method=main";
		
	}
	
	@RequestMapping(params="method=updateForm")
	public String getUpdateForm(HttpServletRequest request,HttpSession session) throws Exception{
		ScheduleVO scheduleVO = null;
		
		String content_id = request.getParameter("content_id");
		scheduleVO = scheduleService.getDetail(content_id);
		
		request.setAttribute("scheduleVO", scheduleVO);
		return "updateForm";
		
	}
}
