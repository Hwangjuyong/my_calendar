package com.mycalendar.myapp;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("scheduleService")
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired(required=false)
	private ScheduleDAO ScheduleDAO=null;
	
	@Override
	public CalendarVO getCalendar(CalendarVO vo) {
		
		CalendarVO calendarVO=ScheduleDAO.getCalendarData(vo); 
		
		return calendarVO;
	}

	@Override
	public CalendarVO getCalendar() {
		CalendarVO calendarVO = ScheduleDAO.getCalendarData();
		
		return calendarVO;
	}

	@Override
	public void addSchedule(ScheduleVO calendarVO) {
		ScheduleDAO.addSchedule(calendarVO);
	}

	@Override
	public ArrayList<ScheduleVO> getScheduleList(CalendarVO calendarVO, String id) {
		
		ArrayList<ScheduleVO> list = ScheduleDAO.getMonthSchedule(calendarVO, id);
		return list;
		
	}

	@Override
	public ScheduleVO getDetail(String content_id) {
		
		ScheduleVO scheduleVO = null;
		scheduleVO = ScheduleDAO.getDetail(content_id);
		
		return scheduleVO;
	}

	

	

}
