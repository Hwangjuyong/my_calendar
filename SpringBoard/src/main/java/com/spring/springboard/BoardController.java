package com.spring.springboard;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board.do")
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(params="method=addBoardForm")
	public String addBoardForm() throws Exception {
		return "addBoardForm";
	}
	@RequestMapping(params="method=addBoard")
	public String addBoard(BoardVO boardVO) throws Exception{
		boardService.addBoard(boardVO);
		return "redirect:/board.do?method=getBoardList";
	}
	@RequestMapping(params="method=updateBoardForm")
	public String updateBoardForm(BoardVO boardVO, Model model) throws Exception{
		BoardVO vo = boardService.getBoard(boardVO);
		model.addAttribute("boardVO", vo);
		return "updateboardform";
	}
	@RequestMapping(params="method=updateBoard")
	public String updateBoard(BoardVO boardVO) throws Exception {
		boardService.updateBoard(boardVO);
		return "redirect:/board.do?method=getBoardList";
	}
	@RequestMapping(params="method=deleteBoard")
	public String deleteBOard(BoardVO boardVO) throws Exception {
		boardService.deleteBoard(boardVO);
		return "redirect:/board.do?method=getBoardList";
	}
	@RequestMapping(params="method=getBoard")
	public String getBoard(BoardVO boardVO, Model model) throws Exception {
		BoardVO vo = boardService.getBoard(boardVO);
		model.addAttribute("boardVO", vo);
		return "getboard";
	}
	@RequestMapping(params="method=getBoardList")
	public String getBoardList(BoardVO boardVO, Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
								
		int page=1;
		int limit=10;
		
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		int listcount = boardService.getListCount(boardVO); //총 리스트 수를 받아옴
		ArrayList<BoardVO> boardList = boardService.getBoardList(boardVO, page); //리스트를 받아옴
		
		//총 페이지 수
 		int maxpage=(int)((double)listcount/limit+0.95); //0.95를 더해서 올림 처리
 		//현재 페이지에 보여줄 시작 페이지 (1, 11, 21 등...)
 		int startpage = (((int) ((double)page / 10 + 0.9)) - 1) * 10 + 1;
 		//현재 페이지에 보여줄 마지막 페이지 (10, 20, 30 등...)
		int endpage = startpage+10-1;

 		if (endpage> maxpage) endpage= maxpage;
 		
		model.addAttribute("page", page); //현재 페이지 수
		model.addAttribute("maxpage", maxpage); //최대 페이지 수
		model.addAttribute("startpage", startpage); //현재 페이지에 표시할 첫 페이지
		model.addAttribute("endpage", endpage); // 현재 페이지에 표시할 끝 페이지
		model.addAttribute("listcount",listcount); //글 수
		model.addAttribute("boardList",boardList);
		return "getboardlist";
	}
}
