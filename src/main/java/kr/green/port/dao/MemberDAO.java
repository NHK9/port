package kr.green.port.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.green.port.vo.MemberVO;

public interface MemberDAO {
	MemberVO test(@Param("id")String id);

	void insertMember(@Param("user")MemberVO user);

	MemberVO getMember(@Param("me_id")String me_id);

	void updateMember(@Param("user")MemberVO input);

	List<MemberVO> selectMemeberList();
}
