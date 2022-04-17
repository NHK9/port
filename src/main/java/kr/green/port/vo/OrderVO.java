package kr.green.port.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	private int od_num;
	private int od_pay;
	private int od_useRw;
	private Date od_date;
	private String od_state;
	private int od_delivery;
	private String od_me_id;
	private String od_address1;
	private String od_address2;
	private String od_address3;
	private String od_delivery_msg;
	private int od_hc_num;
	private String od_name;
	private String od_phone;
	private String od_email;
	private int od_addRw;
	
	private String pr_name;
	
}