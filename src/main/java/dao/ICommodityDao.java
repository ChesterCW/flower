package dao;

import java.util.List;
import java.util.Map;

import pojo.po.Commodity;

public interface ICommodityDao {

    Map<String,Object> selectCommodityById(String id);

	Long countItemsByCondition(Map<String, Object> map);

	List<Map<String,Object>> listItemsByPage(Map<String, Object> map);

    int update(Commodity commodity);

    void updateById(String s);

    int insert(Commodity commodity);

    Long countItemsByKindId(Map<String, Object> map);

    List<Map<String,Object>> listItemsByKindId(Map<String, Object> map);
}
