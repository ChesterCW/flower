package service.impl;

import dao.IOrderDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pojo.dto.Order;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Orders;
import service.OrderService;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(isolation= Isolation.READ_COMMITTED,propagation= Propagation.REQUIRED)
public class OrderServiceImpl implements OrderService {
    @Autowired
    IOrderDao orderDao;
    @Override
    public Integer addOrder(Orders order) {
        order.setCreateTime(new Date());
        //未付款状态
        order.setOrderStatus(1);
        //在线支付
        order.setPaymentType(1);
        order.setPostFee("10");
        order.setStatus(1);
        order.setUpdateTime(new Date());



        return orderDao.insert(order);
    }

    @Override
    public List<Map<String, Object>> getOrderListByUserId(Integer orderStatus, String userId) {
        return orderDao.selectByUserId(orderStatus,userId);
    }

    @Override
    public Map<String, Object> getOrderById(String id) {
        return orderDao.selectById(id);
    }

    @Override
    public Integer updateStatus(String id) {
        return orderDao.updateStatus(id);
    }

    @Override
    public Integer modifyOrder(String id,Integer orderStatus) {
        return orderDao.updateStatus(id,orderStatus);
    }

    @Override
    public Result<Map<String, Object>> listOrderByPage(Page pages, Order order, Orders query) {
        Result<Map<String,Object>> result = new Result<>();
        try {
            //构建一个Map用来传递参数给DAO
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("page", pages);
            map.put("order", order);
            map.put("query", query);

            Long total = orderDao.countOrderByCondition(map);
            List<Map<String,Object>> list = orderDao.listOrderByPage(map);
            //商品总数
            result.setTotal(total);
            //指定页码的商品集合
            result.setRows(list);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


}
