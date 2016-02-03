package com.mycalendar.myapp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("calendarService")
public class CalendarServiceImpl implements CalendarService {

	@Autowired(required=false)
	private CalendarDAO calendarDAO=null;
	
	@Override
	public int getMonthList(int year, int month) {
		
		int firstday = calendarDAO.getFirstDate(year, month);
		
		return firstday;
	}

	@Override
	public int[] getCalendar() {
		int[] firstday = calendarDAO.getFirstDate();
		
		return firstday;
	}

}
