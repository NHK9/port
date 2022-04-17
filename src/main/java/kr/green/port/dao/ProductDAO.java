package kr.green.port.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import kr.green.port.pagination.Criteria;
import kr.green.port.vo.CartVO;
import kr.green.port.vo.CategoryVO;
import kr.green.port.vo.FileVO;
import kr.green.port.vo.OptionList;
import kr.green.port.vo.OptionVO;
import kr.green.port.vo.ProductVO;

public interface ProductDAO {
	List<ProductVO> selectProductList();

	ProductVO getProduct(@Param("pr_code")String pr_code);

	void updateProduct(@Param("product")ProductVO dbProduct);

	List<CategoryVO> getCategory();

	void registerProduct(@Param("product")ProductVO product);

	void deleteProduct(@Param("pr_code")String pr_code);

	void insertOption(@Param("option")OptionVO option);

	ArrayList<OptionList> getOption(@Param("pr_code")String pr_code);

	void updateOption(@Param("option")OptionVO option);

	ArrayList<ProductVO> getProductList2(@Param("cri")Criteria cri);

	int getTotalCount(@Param("type")String type);

	ArrayList<ProductVO> getProductListNew();

	void deleteOption(@Param("op_num")Integer op_num);

	ArrayList<CartVO> getCart(@Param("id")String id);
}
