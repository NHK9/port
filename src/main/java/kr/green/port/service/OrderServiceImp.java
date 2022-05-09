package kr.green.port.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.port.dao.OrderDAO;
import kr.green.port.vo.CartVO;
import kr.green.port.vo.HoldCouponVO;
import kr.green.port.vo.OptionVO;
import kr.green.port.vo.OrderList;
import kr.green.port.vo.OrderListVO;
import kr.green.port.vo.OrderVO;
import kr.green.port.vo.ProductVO;
import kr.green.port.vo.RewardVO;

@Service
public class OrderServiceImp implements OrderService{

	@Autowired
	OrderDAO orderDao;

	@Override
	public String insertCart(CartVO cart) {
		if(cart.getCa_me_id() == null) 
			return "false";
		List<CartVO> list = orderDao.getCart(cart.getCa_me_id());
		for(CartVO tmp:list) {
			if(tmp.getCa_op_num() == cart.getCa_op_num()) {
				orderDao.modifyCart(cart);
				return "true";
			}
		}
		System.out.println(cart);
		orderDao.insertCart(cart);
		return "true";
	}

	@Override
	public ArrayList<ProductVO> getCartList(String id) {
		return orderDao.getCartList(id);
	}

	@Override
	public String deleteCart(Integer ca_num) {
		orderDao.deleteCart(ca_num);
		return "true";
	}

	@Override
	public int getReward(String me_id) {
		return orderDao.getReward(me_id);
	}

	@Override
	public ArrayList<HoldCouponVO> getHoldCoupon(String me_id) {
		return orderDao.getHoldCoupon(me_id);
	}

	@Override
	public void registerOrder(OrderVO order, OrderList list, String me_id) {
		order.setOd_me_id(me_id);
		orderDao.registerOrder(order);
		for(OrderListVO tmp:list.getList()) {
			tmp.setOl_od_num(order.getOd_num());
			orderDao.registerOrderList(tmp);
		}
		orderDao.updateRwCpGr(order.getOd_hc_num(),order.getOd_pay(),order.getOd_useRw(),me_id);
		orderDao.insertRw(order.getOd_addRw(),me_id);
	}

	@Override
	public ArrayList<OrderVO> getOrderList(String me_id) {
		return orderDao.getOrderList(me_id);
	}

	@Override
	public ArrayList<RewardVO> getRewardList(String me_id) {
		return orderDao.getRewardList(me_id);
	}

	@Override
	public ArrayList<HoldCouponVO> getCouponList(String me_id) {
		return orderDao.getCouponList(me_id);
	}

	@Override
	public ArrayList<OrderVO> getOrderListAll() {
		ArrayList<OrderVO> list = new ArrayList<OrderVO>();
		list = orderDao.getOrderListAll();
		System.out.println(list);
		return orderDao.getOrderListAll();
	}

	@Override
	public ArrayList<OrderVO> getOrderDetail(int od_num) {
		return orderDao.getOrderDetail(od_num);
	}

	@Override
	public String modifyOrderState(Integer num,Integer od_num) {
		if(num < 1 || num == null || od_num < 1 || od_num == null) {
			return "no";
		}
		orderDao.modifyOrderState(num,od_num);
		return "ok";
	}
}
