package kr.green.port.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.green.port.vo.CouponVO;
import kr.green.port.vo.MemberVO;

public interface MemberDAO {
	MemberVO test(@Param("id")String id);

	void insertMember(@Param("user")MemberVO user);

	MemberVO getMember(@Param("me_id")String me_id);

	void updateMember(@Param("user")MemberVO input);

	List<MemberVO> selectMemeberList();

	MemberVO findMember(@Param("user")MemberVO member);

	ArrayList<String> getMemberIdAll();

	void issueCoupon(@Param("cp_num")int cp_num, @Param("cases")int cases, @Param("id")String tmp);

	void registerCp(@Param("cp_name")String cp_name, @Param("cp_code")String cp_code, @Param("cp_discount")int cp_discount);

	CouponVO codeCheck(@Param("code")String code);
}
