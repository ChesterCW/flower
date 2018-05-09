package service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import dao.ICommodityDao;
import pojo.dto.Order;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Commodity;
import pojo.vo.CommodityQuery;
import service.CommodityService;

@Service
@Transactional(isolation=Isolation.READ_COMMITTED,propagation=Propagation.REQUIRED)
public class CommodityServiceImpl implements CommodityService{
	
	@Autowired
	ICommodityDao commodityDao;

	//根据id获取商品
	@Override
	public Map<String,Object> getCommodityById(String id) {
		Map<String,Object> commodity = new HashMap<>();
		try{
			commodity = commodityDao.selectCommodityById(id);
		}catch(Exception e){
			e.printStackTrace();
		}
		return commodity;
	}

	@Override
	public Result<Map<String,Object>> listCommodityByPage(Page page, Order order, CommodityQuery query) {
		Result<Map<String,Object>> result = new Result<>();
        try {
            //构建一个Map用来传递参数给DAO
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("page", page);
            map.put("order", order);
            map.put("query", query);

            Long total = commodityDao.countItemsByCondition(map);
            List<Map<String,Object>> list = commodityDao.listItemsByPage(map);
            //商品总数
            result.setTotal(total);
            //指定页码的商品集合
            result.setRows(list);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
	}

	@Override
	public int modifyCommodity(Commodity commodity) {
		commodity.setStatus(1);
		commodity.setCreatetime(new Date());
		return commodityDao.update(commodity);
	}

	@Override
	public int deleteCommodity(List<String> ids) {
		int record = 0;
		try {
			for (int i = 0; i < ids.size(); i++) {
				commodityDao.updateById(ids.get(i));
			}
			record++;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return record;
	}

	@Override
	public int addCommodity(Commodity commodity) {
		commodity.setStatus(1);
		commodity.setCreatetime(new Date());
		return commodityDao.insert(commodity);
	}

	@Override
	public Result<Map<String, Object>> getCommodityByKindId(String kindId, Page page) {
        Result<Map<String, Object>> result = new Result<>();
        try {
            //构建一个Map用来传递参数给DAO
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("page", page);
            map.put("kindId", kindId);

            Long total = commodityDao.countItemsByKindId(map);
            List<Map<String, Object>> list = commodityDao.listItemsByKindId(map);
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
