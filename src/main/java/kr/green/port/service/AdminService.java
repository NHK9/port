package kr.green.port.service;

import java.util.List;

import kr.green.port.vo.MemberVO;

public interface AdminService {

	List<MemberVO> getMemberList();

	boolean updateAuthority(MemberVO member);

}
