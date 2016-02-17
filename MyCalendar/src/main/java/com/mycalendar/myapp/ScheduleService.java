package com.mycalendar.myapp;

import java.util.ArrayList;

public interface ScheduleService {
	public CalendarVO getCalendar(int year, int month);
	public CalendarVO getCalendar();
	public void addSchedule(ScheduleVO scheduleVO);
	public ArrayList<ScheduleVO> getScheduleList(CalendarVO calendarVO, String id);
	public ScheduleVO getDetail(String content_id);
	public void deleteSchedule(String content_id);
	public ArrayList<HolidayVO> getHolidayList(CalendarVO calendarVO);
	public ArrayList<DDayVO> getDDayList(String id);
}
