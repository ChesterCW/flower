package dao;

import java.util.List;
import java.util.Map;

import pojo.dto.Page;
import pojo.po.Materials;

public interface IMaterialsDao {

	List<Materials> selectMateByKindId(String kindId);

    Long countItemsByCondition(Page pages, Materials materials);

    List<Materials> listItemsByPage(Page pages, Materials materials);

    Materials selectMaterialById(String id);

    int update(Materials materials);

    int batchUpdate(List<String> ids);

    boolean insert(Materials materials);

    List<Materials> selectAll();

    Long countItemsByMateId(Map<String, Object> map);

    List<Map<String,Object>> listItemsByMateId(Map<String, Object> map);
}
