package kr.green.port.vo;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class OptionList {
	List<OptionVO> list = new ArrayList<OptionVO>();
}
