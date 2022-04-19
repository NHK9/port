package kr.green.port.service;

import java.util.ArrayList;

import kr.green.port.vo.CartVO;
import kr.green.port.vo.MemberVO;

public interface MemberService {
	
	MemberVO test(String id);

	boolean signup(MemberVO user);

	boolean idDuplicated(String id);

	MemberVO login(MemberVO member);

	MemberVO updateMember(MemberVO input, MemberVO user);
	
	String findId(MemberVO member);

	String findPw(MemberVO member);
}
