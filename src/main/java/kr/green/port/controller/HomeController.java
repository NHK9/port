package kr.green.port.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.green.port.pagination.Criteria;
import kr.green.port.pagination.PageMaker;
import kr.green.port.service.MemberService;
import kr.green.port.service.OrderService;
import kr.green.port.service.ProductService;
import kr.green.port.vo.BoardVO;
import kr.green.port.vo.CartVO;
import kr.green.port.vo.CategoryVO;
import kr.green.port.vo.HoldCouponVO;
import kr.green.port.vo.MemberVO;
import kr.green.port.vo.OptionList;
import kr.green.port.vo.OptionVO;
import kr.green.port.vo.OrderVO;
import kr.green.port.vo.ProductVO;
import kr.green.port.vo.RewardVO;

@Controller
public class HomeController {
    @Autowired
    MemberService memberService;
    @Autowired
	ProductService productService;
    @Autowired
	OrderService orderService;
    
    
    @RequestMapping(value= "/")
    public ModelAndView openTilesView(ModelAndView mv) throws Exception{
        mv.setViewName("/main/home");
        return mv;
    }
    @RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView loginGet(ModelAndView mv) {
		mv.setViewName("/member/login");
		return mv;
	}
    @RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView loginPost(ModelAndView mv, MemberVO member) {
		MemberVO user = memberService.login(member);
		if(user == null) {
			mv.setViewName("redirect:/login");
		}else {
			mv.addObject("user",user);
			mv.setViewName("redirect:/");
		}
		
		return mv;
	}
    @RequestMapping(value = "/signup", method = RequestMethod.GET)
	public ModelAndView signupGet(ModelAndView mv, MemberVO user) {
		mv.setViewName("/member/signup");
		return mv;
	}
    @RequestMapping(value = "/signup", method = RequestMethod.POST)
	public ModelAndView signupPost(ModelAndView mv, MemberVO user) {
    	if(memberService.signup(user)) {
			mv.setViewName("redirect:/");
		}else {
			mv.setViewName("redirect:/signup");
		}
		return mv;
	}
    @ResponseBody
	@RequestMapping(value ="/idcheck")
	public String ajaxtTest1(String id){
		
		if(!memberService.idDuplicated(id))
			return "ok";
		return "no";
	}
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public ModelAndView logoutGet(ModelAndView mv, 
			HttpServletRequest request, HttpServletResponse response) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		if(user != null) {
			//세션에 있는 유저 정보를 삭제
			request.getSession().removeAttribute("user");
		}
		mv.setViewName("redirect:/");
		return mv;
	}
	@RequestMapping(value = "/mypage")
	public ModelAndView mypageGet(ModelAndView mv, MemberVO input
			,HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		MemberVO newUser = memberService.updateMember(input, user);
		if(newUser != null) {
			request.getSession().setAttribute("user", newUser);
		}
		mv.setViewName("/member/mypage");
		return mv;
	}
	@RequestMapping(value="/product/list", method=RequestMethod.GET)
	public ModelAndView productListGet(ModelAndView mv, String type, Criteria cri) {
		cri.setPerPageNum(10);
		cri.setType(type);
		//페이지메이커를 만들어서 화면에 전달해야함
		int totalCount = productService.getTotalCount(type);
		PageMaker pm = new PageMaker(totalCount, 10, cri);
		mv.addObject("pm",pm);
		ArrayList<ProductVO> list = productService.getProductList2(cri);
		mv.addObject("totalCount",totalCount);
		mv.addObject("type",type);
		mv.addObject("list", list);
		mv.setViewName("/product/list");
		return mv;
	}
	@RequestMapping(value="/product/detail", method=RequestMethod.GET)
	public ModelAndView ProductDetail(ModelAndView mv,String pr_code) {
		ProductVO product = productService.getProduct(pr_code);
		ArrayList<OptionList> option = productService.getOption(pr_code);
		mv.addObject("product", product);
		mv.addObject("option", option);
		mv.setViewName("/product/detail");
		return mv;
	}
	@RequestMapping(value = "/myorder")
	public ModelAndView myorderGet(ModelAndView mv,HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		if(user == null) {
			mv.setViewName("redirect:/login");
		}else {
			ArrayList<OrderVO> list = orderService.getOrderList(user.getMe_id());
			mv.addObject("list",list);
			mv.addObject("user",user);
			mv.setViewName("/member/myorder");
		}
		
		return mv;
	}
	@RequestMapping(value = "/myreward")
	public ModelAndView myreward(ModelAndView mv,HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		if(user == null) {
			mv.setViewName("redirect:/login");
		}else {
			ArrayList<RewardVO> list = orderService.getRewardList(user.getMe_id());
			mv.addObject("list",list);
			mv.addObject("user",user);
			mv.setViewName("/member/myreward");
		}
		
		return mv;
	}
	@RequestMapping(value = "/mycoupon")
	public ModelAndView mycoupon(ModelAndView mv,HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		if(user == null) {
			mv.setViewName("redirect:/login");
		}else {
			ArrayList<HoldCouponVO> list = orderService.getCouponList(user.getMe_id());
			mv.addObject("list",list);
			mv.addObject("user",user);
			mv.setViewName("/member/mycoupon");
		}
		
		return mv;
	}
}
