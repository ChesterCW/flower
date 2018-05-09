package service;

import java.util.List;
import java.util.Map;

import pojo.dto.Order;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Commodity;
import pojo.vo.CommodityQuery;

public interface CommodityService {

    Map<String,Object> getCommodityById(String id);

	Result<Map<String,Object>> listCommodityByPage(Page pages, Order order, CommodityQuery query);

    int modifyCommodity(Commodity commodity);

    int deleteCommodity(List<String> ids);

    int addCommodity(Commodity commodity);

    Result<Map<String, Object>> getCommodityByKindId(String kindId, Page page);
}
