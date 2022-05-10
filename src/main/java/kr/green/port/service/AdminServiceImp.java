package kr.green.port.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.port.dao.MemberDAO;
import kr.green.port.dao.ProductDAO;
import kr.green.port.vo.CouponVO;
import kr.green.port.vo.MemberVO;

@Service
public class AdminServiceImp implements AdminService{

	@Autowired
	MemberDAO memberDao;
	@Autowired
	ProductDAO productDao;
	
	@Override
	public List<MemberVO> getMemberList() {
		
		return memberDao.selectMemeberList();
	}

	@Override
	public boolean updateAuthority(MemberVO member) {
		if(member == null || member.getMe_id() == null 
				|| member.getMe_authority() == null
				|| member.getMe_authority().equals("슈퍼 관리자"))
			return false;
		MemberVO dbUser = memberDao.getMember(member.getMe_id());
		if(dbUser == null)
			return false;
		dbUser.setMe_authority(member.getMe_authority());
		memberDao.updateMember(dbUser);
		return true;
	}

	@Override
	public ArrayList<CouponVO> getCouponList() {
		return productDao.getCouponList();
	}

	@Override
	public boolean issueCoupon(int cp_num, int cases) {
		ArrayList<String> list = memberDao.getMemberIdAll();
		for(String tmp : list) {
			memberDao.issueCoupon(cp_num,cases,tmp);
		}
		return true;
	}

	@Override
	public void registerCp(String cp_name, String cp_code, int cp_discount) {
		memberDao.registerCp(cp_name,cp_code,cp_discount);
		
	}

	@Override
	public boolean codeCheck(String code) {
		CouponVO a = memberDao.codeCheck(code);
		if(a == null)
			return true;
		return false;
	}
}
