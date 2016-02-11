package com.mycalendar.myapp;

import java.util.ArrayList;

public interface ScheduleService {
	public CalendarVO getCalendar(CalendarVO calendarVO);
	public CalendarVO getCalendar();
	public void addSchedule(ScheduleVO scheduleVO);
	public ArrayList<ScheduleVO> getScheduleList(CalendarVO calendarVO, String id);
	public ScheduleVO getDetail(String content_id);
}
