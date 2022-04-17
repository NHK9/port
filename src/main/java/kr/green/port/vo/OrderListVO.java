package kr.green.port.vo;

import lombok.Data;

@Data
public class OrderListVO {
	private int ol_num;
	private int ol_od_num;
	private int ol_op_num;
	private int ol_amount;
	private int ol_price;
}