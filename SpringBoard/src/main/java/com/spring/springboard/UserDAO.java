package com.spring.springboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.springframework.stereotype.Component;

@Component
public class UserDAO {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	
	private final String USER_SEARCH = "select * from users where id=? and password=?";
	public UserVO login(UserVO userVO){
		UserVO vo = null;
		try{
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(USER_SEARCH);
			stmt.setString(1, userVO.getId());
			stmt.setString(2, userVO.getPassword());
	
			rs=stmt.executeQuery();
			
			if(rs.next()){
				vo = new UserVO();
				vo.setId(rs.getString("ID"));
				vo.setName(rs.getString("NAME"));
				vo.setRole(rs.getString("ROLE"));
				System.out.println(rs.getString("ID"));
			}
		} catch (Exception e){
			e.printStackTrace();
		} finally {
			JDBCUtil.closeResource(rs, stmt, conn);
		}
		
		return vo;
	}
}
