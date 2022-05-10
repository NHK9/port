package kr.green.port.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import kr.green.port.dao.ProductDAO;
import kr.green.port.pagination.Criteria;
import kr.green.port.utils.UploadFileUtils;
import kr.green.port.vo.CartVO;
import kr.green.port.vo.CategoryVO;
import kr.green.port.vo.CommentVO;
import kr.green.port.vo.MemberVO;
import kr.green.port.vo.OptionList;
import kr.green.port.vo.OptionVO;
import kr.green.port.vo.ProductVO;

@Service
public class ProductServiceImp implements ProductService{

	@Autowired
	ProductDAO productDao;

	String uploadPath = "D:\\JAVA_KNH\\upload";
	
	@Override
	public List<ProductVO> getProductList() {
		return productDao.selectProductList();
	}
	
	@Override
	public ArrayList<OptionList> getOption(String pr_code) {
		return productDao.getOption(pr_code);
	}

	@Override
	public ProductVO getProduct(String pr_code) {
		return productDao.getProduct(pr_code);
	}

	@Override
	public void updateProduct(ProductVO product,OptionList list, MultipartFile file) {
		ProductVO dbProduct = productDao.getProduct(product.getPr_code());
		uploadFile(file, dbProduct);
		dbProduct.setPr_name(product.getPr_name());
		dbProduct.setPr_price(product.getPr_price());
		dbProduct.setPr_gender(product.getPr_gender());
		dbProduct.setPr_discount(product.getPr_discount());
		dbProduct.setPr_desc(product.getPr_desc());
		dbProduct.setPr_cg_name(product.getPr_cg_name());
		
		productDao.updateProduct(dbProduct);
		insertOption(dbProduct, list);
	}

	@Override
	public List<CategoryVO> getCategoryList() {
		return productDao.getCategory();
	}

	@Override
	public void registerProduct(ProductVO product,OptionList list,MultipartFile file) {
		//썸네일 이미지 files 실제 서버에 업로드
		
		//업로드한 경로를 product.setPr_img(경로)로 설정
		uploadFile(file, product);
		productDao.registerProduct(product);
		insertOption(product,list);
		//option.setOp_pr_code(product.getPr_code());
		//productDao.insertOption(option);
	}
	
	private void insertOption(ProductVO product, OptionList list) {
		for(OptionVO tmp:list.getList()) {
			if(tmp.getOp_pr_code() != null) {
				productDao.updateOption(tmp);
			}else {
				tmp.setOp_pr_code(product.getPr_code());
				productDao.insertOption(tmp);				
			}
		}
	}
	
	@Override
	public boolean deleteProduct(String pr_code) {
		productDao.deleteProduct(pr_code);
		return true;
	}
	
	private void uploadFile(MultipartFile file, ProductVO pro) {
		if(file == null || file.getOriginalFilename().length() == 0)
			return;
		
		
		try {
			String path = 
			UploadFileUtils.uploadFile(
				uploadPath, 
				file.getOriginalFilename(), 
				file.getBytes());
			pro.setPr_img(path);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public ArrayList<ProductVO> getProductList2(Criteria cri){
		if(cri.getType() == null) {
			//전체 상품 검색
			//return 전체상품;
			//type이 제품 카테고리명에 해당하는 경우		
		}
		if(cri.getType().equals("mens") || cri.getType().equals("women") 
				|| cri.getType().equals("cosmetic") || cri.getType().equals("shoes")
				|| cri.getType().equals("acc")) {
			//select * from xxx where 카테고리 = type
			return productDao.getProductList2(cri);// 일치하는 상품들을 가져옴
		}
		if(cri.getType().equals("new")) {
			//return 최근 한달사이에 등록된 제품들 가져오김
			return productDao.getProductListNew();
		}
		if(cri.getType().equals("베스트")) {
			//return 최근 한달상이에 많이 판매된제품들가져오기
		}
		return null;
	}

	@Override
	public int getTotalCount(String type) {
		return productDao.getTotalCount(type);
	}
	@Override
	public String deleteOption(Integer op_num) {
		if(op_num <= 0) {
			return "no";			
		}
		productDao.deleteOption(op_num);
		return "ok";
	}

	@Override
	public boolean deleteCoupon(int cp_num) {
		productDao.deleteCoupon(cp_num);
		return true;
	}
}
