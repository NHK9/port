package kr.green.port.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.green.port.vo.CartVO;
import kr.green.port.vo.HoldCouponVO;
import kr.green.port.vo.OrderList;
import kr.green.port.vo.OrderListVO;
import kr.green.port.vo.OrderVO;
import kr.green.port.vo.ProductVO;
import kr.green.port.vo.RewardVO;

public interface OrderDAO {

	void insertCart(@Param("cart")CartVO cart);

	ArrayList<ProductVO> getCartList(@Param("id")String id);

	void deleteCart(@Param("ca_num")Integer ca_num);

	List<CartVO> getCart(@Param("id")String id);

	void modifyCart(@Param("cart")CartVO cart);

	int getReward(@Param("id")String me_id);

	ArrayList<HoldCouponVO> getHoldCoupon(@Param("id")String me_id);

	void registerOrder(@Param("o")OrderVO order);

	void registerOrderList(@Param("list")OrderListVO tmp);

	ArrayList<OrderVO> getOrderList(@Param("id")String me_id);

	void insertRw(@Param("addRw")int od_addRw, @Param("id")String me_id);

	void updateRwCpGr(@Param("hcNum") int od_hc_num, @Param("pay")int od_pay, @Param("useRw")int od_useRw, @Param("id")String me_id);
	
	ArrayList<RewardVO> getRewardList(@Param("id")String me_id);

	ArrayList<HoldCouponVO> getCouponList(@Param("id")String me_id);

	ArrayList<OrderVO> getOrderListAll();

	ArrayList<OrderVO> getOrderDetail(@Param("od_num")int od_num);

	void modifyOrderState(@Param("num")Integer num,@Param("od_num")Integer od_num);
}
