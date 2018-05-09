package service.impl;

import dao.ICartDao;
import dao.ICartDetailDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pojo.po.Cart;
import pojo.po.CartDetail;
import service.CartDetailService;
import service.CartService;
import util.IDUtils;

import java.util.Date;

@Service
@Transactional(isolation= Isolation.READ_COMMITTED,propagation= Propagation.REQUIRED)
public class CartServiceImpl implements CartService {
    @Autowired
    ICartDao cartDao;
    @Autowired
    CartDetailService cartDetailService;
    @Override
    public Integer addCart(String userId, String cartId, String commId) {
        Cart cart = new Cart();
        String id = IDUtils.getItemId()+"";

        Cart cartByUserId = cartDao.getCartByUserId(userId);

        if (cartByUserId != null){
            cartDetailService.updateCartId(cartByUserId.getId(),cartId);
            cartDetailService.addCartDetail(cartByUserId.getId(),commId);

            return null;
        }
        cart.setId(id);
        cart.setCreateTime(new Date());
        cart.setStatus(1);
        cart.setPayment("0");
        cart.setUserId(userId);

        cartDao.addCart(cart);
        cartDetailService.addCartDetail(id,commId);

        return null;
    }

    @Override
    public Cart getCartByUserId(String userId) {
        return cartDao.getCartByUserId(userId);
    }
}
