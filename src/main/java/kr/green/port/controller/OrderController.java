package kr.green.port.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.green.port.service.OrderService;
import kr.green.port.vo.CartList;
import kr.green.port.vo.CartVO;
import kr.green.port.vo.HoldCouponVO;
import kr.green.port.vo.MemberVO;
import kr.green.port.vo.OrderList;
import kr.green.port.vo.OrderListVO;
import kr.green.port.vo.OrderVO;
import kr.green.port.vo.ProductVO;

@Controller
@RequestMapping(value="/order")
public class OrderController {
	@Autowired
	OrderService orderService;
	
	@ResponseBody
	@RequestMapping(value="/cart/insert", method=RequestMethod.POST)
	public String cartInsert(HttpServletRequest request,@RequestBody CartVO cart) {
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		if(user == null || user.getMe_id() == "") {
			return "login";
		}
		if(cart.getCa_op_num() <= 0 || cart.getCa_amount() <= 0) {
			return "false";
		}
		cart.setCa_me_id(user.getMe_id());
		return orderService.insertCart(cart);
	}

	@RequestMapping(value="/cart")
	public ModelAndView getCart(ModelAndView mv,HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		if(user == null) {
			mv.setViewName("redirect:/login");
		}else {
			mv.addObject("user",user);
			ArrayList<ProductVO> cart = orderService.getCartList(user.getMe_id());
			mv.addObject("cart",cart);
			mv.setViewName("/order/cart");
		}
		
		return mv;
	}
	@ResponseBody
	@RequestMapping(value="/cart/deleted")
	public String deleteCart(Integer ca_num) {
		return orderService.deleteCart(ca_num);
	}
	
	@RequestMapping(value="/buy", method=RequestMethod.POST)
	public ModelAndView BuyPost(ModelAndView mv,HttpServletRequest request, CartList list) {
		
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		if(user == null) {
			mv.setViewName("redirect:/login");
		}else {
			ArrayList<ProductVO> list2 = new ArrayList<ProductVO> ();
			for(ProductVO tmp : list.getList()) {
				if(tmp.getOp_colnsize() != null)
					list2.add(tmp);
			}
			//int reward = orderService.getReward(user.getMe_id());
			mv.addObject("list",list2);
			mv.addObject("user",user);
			mv.setViewName("/order/buy");
		}
		
		return mv;
	}
	@RequestMapping(value="/couponPopup")
	public ModelAndView popupTest(ModelAndView mv,HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		ArrayList<HoldCouponVO> list = orderService.getHoldCoupon(user.getMe_id());
		mv.addObject("list",list);
		mv.setViewName("/order/couponPopup");
		return mv;
	}
	@RequestMapping(value="/orderBuy", method=RequestMethod.POST)
	public ModelAndView OrderBuy(ModelAndView mv, HttpServletRequest request, OrderVO order, OrderList list) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		orderService.registerOrder(order,list,user.getMe_id());
		mv.setViewName("redirect:/myorder");
		return mv;
	}
}