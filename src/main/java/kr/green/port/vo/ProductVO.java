package kr.green.port.vo;

import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
public class ProductVO {
	private String pr_code;
	private String pr_name;
	private int pr_price;
	private String pr_gender;
	private String pr_img;
	private int pr_discount;
	private String pr_desc;
	private String pr_cg_name;
	
	private int op_num;
	private int ca_num;
	private int ca_amount;//장바구니 수량
	private int ca_price;//장바구니 금액
	private String op_colnsize;
	
	public int getPr_discount_price(){
		return (int)(pr_price*(100 - pr_discount) / 100.0);
	}
	public int getCartPrice(){
		return (int)(ca_price * ca_amount);
	}
}
