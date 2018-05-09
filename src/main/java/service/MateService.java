package service;

import java.util.List;
import java.util.Map;

import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Materials;

public interface MateService {

	List<Materials> findMateByKindId(String kindId);

	Result<Materials> listByPages(Page pages, Materials materials);

    Materials getMaterialById(String id);

    int modifyMaterials(Materials materials);

    int deleteMaterial(List<String> ids);

    boolean addMaterial(Materials materials);

    List<Materials> getAllUse();

    Result<Map<String,Object>> getCommodityByMateId(String mateId, Page page);
}
