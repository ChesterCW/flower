package service;

import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Use;

import java.util.List;
import java.util.Map;

public interface UseService {

    List<Use> getAllUse();

    Result<Use> listByPages(Page pages, Use use);

    Use getUseById(String id);

    int modifyUse(Use use);

    int deleteUse(List<String> ids);

    boolean addUse(Use use);

    Result<Map<String,Object>> getCommodityByUseId(String useId, Page page);
}
