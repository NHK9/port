package kr.green.port.vo;

import java.util.Date;

import lombok.Data;

@Data
public class RewardVO {
	private int rw_num;
	private int rw_price;
	private Date rw_date;
	private String rw_me_id;
	private String rw_desc;
}