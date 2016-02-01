package com.spring.springboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.springframework.stereotype.Component;

@Component
public class BoardDAO {
	private Connection conn=null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	
	private final int BOARD_LIMIT = 10;
	private final String BOARD_INSERT
	="insert into board(seq, title, writer, content, regdate, cnt) "
			+ "values((select nvl(max(seq),0)+1 from board),?,?,?,sysdate,0)";
	
	private final String BOARD_UPDATE
	="update board set title=?, content=? where seq=?";
	
	private final String BOARD_UPDATE_CNT
	="update board set cnt=cnt+1 where seq=?";
	
	private final String BOARD_DELETE
	="delete from board where seq=?";
	
	private final String BOARD_SELECT
	="select * from "+
			"(select rownum , SEQ, TITLE, WRITER, CONTENT, REGDATE, CNT from "+
			"(select * from board order by SEQ desc ))where rownum>=? and rownum<=?";
	
	private final String BOARD_SEARCH 
	="select * from board where seq=?";
	
	public void addBoard(BoardVO boardVO){
		try{
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(BOARD_INSERT);
			stmt.setString(1, boardVO.getTitle());
			stmt.setString(2, boardVO.getWriter());
			stmt.setString(3, boardVO.getContent());
			stmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			JDBCUtil.closeResource(stmt, conn);
		}
	}
	
	public void updateBoard(BoardVO boardVO){
		try{
			conn = JDBCUtil.getConnection();
			PreparedStatement stmt=conn.prepareStatement(BOARD_UPDATE);
			stmt.setString(1, boardVO.getTitle());
			stmt.setString(2, boardVO.getContent());
			stmt.setInt(3, boardVO.getSeq());
			stmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			JDBCUtil.closeResource(stmt, conn);
		} 
	}
	public void deleteBoard(BoardVO boardVO){
		try{
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(BOARD_DELETE);
			stmt.setInt(1, boardVO.getSeq());
			stmt.executeUpdate();
		}catch (Exception e){
			e.printStackTrace();
		}finally{
			JDBCUtil.closeResource(stmt, conn);
		}
	}
	
	public BoardVO getBoard(BoardVO boardVO){
		BoardVO vo = null;
		try{
			conn = JDBCUtil.getConnection();
			
			stmt = conn.prepareStatement(BOARD_SEARCH);
			stmt.setInt(1, boardVO.getSeq());
			rs = stmt.executeQuery();
			
			while(rs.next()){
				vo = new BoardVO();
				vo.setSeq(rs.getInt("SEQ"));
				vo.setTitle(rs.getString("TITLE"));
				vo.setWriter(rs.getString("WRITER"));
				vo.setContent(rs.getString("CONTENT"));
				vo.setRegdate(rs.getDate("REGDATE"));
				vo.setCnt(rs.getInt("CNT")+1);
			
				stmt = conn.prepareStatement(BOARD_UPDATE_CNT);
				stmt.setInt(1, boardVO.getSeq());
				stmt.executeUpdate();
			}
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			JDBCUtil.closeResource(rs, stmt, conn);
		}
		return vo;
	}
	
	public ArrayList<BoardVO> getBoardList (BoardVO boardVO, int page){
		ArrayList<BoardVO> boardList = new ArrayList<BoardVO>();
		BoardVO vo = null;		
		
		try{
			int startrow=(page-1)*10+1; //읽기 시작할 row 번호.
			int endrow=startrow+BOARD_LIMIT-1; //읽을 마지막 row 번호.		
			
			conn=JDBCUtil.getConnection();
			stmt = conn.prepareStatement(BOARD_SELECT);
			stmt.setInt(1, startrow);
			stmt.setInt(2, endrow);
			rs = stmt.executeQuery();
			
			while(rs.next()){
				vo=new BoardVO();
				vo.setSeq(rs.getInt("SEQ"));
				vo.setTitle(rs.getString("TITLE"));
				vo.setWriter(rs.getString("WRITER"));
				vo.setContent(rs.getString("CONTENT"));
				vo.setRegdate(rs.getDate("REGDATE"));
				vo.setCnt(rs.getInt("CNT"));
				boardList.add(vo);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			JDBCUtil.closeResource(rs, stmt, conn);
		}
		return boardList;
	}
	//글 갯수 구하기
	public int getListCount() 
	{
		int x= 0;
		
		try
		{			
			conn=JDBCUtil.getConnection();
			stmt=conn.prepareStatement("select count(*) from board");
			rs = stmt.executeQuery();
			
			if(rs.next()){
				x=rs.getInt(1); 
			}
		} catch(Exception ex) { 
			System.out.println("getListCount 에러: " + ex); 
		}
		finally { 
			JDBCUtil.closeResource(rs, stmt, conn); 
		}
		return x;
	}
}
