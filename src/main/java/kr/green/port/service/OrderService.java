package kr.green.port.service;

import java.util.ArrayList;
import java.util.List;

import kr.green.port.vo.CartVO;
import kr.green.port.vo.HoldCouponVO;
import kr.green.port.vo.OrderList;
import kr.green.port.vo.OrderVO;
import kr.green.port.vo.ProductVO;
import kr.green.port.vo.RewardVO;

public interface OrderService {

	String insertCart(CartVO cart);

	ArrayList<ProductVO> getCartList(String id);

	String deleteCart(Integer ca_num);

	int getReward(String me_id);

	ArrayList<HoldCouponVO> getHoldCoupon(String me_id);

	void registerOrder(OrderVO order, OrderList list, String me_id);

	ArrayList<OrderVO> getOrderList(String me_id);

	ArrayList<RewardVO> getRewardList(String me_id);
	
	ArrayList<HoldCouponVO> getCouponList(String me_id);

	ArrayList<OrderVO> getOrderListAll();

	ArrayList<OrderVO> getOrderDetail(int od_num);

	String modifyOrderState(Integer num, Integer od_num);

	void cancelOrder(int od_num, int pay, int useRw, int hc_num, String me_id);
}
