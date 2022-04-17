package kr.green.port.vo;

import java.util.Date;

import java.text.SimpleDateFormat;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MemberVO {
	private String me_id;
	private String me_pw;
	private String me_name;
	private String me_gender;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date me_birth;
	private int me_totalbuy;
	private String me_phone;
	private String me_authority;
	private String me_email;
	private String me_address1;
	private String me_address2;
	private String me_address3;
	private String me_gr_num;
	private int me_rw;
	
	public String getMe_birth_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String str = format.format(me_birth);
		return str;
	}
}
