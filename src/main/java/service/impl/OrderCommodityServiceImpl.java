package service.impl;

import dao.IOrderCommodityDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import service.OrderCommodityService;

import java.util.List;
import java.util.Map;

@Service
@Transactional(isolation= Isolation.READ_COMMITTED,propagation= Propagation.REQUIRED)
public class OrderCommodityServiceImpl implements OrderCommodityService {
    @Autowired
    IOrderCommodityDao orderCommodityDao;
    @Override
    public Integer addCommodity(List list,String orderId) {
        orderCommodityDao.addCommodity(list,orderId);
        return null;
    }

    @Override
    public List<Map<String, Object>> getCommodityByOrderId(String id) {
        return orderCommodityDao.selectCommodityByOrderId(id);
    }
}
