package kr.green.port.vo;

import java.util.Date;

import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
public class HoldCouponVO {
	private int hc_num;
	private String hc_state;
	private int hc_cp_num;
	private String hc_me_id;
	private Date hc_date;
	
	private String cp_name;
	private int cp_discount;
}