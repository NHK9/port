package kr.green.port.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.green.port.pagination.Criteria;
import kr.green.port.vo.BoardVO;
import kr.green.port.vo.FileVO;
import kr.green.port.vo.LikesVO;
import kr.green.port.vo.MemberVO;

public interface BoardService {

	void registerBoard(BoardVO board, List<MultipartFile> files) throws Exception;

	List<BoardVO> getBoardList(Criteria cri);

	BoardVO getBoard(Integer bd_num);

	void deleteBoard(Integer bd_num, MemberVO user);

	BoardVO getBoard(Integer bd_num, MemberVO user);

	void updateBoard(BoardVO board, List<MultipartFile> files, Integer[] fileNums);

	List<FileVO> getFileList(Integer bd_num);

	int getTotalCount(Criteria cri);

	void updateViews(Integer bd_num);

	String likes(LikesVO likes, MemberVO user);

	String viewLikes(LikesVO likes, MemberVO user);
	
}
