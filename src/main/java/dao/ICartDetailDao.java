package dao;

import pojo.po.CartDetail;
import pojo.vo.CartCommodity;

import java.util.List;
import java.util.Map;

public interface ICartDetailDao {
    CartDetail selectByCartIdAndCommId(String cartId,String commId);

    void insert(CartDetail cartDetail);

    boolean update(CartDetail cartDetail);

    List selectByCartId(String cartId);

    Integer updateCount(String cartId, String commId, Integer count);

    Integer deleteCommodity(String cartId, String commId);

    Integer updateCartId(String id, String cartId);

    List<Map<String,Object>> selectBuyCommodity(String cartId);

    Integer deleteByCartId(String cartId);
}
