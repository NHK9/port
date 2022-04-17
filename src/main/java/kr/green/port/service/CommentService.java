package kr.green.port.service;

import java.util.List;

import kr.green.port.pagination.Criteria;
import kr.green.port.vo.CommentVO;
import kr.green.port.vo.MemberVO;

public interface CommentService {

	boolean insertComment(CommentVO comment, MemberVO user);

	List<CommentVO> selectCommentList(Integer co_bd_num, Criteria cri);

	int selectTotalCount(Integer co_bd_num);

	String deleteComment(Integer co_num, MemberVO user);

	String updateComment(CommentVO comment, MemberVO user);

}
