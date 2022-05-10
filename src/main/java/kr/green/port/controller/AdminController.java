package kr.green.port.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.green.port.service.AdminService;
import kr.green.port.service.OrderService;
import kr.green.port.service.ProductService;
import kr.green.port.vo.CategoryVO;
import kr.green.port.vo.CouponVO;
import kr.green.port.vo.MemberVO;
import kr.green.port.vo.OptionList;
import kr.green.port.vo.OrderVO;
import kr.green.port.vo.ProductVO;

@Controller
public class AdminController {
	@Autowired
	AdminService adminService;
	@Autowired
	ProductService productService;
	@Autowired
	OrderService orderService;
	
	@RequestMapping("/admin/member/list")
	public ModelAndView adminMemberList(ModelAndView mv
			,HttpServletRequest request) {
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		if(user == null || !user.getMe_authority().equals("슈퍼 관리자")) {
			mv.setViewName("redirect:/");
		}else {
			List<MemberVO> userList = adminService.getMemberList();
			mv.addObject("list", userList);
			mv.setViewName("/admin/member/list");
		}
		return mv;
	}
	@RequestMapping("/admin/product/list")
	public ModelAndView adminProductList(ModelAndView mv
			,HttpServletRequest request) {
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		if(user == null || !user.getMe_authority().equals("슈퍼 관리자")) {
			mv.setViewName("redirect:/");
		}else {
			List<ProductVO> productList = productService.getProductList();
			mv.addObject("list", productList);
			mv.setViewName("/admin/product/list");
		}
		return mv;
	}
	@RequestMapping(value="/admin/product/modify", method=RequestMethod.GET)
	public ModelAndView adminProductModify(ModelAndView mv
			,HttpServletRequest request,String pr_code) {
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		if(user == null || !user.getMe_authority().equals("슈퍼 관리자")) {
			mv.setViewName("redirect:/");
		}else {
			List<CategoryVO> category = productService.getCategoryList();
			mv.addObject("category",category);
			ProductVO product = productService.getProduct(pr_code);
			ArrayList<OptionList> option = productService.getOption(pr_code);
			mv.addObject("product", product);
			mv.addObject("option", option);
			mv.setViewName("/admin/product/modify");
		}
		return mv;
	}
	@RequestMapping(value="admin/product/modify", method=RequestMethod.POST)
	public ModelAndView productModifyPost(ModelAndView mv,ProductVO product,OptionList list,MultipartFile files2) throws Exception {
		productService.updateProduct(product,list,files2);
		List<ProductVO> productList = productService.getProductList();
		mv.addObject("list", productList);
		mv.setViewName("redirect:/admin/product/list");
		return mv;
	}
	@ResponseBody
	@RequestMapping(value = "/admin/update/authority")
	public boolean adminUpdateAuthority(@RequestBody MemberVO member) {
		return adminService.updateAuthority(member);
	}
	@RequestMapping(value="/admin/product/register", method=RequestMethod.GET)
	public ModelAndView adminProductRegisterGet(ModelAndView mv
			,HttpServletRequest request) {
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		if(user == null || !user.getMe_authority().equals("슈퍼 관리자")) {
			mv.setViewName("redirect:/");
		}else {
			List<CategoryVO> category = productService.getCategoryList();
			mv.addObject("category",category);
			mv.setViewName("/admin/product/register");
		}
		return mv;
	}
	@RequestMapping(value="admin/product/register", method=RequestMethod.POST)
	public ModelAndView productRegisterPost(ModelAndView mv,ProductVO product,OptionList list,MultipartFile files2) throws Exception{
		productService.registerProduct(product,list,files2);
		mv.setViewName("redirect:/admin/product/list");
		return mv;
	}
	@ResponseBody
	@RequestMapping(value="admin/product/deleted")
	public String productDeleteGet(String pr_code){
		if(productService.deleteProduct(pr_code))
			return "ok";	
		return "no";
	}
	@ResponseBody
	@RequestMapping(value ="admin/option/deleted")
	public String optionDelete(Integer op_num){
	  return productService.deleteOption(op_num);
	}
	@RequestMapping(value="/admin/product/ordermanage", method=RequestMethod.GET)
		public ModelAndView allOrderGet(ModelAndView mv,HttpServletRequest request){
			MemberVO user = (MemberVO) request.getSession().getAttribute("user");
			if(user == null || !user.getMe_authority().equals("슈퍼 관리자")) {
				mv.setViewName("redirect:/");
			}else {
				ArrayList<OrderVO> list = orderService.getOrderListAll();
				mv.addObject("list",list);
			mv.setViewName("/admin/product/ordermanage");
		}
		return mv;
	}
	@ResponseBody
	@RequestMapping(value ="admin/order/modify")
	public String orderModify(Integer num, Integer od_num){
	  return orderService.modifyOrderState(num,od_num);
	}
	
	@RequestMapping(value="admin/member/coupon")
	public ModelAndView couponManage(ModelAndView mv, HttpServletRequest request) {
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		if(user == null || !user.getMe_authority().equals("슈퍼 관리자")) {
			mv.setViewName("redirect:/");
		}else {
			ArrayList<CouponVO> list = adminService.getCouponList();
			mv.addObject("list",list);
			mv.setViewName("/admin/member/coupon");
		}
		return mv;
	}
	@ResponseBody
	@RequestMapping(value="admin/coupon/deleted")
	public String couponDelete(int cp_num){
		if(productService.deleteCoupon(cp_num))
			return "ok";	
		return "no";
	}
	
	@ResponseBody
	@RequestMapping(value="admin/coupon/issue")
	public String couponIssue(int cp_num,int cases){
		if(adminService.issueCoupon(cp_num,cases))
			return "ok";	
		return "no";
	}
	@RequestMapping(value = "/admin/member/cpRegister", method=RequestMethod.GET)
	public ModelAndView RegisterCouponGet(ModelAndView mv, HttpServletRequest request) {
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		if(user == null || !user.getMe_authority().equals("슈퍼 관리자")) {
			mv.setViewName("redirect:/");
		}else {
			mv.setViewName("/admin/member/cpRegister");
		}
		
		return mv;
	}
	
	@RequestMapping(value = "/admin/member/cpRegister", method=RequestMethod.POST)
	public ModelAndView RegisterCouponPost(ModelAndView mv,String cp_name, String cp_code, int cp_discount) {
		adminService.registerCp(cp_name,cp_code,cp_discount);
		ArrayList<CouponVO> list = adminService.getCouponList();
		mv.addObject("list",list);
		mv.setViewName("/admin/member/coupon");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/codeCheck")
	public String codeCheck(String code) {
		if(adminService.codeCheck(code)) {
			return "ok";
		}
		return "no";
	}
}
