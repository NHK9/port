package kr.green.port.service;

import java.util.ArrayList;
import java.util.List;

import kr.green.port.vo.CouponVO;
import kr.green.port.vo.MemberVO;

public interface AdminService {

	List<MemberVO> getMemberList();

	boolean updateAuthority(MemberVO member);

	ArrayList<CouponVO> getCouponList();

	boolean issueCoupon(int cp_num, int cases);

	void registerCp(String cp_name, String cp_code, int cp_discount);

	boolean codeCheck(String code);

}
