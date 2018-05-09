package dao;

import pojo.po.Hot;

import java.util.List;
import java.util.Map;

public interface IHotDao {
    Integer addHotCommodity(Hot list);

    Hot selectByCommId(String id);

    void update(Hot hot);

    List<Map<String,Object>> selectAll();
}
