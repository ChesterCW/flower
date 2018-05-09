package service;

import pojo.po.Cart;

public interface CartService {
    Integer addCart(String commId, String cartId, String id);

    Cart getCartByUserId(String id);
}
