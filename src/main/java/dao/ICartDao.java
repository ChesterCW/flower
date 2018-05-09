package dao;

import pojo.po.Cart;

public interface ICartDao {
    void addCart(Cart cart);

    Cart getCartByUserId(String userId);
}
