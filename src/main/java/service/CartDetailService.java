package service;

import pojo.dto.Result;
import pojo.vo.CartCommodity;

import java.util.List;
import java.util.Map;

public interface CartDetailService {
    Integer addCartDetail(String cartId, String commId);

    List<CartCommodity> getCommodity(String cartId);

    Integer addCount(String cartId, String commId, Integer count);

    Integer deleteCommodity(String cartId, String commId);

    Integer updateCartId(String id, String cartId);

    List<Map<String,Object>> getBuyCommodity(String id);

    Integer deleteById(String cartId);
}
