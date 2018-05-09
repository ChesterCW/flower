package service.impl;

import dao.ICartDetailDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pojo.po.CartDetail;
import pojo.vo.CartCommodity;
import service.CartDetailService;
import util.IDUtils;

import java.util.List;
import java.util.Map;

@Service
@Transactional(isolation= Isolation.READ_COMMITTED,propagation= Propagation.REQUIRED)
public class CartDetailServiceImpl implements CartDetailService {
    @Autowired
    ICartDetailDao cartDetailDao;
    @Override
    public Integer addCartDetail(String cartId, String commId) {
        CartDetail cartDetail = cartDetailDao.selectByCartIdAndCommId(cartId,commId);
        if (cartDetail != null){
            Integer count = cartDetail.getCount()+1;
            cartDetail.setCount(count);
            cartDetailDao.update(cartDetail);
        }else {
            cartDetail = new CartDetail();
            cartDetail.setId(IDUtils.getItemId()+"");
            cartDetail.setCartId(cartId);
            cartDetail.setCommId(commId);
            cartDetail.setCount(1);
            cartDetail.setStatus(1);
            cartDetailDao.insert(cartDetail);
        }

        return null;
    }

    @Override
    public List<CartCommodity> getCommodity(String cartId) {
        List<CartCommodity> list = cartDetailDao.selectByCartId(cartId);
        return list;
    }

    @Override
    public Integer addCount(String cartId, String commId, Integer count) {
        return cartDetailDao.updateCount(cartId,commId,count);
    }

    @Override
    public Integer deleteCommodity(String cartId, String commId) {
        cartDetailDao.deleteCommodity(cartId,commId);
        return null;
    }

    @Override
    public Integer updateCartId(String id, String cartId) {
        cartDetailDao.updateCartId(id,cartId);
        return null;
    }

    @Override
    public List<Map<String,Object>> getBuyCommodity(String cartId) {
        List<Map<String,Object>> list = cartDetailDao.selectBuyCommodity(cartId);

        return list;
    }

    @Override
    public Integer deleteById(String cartId) {
        return cartDetailDao.deleteByCartId(cartId);
    }

}
