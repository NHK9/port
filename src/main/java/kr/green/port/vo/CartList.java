package kr.green.port.vo;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class CartList {
	List<ProductVO> list = new ArrayList<ProductVO>();
}
