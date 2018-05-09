package dao.impl;

import dao.ICartDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;
import pojo.po.Cart;

import java.util.List;
@Repository
public class CartDao implements ICartDao {
    @Autowired
    HibernateTemplate temp;

    @Override
    public void addCart(Cart cart) {
        temp.save(cart);
    }

    @Override
    public Cart getCartByUserId(String userId) {
        List cartList = temp.find("from Cart where userId ="+userId);
        if (cartList.size() > 0){
            return (Cart) cartList.get(0);
        }
        return null;
    }
}
