package dao;

import pojo.po.Orders;

import java.util.List;
import java.util.Map;

public interface IOrderDao {
    Integer insert(Orders order);

    List<Map<String,Object>> selectByUserId(Integer orderStatus, String userId);

    Map<String,Object> selectById(String id);

    Integer updateStatus(String id);

    Integer updateStatus(String id,Integer orderStatus);

    Long countOrderByCondition(Map<String, Object> map);

    List<Map<String,Object>> listOrderByPage(Map<String, Object> map);
}
