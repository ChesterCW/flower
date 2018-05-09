package service;

import java.util.List;
import java.util.Map;

public interface HotService {
    Integer addHotCommodity(List<Map<String,Object>> list);

    List<Map<String, Object>> getHotList();
}
