package dao;

import pojo.dto.Page;
import pojo.po.Use;

import java.util.List;
import java.util.Map;

public interface IUseDao {

    List<Use> getAllUse();

    Long countItemsByCondition(Page pages, Use use);

    List<Use> listItemsByPage(Page pages, Use use);

    Use selectUseById(String id);

    int update(Use use);

    int batchUpdate(List<String> ids);

    boolean insert(Use use);

    Long countItemsByUseId(Map<String, Object> map);

    List<Map<String,Object>> listItemsByUseId(Map<String, Object> map);
}
