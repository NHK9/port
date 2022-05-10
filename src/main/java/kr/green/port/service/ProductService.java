package kr.green.port.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.green.port.pagination.Criteria;
import kr.green.port.vo.CartVO;
import kr.green.port.vo.CategoryVO;
import kr.green.port.vo.OptionList;
import kr.green.port.vo.OptionVO;
import kr.green.port.vo.ProductVO;

public interface ProductService {
	List<ProductVO> getProductList();
	
	ProductVO getProduct(String pr_code);

	void updateProduct(ProductVO product, OptionList list, MultipartFile files) throws Exception;

	List<CategoryVO> getCategoryList();

	void registerProduct(ProductVO product, OptionList list, MultipartFile files) throws Exception;

	boolean deleteProduct(String pr_code);

	ArrayList<OptionList> getOption(String pr_code);

	ArrayList<ProductVO> getProductList2(Criteria cri);

	int getTotalCount(String type);

	String deleteOption(Integer op_num);

	boolean deleteCoupon(int cp_num);

	int getTotalCountBySearch(Criteria cri);

	ArrayList<ProductVO> getProductListBySearch(Criteria cri);
}