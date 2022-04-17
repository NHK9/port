package kr.green.port.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CouponVO {
	private int cp_num;
	private String cp_code;
	private Date cp_date;
	private int cp_discount;
	private String cp_name;
}