package com.mycalendar.myapp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.springframework.stereotype.Component;

@Component
public class UserDAO {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	
	private final String USER_SEARCH = "select * from calendar_user where id=? and password=?";
	private final String USER_JOIN = "insert into calendar_user values(?, ?, ?)";
	public UserVO login(UserVO userVO){
		UserVO vo = null;
		try{
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(USER_SEARCH);
			stmt.setString(1, userVO.getId());
			stmt.setString(2, userVO.getPassword());
			
			rs=stmt.executeQuery();
			System.out.println("ee"+userVO.getId());
			if(rs.next()){
				vo = new UserVO();
				vo.setId(rs.getString("ID"));
				vo.setName(rs.getString("NAME"));				
				System.out.println(rs.getString("ID"));
			}
		} catch (Exception e){
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, stmt, conn);
		}
		
		return vo;
	}
	public boolean Join(UserVO userVO){

		try{
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(USER_JOIN);
			stmt.setString(1, userVO.getId());
			stmt.setString(2, userVO.getPassword());
			stmt.setString(3, userVO.getName());
			
			stmt.executeUpdate();
			return true;
		} catch(Exception e){
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.closeResource(stmt, conn);
		}
	}
}