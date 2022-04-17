package kr.green.port.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.green.port.pagination.Criteria;
import kr.green.port.pagination.PageMaker;
import kr.green.port.service.CommentService;
import kr.green.port.vo.CommentVO;
import kr.green.port.vo.MemberVO;

@RestController
public class CommentController {
	
	@Autowired
	CommentService commentService;
	
	@RequestMapping(value ="/comment/insert")
	public String commentInsert(@RequestBody CommentVO comment, 
			HttpServletRequest request){
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		if(commentService.insertComment(comment, user)) {
			return "true";
		}
	  return "false";
	}
	@RequestMapping(value ="/comment/list")
	public Map<String, Object> commentList(Integer co_bd_num, Integer page){
		Criteria cri = new Criteria(page, 5);
		List<CommentVO> list = commentService.selectCommentList(co_bd_num, cri);
		Map<String, Object> map = new HashMap<String, Object>();
		
		int totalCount = commentService.selectTotalCount(co_bd_num);
		PageMaker pm = new PageMaker(totalCount, 5, cri);
		map.put("pm", pm);
		map.put("list", list);
		return map;
	}
	@RequestMapping(value ="/comment/delete")
	public String commentDelete(Integer co_num,HttpServletRequest request){
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		
	  return commentService.deleteComment(co_num, user);
	}
	@RequestMapping(value ="/comment/modify")
	public String commentModify(@RequestBody CommentVO comment,
			HttpServletRequest request){
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		
	  return commentService.updateComment(comment, user);
	}
}



