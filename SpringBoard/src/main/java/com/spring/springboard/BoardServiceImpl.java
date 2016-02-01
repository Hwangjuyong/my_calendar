package com.spring.springboard;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired(required=false)
	private BoardDAO boardDAO=null;
	@Override
	public void addBoard(BoardVO boardVO) throws Exception {
		// TODO Auto-generated method stub
		try{
			System.out.println("BOARD"+boardDAO);
			boardDAO.addBoard(boardVO);
		} catch(Exception e){
			throw new Exception("게시글 등록실패!",e);
		}
	}

	@Override
	public void updateBoard(BoardVO boardVO) throws Exception {
		// TODO Auto-generated method stub
		try{
			boardDAO.updateBoard(boardVO);
			
		} catch(Exception e){
			throw new Exception("게시글 수정실패!",e);
		}

	}

	@Override
	public void deleteBoard(BoardVO boardVO) throws Exception {
		// TODO Auto-generated method stub
		try{
			boardDAO.deleteBoard(boardVO);
		} catch(Exception e){
			throw new Exception("게시글 삭제실패!",e);
		}
	}

	@Override
	public BoardVO getBoard(BoardVO boardVO) throws Exception {
		// TODO Auto-generated method stub
		try{ 
			return boardDAO.getBoard(boardVO);
		} catch(Exception e){
			throw new Exception("게시글 조회실패!",e);
		}
	
	}

	@Override
	public ArrayList<BoardVO> getBoardList(BoardVO boardVO, int page) throws Exception {
		// TODO Auto-generated method stub
		try{
			return boardDAO.getBoardList(boardVO,page);
		} catch(Exception e){
			throw new Exception("게시글 목록 조회실패!",e);
		}

	}

	@Override
	public int getListCount(BoardVO boardVO) throws Exception {
		try{
			return boardDAO.getListCount();
		} catch(Exception e){
			throw new Exception("게시글 갯수 불러오기실패!",e);
		}		
	}
	

}
