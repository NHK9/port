package kr.green.port.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.green.port.pagination.Criteria;
import kr.green.port.vo.CommentVO;

public interface CommentDAO {

	void insertComment(@Param("comment")CommentVO comment);

	List<CommentVO> selectCommentList(@Param("co_bd_num")Integer co_bd_num, @Param("cri")Criteria cri);

	int selectTotalCountComment(@Param("co_bd_num")Integer co_bd_num);

	CommentVO selectComment(@Param("co_num")Integer co_num);

	void deleteComment(@Param("co_num")Integer co_num);

	void updateComment(@Param("comment")CommentVO comment);

}
