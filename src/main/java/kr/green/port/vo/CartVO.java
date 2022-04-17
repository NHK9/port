package kr.green.port.vo;

import lombok.Data;

@Data
public class CartVO {
	private int ca_num;
	private int ca_amount;
	private int ca_op_num;
	private String ca_me_id;
	private int ca_price;
}