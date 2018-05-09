package service;

import pojo.dto.Order;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Orders;

import java.util.List;
import java.util.Map;

public interface OrderService {
    Integer addOrder(Orders order);

    List<Map<String,Object>> getOrderListByUserId(Integer orderStatus, String id);

    Map<String,Object> getOrderById(String id);

    Integer updateStatus(String id);

    Integer modifyOrder(String id,Integer orderStatus);

    Result<Map<String,Object>> listOrderByPage(Page pages, Order order, Orders query);
}
