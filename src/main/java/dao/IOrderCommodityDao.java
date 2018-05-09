package dao;

import pojo.vo.CartCommodity;

import java.util.List;
import java.util.Map;

public interface IOrderCommodityDao {
    Integer addCommodity(List<Map<String,Object>> list, String orderId);

    List<Map<String,Object>> selectCommodityByOrderId(String id);
}
