package dao;

import pojo.po.CommUse;
import pojo.po.Use;

import java.util.List;

public interface ICommUseDao {
    int insertCommUse(List<String> commUse, String id);

    List<Use> selectUseByCommId(String id);

    Integer deleteByCommId(String id);
}
