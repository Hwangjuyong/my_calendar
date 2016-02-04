package com.mycalendar.myapp;

public interface CalendarService {
	public int getMonthList(int year, int month);
	public int[] getCalendar();
	public void insert();
}
