package com.mycalendar.myapp;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("scheduleService")
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired(required=false)
	private ScheduleDAO scheduleDAO=null;
	
	@Override
	public CalendarVO getCalendar(int year, int month) {
		
		CalendarVO calendarVO=scheduleDAO.getCalendarData(year, month); 
		
		return calendarVO;
	}

	@Override
	public CalendarVO getCalendar() {
		CalendarVO calendarVO = scheduleDAO.getCalendarData();
		
		return calendarVO;
	}

	@Override
	public void addSchedule(ScheduleVO scheduleVO) {
		scheduleDAO.addSchedule(scheduleVO);
	}

	@Override
	public ArrayList<ScheduleVO> getScheduleList(CalendarVO calendarVO, String id) {
		
		ArrayList<ScheduleVO> list = scheduleDAO.getMonthSchedule(calendarVO, id);
		return list;
		
	}

	@Override
	public ScheduleVO getDetail(String content_id) {
		
		ScheduleVO scheduleVO = null;
		scheduleVO = scheduleDAO.getDetail(content_id);
		
		return scheduleVO;
	}

	@Override
	public void deleteSchedule(String content_id) {
		scheduleDAO.deleteSchedule(content_id);
		
	}

	@Override
	public ArrayList<HolidayVO> getHolidayList(CalendarVO calendarVO) {
		
		ArrayList<HolidayVO> holidayList=scheduleDAO.getHolidaySchedule(calendarVO);
		return holidayList;
	}

	@Override
	public ArrayList<DDayVO> getDDayList(String id) {
		
		ArrayList<DDayVO> dDayList=scheduleDAO.getDDayList(id);
		return dDayList;
	}

	
	

}
