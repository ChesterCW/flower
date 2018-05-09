package service;

import java.util.List;
import java.util.Map;

public interface OrderCommodityService {
    Integer addCommodity(List list,String orderId);

    List<Map<String,Object>> getCommodityByOrderId(String id);
}
